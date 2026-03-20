import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/private_message_model.dart';
import 'package:filmaniak/page/messages/private_chat_page.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';

class PrivateConversationsPage extends StatefulWidget {
  const PrivateConversationsPage({super.key});

  @override
  State<PrivateConversationsPage> createState() => _PrivateConversationsPageState();
}

class _PrivateConversationsPageState extends State<PrivateConversationsPage> {
  final List<Conversation> _conversations = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  static const int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({bool refresh = true}) async {
    if (refresh) {
      setState(() { _loading = true; _conversations.clear(); _hasMore = true; });
    }
    final result = await FilmaniakApi.getConversations(limit: _pageSize, offset: 0);
    if (!mounted) return;
    setState(() {
      _conversations.addAll(result);
      _hasMore = result.length >= _pageSize;
      _loading = false;
    });
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;
    setState(() => _loadingMore = true);
    final result = await FilmaniakApi.getConversations(
      limit: _pageSize, offset: _conversations.length);
    if (!mounted) return;
    setState(() {
      _conversations.addAll(result);
      _hasMore = result.length >= _pageSize;
      _loadingMore = false;
    });
  }

  void _openChat(Conversation conv) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrivateChatPage(
          recipientId: conv.otherUser.id,
          recipientUsername: conv.otherUser.username,
          recipientAvatarUrl: conv.otherUser.avatarUrl,
        ),
      ),
    ).then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.privateMessages),
        centerTitle: false,
        actions: [
          if (isDesktop)
            Tooltip(
              message: S.current.buttonReloadNotifications,
              child: IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: _load,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _conversations.isEmpty
                ? emptyDataWidget(
                    context,
                    Icons.mail_outline_rounded,
                    S.current.messagesEmpty,
                    '',
                  )
                : RefreshIndicator(
                    onRefresh: () => _load(),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _conversations.length + (_hasMore ? 1 : 0),
                      itemBuilder: (ctx, i) {
                        if (i == _conversations.length) {
                          _loadMore();
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _ConversationTile(
                          conv: _conversations[i],
                          onTap: () => _openChat(_conversations[i]),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conv;
  final VoidCallback onTap;

  const _ConversationTile({required this.conv, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final last = conv.lastMessage;

    final timestamp = last.editedAt ?? last.createdAt;
    final isMessageDeleted = last.isDeleted;
    final preview = isMessageDeleted
        ? S.current.messagesDeleted
        : (last.content ?? '');

    final isOurMessage = last.senderId == globalCurrentUser.id;
    final showSentReadIcons = isOurMessage && !isMessageDeleted;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Card(
          margin: const EdgeInsets.only(bottom: 8),
          color: conv.hasUnread
              ? Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.3)
              : null,
          elevation: conv.hasUnread ? 2 : 1,
          child: ListTile(
            leading: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: userAvatar(
                    context,
                    avatarUrl: conv.otherUser.avatarUrl,
                    username: conv.otherUser.username,
                    size: 50,
                  ),
                ),
                if (conv.hasUnread)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              conv.otherUser.username ,
              style: TextStyle(
                fontWeight: conv.hasUnread ? FontWeight.bold : FontWeight.normal,
                
              ),maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preview ,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontStyle:
                        isMessageDeleted ? FontStyle.italic : FontStyle.normal,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (showSentReadIcons) ...[
                      Icon(
                        last.isRead ? Icons.done_all : Icons.done,
                        size: 16,
                        color: last.isRead
                            ? Theme.of(context).colorScheme.tertiary
                            : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Expanded(
                      child: Text(
                        formatMessageTimestamp(timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.55),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
