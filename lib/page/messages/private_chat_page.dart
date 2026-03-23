import 'dart:async';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:invitaty/api/invitaty_api.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/model/private_message_model.dart';
import 'package:invitaty/widget/components_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey, KeyDownEvent;
// Intl se usa a través de helpers en `global_functions.dart`.

class PrivateChatPage extends StatefulWidget {
  final int recipientId;
  final String recipientUsername;
  final String recipientAvatarUrl;

  const PrivateChatPage({
    super.key,
    required this.recipientId,
    required this.recipientUsername,
    required this.recipientAvatarUrl,
  });

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final List<PrivateMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _inputFocus = FocusNode();
  Timer? _refreshTimer;

  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  bool _sending = false;
  bool _showEmoji = false;

  // Cursor para el polling delta
  String? _lastCreatedAt;

  // Estado de edición
  PrivateMessage? _editingMessage;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _startPolling();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _inputController.dispose();
    _scrollController.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  // =========================================================
  // CARGA
  // =========================================================

  Future<void> _loadInitial() async {
    setState(() => _loading = true);
    final msgs = await InvitatyApi.getMessages(otherUserId: widget.recipientId);
    if (!mounted) return;
    setState(() {
      _messages.clear();
      _messages.addAll(msgs);
      _hasMore = msgs.length >= 50;
      _updateCursor();
      _loading = false;
    });
    // Sincronizar "checks" iniciales (read receipts) sin esperar al siguiente tick.
    _updateReadStatus();
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore || _messages.isEmpty) return;
    setState(() => _loadingMore = true);
    final oldest = _messages.last.id;
    final msgs = await InvitatyApi.getMessages(
      otherUserId: widget.recipientId, beforeId: oldest);
    if (!mounted) return;
    setState(() {
      _messages.addAll(msgs);
      _hasMore = msgs.length >= 50;
      _loadingMore = false;
    });
  }

  // =========================================================
  // POLLING (5 segundos)
  // =========================================================

  void _startPolling() {
    _refreshTimer =
        Timer.periodic(const Duration(seconds: 5), (_) async {
      if (!mounted) return;
      try {
        await _pollDelta();
      } catch (_) {
        // Si falla el polling por red/parseo, no cortamos el timer.
      }
      try {
        await _updateReadStatus();
      } catch (_) {
        // Igual: no romper el ciclo de refresco.
      }
    });
  }

  Future<void> _pollDelta() async {
    if (_lastCreatedAt == null) return;
    final delta = await InvitatyApi.getMessages(
      otherUserId: widget.recipientId, afterCreated: _lastCreatedAt);
    if (!mounted || delta.isEmpty) return;

    setState(() {
      for (final incoming in delta) {
        final idx = _messages.indexWhere((m) => m.id == incoming.id);
        if (idx >= 0) {
          _messages[idx] = incoming;
        } else {
          _messages.insert(0, incoming);
        }
      }
      _updateCursor();
    });
  }

  void _updateCursor() {
    if (_messages.isEmpty) return;
    DateTime latest = _messages.first.latestTimestamp;
    for (final m in _messages) {
      if (m.latestTimestamp.isAfter(latest)) latest = m.latestTimestamp;
    }
    _lastCreatedAt = latest.toUtc().toIso8601String();
  }

  // =========================================================
  // CHECKS / READ RECEIPTS
  // =========================================================
  //
  // Fitcron hace esto: aunque no lleguen mensajes nuevos, si el destinatario
  // ya ha leído el último mensaje, entonces marca como leídos (is_read=1)
  // todos tus mensajes pendientes para que aparezcan los checks sin recargar.
  Future<void> _updateReadStatus() async {
    if (_messages.isEmpty) return;

    // Solo tiene sentido si hay al menos un mensaje tuyo aún no leído.
    final hasUnreadMine = _messages.any(
      (m) => m.senderId == globalCurrentUser.id && !m.isRead,
    );
    if (!hasUnreadMine) return;

    final isRead = await InvitatyApi.getMessageReadStatus(widget.recipientId);
    if (!mounted) return;
    if (isRead != true) return;

    bool changed = false;
    for (int i = 0; i < _messages.length; i++) {
      final m = _messages[i];
      if (m.senderId == globalCurrentUser.id && !m.isRead) {
        _messages[i] = m.copyWith(isRead: true);
        changed = true;
      }
    }

    if (changed) setState(() {});
  }

  // =========================================================
  // ENVIAR / EDITAR
  // =========================================================

  Future<void> _submit() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _sending) return;

    if (_editingMessage != null) {
      await _confirmEdit(text);
    } else {
      await _sendNew(text);
    }
  }

  Future<void> _sendNew(String text) async {
    setState(() => _sending = true);
    _inputController.clear();
    final msg = await InvitatyApi.sendMessage(
      recipientId: widget.recipientId, message: text);
    if (!mounted) return;
    setState(() {
      _sending = false;
      if (msg != null) {
        // Evitar duplicados en la UI (por polling / respuestas).
        final idx = _messages.indexWhere((m) => m.id == msg.id);
        if (idx >= 0) {
          _messages[idx] = msg;
        } else {
          _messages.insert(0, msg);
        }
        _updateCursor();
      } else {
        showCustomSnackBar(S.current.messagesErrorSend, type: -1);
      }
    });
  }

  Future<void> _confirmEdit(String text) async {
    final msg = _editingMessage!;
    setState(() { _sending = true; _editingMessage = null; });
    _inputController.clear();
    final ok = await InvitatyApi.editMessage(id: msg.id, message: text);
    if (!mounted) return;
    setState(() => _sending = false);
    if (!ok) showCustomSnackBar(S.current.messagesErrorEdit, type: -1);
  }

  void _startEdit(PrivateMessage msg) {
    setState(() => _editingMessage = msg);
    _inputController.text = msg.message ?? '';
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: _inputController.text.length));
  }

  void _cancelEdit() {
    setState(() => _editingMessage = null);
    _inputController.clear();
  }

  Future<void> _deleteMessage(PrivateMessage msg) async {
    final ok = await InvitatyApi.deleteMessage(msg.id);
    if (!mounted) return;
    if (!ok) {
      showCustomSnackBar(S.current.messagesErrorDelete, type: -1);
    }
  }

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Emula Fitcron: si el picker está desplegado, tocando fuera se cierra.
        if (_showEmoji) {
          setState(() => _showEmoji = false);
        } else {
          unFocusGlobal();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              userAvatar(
                context,
                avatarUrl: widget.recipientAvatarUrl,
                username: widget.recipientUsername,
                size: 36,
              ),
              const SizedBox(width: 10),
              Text(widget.recipientUsername),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _messages.isEmpty
                      ? Center(child: Text(S.current.messagesNoMessages))
                      : NotificationListener<ScrollNotification>(
                          onNotification: (n) {
                            if (n.metrics.pixels >=
                                n.metrics.maxScrollExtent - 200) {
                              _loadMore();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            itemCount:
                                _messages.length + (_loadingMore ? 1 : 0),
                            itemBuilder: (ctx, i) {
                              if (i == _messages.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              final msg = _messages[i];
                              final isMe = msg.senderId == globalCurrentUser.id;
                              return _MessageBubble(
                                msg: msg,
                                isMe: isMe,
                                // Fitcron: mostrar checks en todos los mensajes tuyos.
                                showReadStatus: isMe,
                                isRead: msg.isRead,
                                onLongPress: isMe && !msg.isDeleted
                                    ? () => _showMessageMenu(ctx, msg)
                                    : null,
                              );
                            },
                          ),
                        ),
            ),
            _buildInput(),
          ],
        ),
      ),
    );
  }

  void _toggleEmoji() {
    setState(() => _showEmoji = !_showEmoji);
    if (_showEmoji) {
      _inputFocus.unfocus();
    } else {
      _inputFocus.requestFocus();
    }
  }

  void _insertEmoji(String emoji) {
    final ctrl = _inputController;
    final sel = ctrl.selection;
    final text = ctrl.text;
    final newText = sel.isValid
        ? text.replaceRange(sel.start, sel.end, emoji)
        : text + emoji;
    final newOffset = sel.isValid ? sel.start + emoji.length : newText.length;
    ctrl.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  Widget _buildInput() {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(
            top: BorderSide(color: scheme.outline.withValues(alpha: 0.3)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Banner de edición
            if (_editingMessage != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                margin: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.edit, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _editingMessage!.message ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: _cancelEdit,
                    ),
                  ],
                ),
              ),

            // Fila de input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  // Botón emoji
                  IconButton(
                      icon: Icon(
                        _showEmoji ? Icons.keyboard_rounded : Icons.emoji_emotions_outlined,
                        color: scheme.secondary,
                      ),
                      onPressed: _toggleEmoji,
                    ),
                  Expanded(
                    child: Focus(
                      canRequestFocus: true,
                      onKeyEvent: (node, event) {
                        // En desktop: ENTER envia, SHIFT+ENTER mete salto de línea.
                        final isDesktop = kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;
                        if (!isDesktop) return KeyEventResult.ignored;

                        if (event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.enter) {
                          // Si el emoji picker está abierto, lo cerramos
                          // (y no enviamos para evitar clicks raros).
                          if (_showEmoji) {
                            setState(() => _showEmoji = false);
                            return KeyEventResult.handled;
                          }

                          unawaited(_submit());
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: TextField(
                        controller: _inputController,
                        focusNode: _inputFocus,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.sentences,
                        onTap: () {
                          if (_showEmoji) setState(() => _showEmoji = false);
                        },
                        decoration: InputDecoration(
                          hintText: S.current.messagesTypeHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _sending
                      ? const SizedBox(
                          width: 42,
                          height: 42,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : IconButton.filled(
                          icon: Icon(_editingMessage != null
                              ? Icons.check_rounded
                              : Icons.send_rounded),
                          onPressed: _submit,
                        ),
                ],
              ),
            ),

            // Emoji picker
            if (_showEmoji)
              EmojiPicker(
                onEmojiSelected: (_, emoji) => _insertEmoji(emoji.emoji),
                config: Config(
                  height: 280,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    columns: MediaQuery.of(context).size.width > 800 ? 16 : 9,
                    emojiSizeMax: 32,
                    backgroundColor: Colors.transparent,
                  ),
                  categoryViewConfig: CategoryViewConfig(
                    backgroundColor: scheme.primary,
                    // Igual que Fitcron: iconos de categorías usando `primaryFixed`.
                    iconColor: scheme.onPrimary,
                    iconColorSelected: scheme.secondary,
                    indicatorColor: scheme.secondary,
                  ),
                  bottomActionBarConfig: const BottomActionBarConfig(
                    enabled: false,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showMessageMenu(BuildContext ctx, PrivateMessage msg) {
    // Mismo estilo que Fitcron: PopupMenu arriba/derecha y cerrar al pinchar fuera.
    showMenu<String>(
      context: ctx,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(ctx).size.width - 200,
        0,
        0,
        0,
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit_rounded, size: 20),
              const SizedBox(width: 8),
              Text(
                S.current.messagesEdit,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_rounded,
                size: 20,
                color: Theme.of(ctx).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Text(
                S.current.messagesDelete,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(ctx).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'edit') {
        _startEdit(msg);
      } else if (value == 'delete') {
        _confirmDelete(msg);
      }
    });
  }

  void _confirmDelete(PrivateMessage msg) {
    showConfirmDialogGlobal(
      context,
      title: S.current.messagesDelete,
      message: S.current.messagesDeleteConfirm,
      destructive: true,
    ).then((confirmed) {
      if (confirmed) _deleteMessage(msg);
    });
  }
}

// =========================================================
// BURBUJA DE MENSAJE
// =========================================================

class _MessageBubble extends StatelessWidget {
  final PrivateMessage msg;
  final bool isMe;
  final bool showReadStatus;
  final bool? isRead;
  final VoidCallback? onLongPress;

  const _MessageBubble({
    required this.msg,
    required this.isMe,
    required this.showReadStatus,
    this.isRead,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDeleted = msg.isDeleted;
    // En algunos temas `surfaceContainerHighest` puede coincidir con el
    // fondo. Para que se distingan, usamos un tinte basado en `onSurface`.
    final bgColor = isMe
        ? scheme.primary
        : scheme.onSurface.withValues(alpha: scheme.brightness == Brightness.dark ? 0.08 : 0.06);
    final deletedBgColor = scheme.onSurface.withValues(
      alpha: scheme.brightness == Brightness.dark ? 0.06 : 0.03,
    );
    final fgColor = isDeleted ? scheme.onSurface : (isMe ? scheme.onPrimary : scheme.onSurface);

    final showEditedTime = msg.isEdited && !msg.isDeleted && msg.editedAt != null;
    final timestamp = showEditedTime ? msg.editedAt! : msg.createdAt;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72,
          ),
          margin: const EdgeInsets.symmetric(vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: msg.isDeleted
                ? deletedBgColor
                : bgColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 16),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (msg.isDeleted)
                Text(
                  S.current.messagesDeleted,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: fgColor.withValues(alpha: 0.55),
                    fontSize: 14,
                  ),
                )
              else
                Text(
                  msg.message ?? '',
                  style: TextStyle(color: fgColor, fontSize: 15),
                ),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatMessageTimestamp(timestamp),
                    style: TextStyle(
                      fontSize: 11,
                      color: fgColor.withValues(alpha: 0.6),
                    ),
                  ),
                  if (msg.isEdited && !msg.isDeleted) ...[
                    const SizedBox(width: 4),
                    Text(
                      S.current.messagesEdited,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: fgColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                  if (showReadStatus && !msg.isDeleted && isRead != null) ...[
                    const SizedBox(width: 4),
                    Icon(
                      isRead! ? Icons.done_all : Icons.done,
                      size: 18,
                      color: isRead!
                          ? scheme.secondary
                          : fgColor.withValues(alpha: 0.55),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
