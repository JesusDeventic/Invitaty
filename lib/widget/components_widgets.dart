import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/main.dart';
import 'package:invitaty/page/users/version_changelog_page.dart';
import 'package:invitaty/providers/language_provider.dart';
import 'package:invitaty/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

void showCustomSnackBar(String message, {int? type}) {
  Color? backgroundColor;
  Color? textColor;
  switch (type) {
    case -1:
      backgroundColor = Colors.red[900];
      textColor = Colors.white;
      break;
    case 1:
      backgroundColor = Colors.green[700];
      textColor = Colors.white;
      break;
    default:
      break;
  }
  final snack = SnackBar(
    duration: const Duration(seconds: 3),
    elevation: 10,
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.fixed,
    content: GestureDetector(
      onTap: () {
        scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 60),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  final messenger = scaffoldMessengerKey.currentState;
  if (messenger != null) {
    messenger.showSnackBar(snack);
  } else {
    final ctx = navigatorKey.currentContext;
    if (ctx != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(snack);
    }
  }
}

/// Diálogo de confirmación reutilizable con estilo consistente en toda la app.
Future<bool> showConfirmDialogGlobal(
  BuildContext context, {
  required String title,
  required String message,
  bool destructive = false,
}) async {
  final screenWidth = MediaQuery.of(context).size.width;
  final dialogHInset = ((screenWidth - 800) / 2).clamp(16.0, double.infinity);

  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: dialogHInset, vertical: 24),
      title: Text(title),
      content: Text(message),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(S.current.buttonCancel),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                style: destructive
                    ? ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(ctx).colorScheme.error,
                        ),
                      )
                    : null,
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(S.current.buttonConfirm),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  return result == true;
}

/// Diálogo informativo (un solo botón), mismo ancho y márgenes que
/// [showConfirmDialogGlobal].
Future<void> showInfoDialogGlobal(
  BuildContext context, {
  required String title,
  required String message,
  String? actionLabel,
}) async {
  final screenWidth = MediaQuery.of(context).size.width;
  final dialogHInset = ((screenWidth - 800) / 2).clamp(16.0, double.infinity);

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: dialogHInset, vertical: 24),
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(actionLabel ?? S.current.buttonClose),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Avatar del usuario: usa [avatarUrl] si existe (Gravatar/MonsterID/etc. de WP),
/// o la inicial del username como fallback.
Widget userAvatar(
  BuildContext context, {
  required String avatarUrl,
  required String username,
  double size = 40,
}) {
  // Para evitar "halos" de color (píxeles rosados) en imágenes con alpha,
  // recortamos con `ClipOval` y evitamos el borde del `Container`.
  return ClipOval(
    child: SizedBox(
      width: size,
      height: size,
      child: avatarUrl.isNotEmpty
          ? Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) => _buildInitialAvatar(
                context,
                username,
                size,
              ),
            )
          : _buildInitialAvatar(context, username, size),
    ),
  );
}

/// Avatar reutilizable inspirado en Fitcron.
///
/// - Si `disableOnTap` es `true` (o no hay `avatarUrl/username`), solo muestra el avatar.
/// - Si permite tap, abre un modal inferior con la imagen del avatar en grande.
Widget avatarWidget(
  String avatarUrl,
  BuildContext context,
  String username, {
  bool disableOnTap = false,
  double size = 40,
}) {
  final cleanUsername = username.trim();
  final cleanAvatarUrl = avatarUrl.trim();

  if (disableOnTap || cleanAvatarUrl.isEmpty || cleanUsername.isEmpty) {
    return userAvatar(
      context,
      avatarUrl: cleanAvatarUrl,
      username: cleanUsername,
      size: size,
    );
  }

  return GestureDetector(
    onTap: () => _showAvatarModal(context, cleanAvatarUrl, cleanUsername),
    child: userAvatar(
      context,
      avatarUrl: cleanAvatarUrl,
      username: cleanUsername,
      size: size,
    ),
  );
}

/// Hoja inferior arrastrable con barra, cabecera [primary] y cierre (mismo
/// patrón que el avatar en grande). Reutilizable para QR, imágenes, etc.
Future<void> _showDraggableAppSheet(
  BuildContext context, {
  required String title,
  required Widget Function(ScrollController scrollController) bodyBuilder,
  double initialChildSize = 0.9,
  double minChildSize = 0.5,
  double maxChildSize = 0.9,
  double titleFontSize = 20,
}) {
  unFocusGlobal();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext sheetCtx) {
      return SafeArea(
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (context, scrollController) {
            final theme = Theme.of(context);
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600,
                  maxHeight: MediaQuery.of(context).size.height * 0.95,
                ),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.inverseSurface
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              color: theme.colorScheme.onPrimary,
                              size: 30,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            padding: const EdgeInsets.all(8),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: bodyBuilder(scrollController),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

void _showAvatarModal(BuildContext context, String imageUrl, String name) {
  _showDraggableAppSheet(
    context,
    title: name,
    bodyBuilder: (scrollController) => SingleChildScrollView(
      controller: scrollController,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 280,
            height: 280,
            child: imageUrl.isEmpty
                ? _buildInitialAvatar(context, name, 280)
                : Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        _buildInitialAvatar(context, name, 280),
                  ),
          ),
        ),
      ),
    ),
  );
}

/// QR del enlace + copiar enlace + compartir en una sola hoja (mismo estilo
/// que el avatar: arrastre, cabecera primary, cerrar).
Future<void> showShareLinkWithQrBottomSheet(
  BuildContext context, {
  required String title,
  required String link,
  required String shareSubject,
  double qrSize = 240,
}) {
  return _showDraggableAppSheet(
    context,
    title: title,
    initialChildSize: 0.8,
    minChildSize: 0.4,
    maxChildSize: 0.8,
    titleFontSize: 18,
    bodyBuilder: (scrollController) => SingleChildScrollView(
      controller: scrollController,
      child: Builder(
        builder: (ctx) {
          // Mismo criterio en claro y oscuro: color de marca sobre blanco
          // (estándar para lectores; el primary en oscuro sobre fondo oscuro no se vería).
          final moduleColor = Colors.black;
          const qrBg = Colors.white;
          final logoSize = qrSize * 0.24;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: qrSize,
                    height: qrSize,
                    child: QrImageView(
                      data: link,
                      version: QrVersions.auto,
                      size: qrSize,
                      padding: const EdgeInsets.all(6),
                      gapless: true,
                      // Nivel H para poder incrustar logo y seguir siendo legible.
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                      backgroundColor: qrBg,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.circle,                            
                        color: moduleColor,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.circle,
                        color: moduleColor,
                      ),
                      embeddedImage: const AssetImage('assets/logo.png'),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(logoSize, logoSize),
                      ),
                      embeddedImageEmitsError: false,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Theme.of(ctx).colorScheme.outlineVariant,
              ),
              ListTile(
                leading: const Icon(Icons.copy_rounded),
                title: Text(S.current.copyProfileLink),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: link));
                  if (ctx.mounted) {
                    Navigator.of(ctx).pop();
                  }
                  showCustomSnackBar(
                    S.current.copiedProfileLinkSnackbar,
                    type: 1,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_rounded),
                title: Text(S.current.shareOption),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await SharePlus.instance.share(
                    ShareParams(
                      text: link,
                      subject: shareSubject,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildInitialAvatar(
    BuildContext context, String username, double size) {
  return CircleAvatar(
    radius: size / 2,
    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    child: Text(
      username.isNotEmpty ? username.substring(0, 1).toUpperCase() : '?',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        fontSize: size * 0.45,
      ),
    ),
  );
}

/// Estado vacío reutilizable (inspirado en Fitcron `emptyDataWidget`).
///
/// Ideal para pantallas como conversaciones, listas, etc.
Widget emptyDataWidget(
  BuildContext context,
  IconData icon,
  String message1,
  String message2,
) {
  final theme = Theme.of(context);
  final content = Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 64,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      const SizedBox(height: 16),
      Text(
        message1,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        textAlign: TextAlign.center,
      ),
      if (message2.trim().isNotEmpty) ...[
        const SizedBox(height: 8),
        Text(
          message2,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ],
  );

  return Center(child: content);
}

Widget rowSettingsAppAndVersion(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<LanguageProvider>(
            builder: (ctx, lang, _) {
              return PopupMenuButton<String>(
                tooltip: S.current.language,
                onOpened: () => unFocusGlobal(),
                onSelected: (value) async {
                  if (value.isNotEmpty) {
                    await lang.changeLanguage(value);
                  }
                },
                itemBuilder: (ctx) => languageKeys.map((code) {
                      final isSelected = code == lang.currentLanguage;
                      return PopupMenuItem<String>(
                        value: code,
                        child: Row(
                          children: [
                            if (isSelected)
                              Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: Theme.of(ctx).colorScheme.secondary,
                              ),
                            if (isSelected) const SizedBox(width: 8),
                            Text(
                              getLanguageFlag(code),
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected
                                    ? Theme.of(ctx).colorScheme.secondary
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                getLanguageName(code),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? Theme.of(ctx).colorScheme.secondary
                                      : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getLanguageFlag(lang.currentLanguage),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          getNativeLanguageName(lang.currentLanguage),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      Flexible(
        flex: 0,
        child: Tooltip(
          message: S.current.theme,
          child: ElevatedButton(
            onPressed: () {
              unFocusGlobal();
              context.read<ThemeProvider>().toggleTheme();
            },
            child: Consumer<ThemeProvider>(
              builder: (_, themeProvider, __) => Icon(
                themeProvider.isDarkMode
                    ? Icons.nightlight_round
                    : Icons.wb_sunny_rounded,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Tooltip(
          message: S.current.currentAppVersionText,
          child: TextButton(
            onPressed: () {
              unFocusGlobal();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VersionChangeLogPage(),
                ),
              );
            },
            child: Text(
              'v$globalCurrentVersionApp',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget customToggleButtons({
  required BuildContext context,
  required List<String> options,
  required List<bool> isSelected,
  required Function(int) onPressed,
  required String title,
  required IconData icon,
  List<Widget>? customChildren,
  Widget? infoButton,
  double height = 56,
  bool isEditing = true,
  Color? selectedColor,
  Color? fillColor,
  Color? borderColor,
  Color? selectedBorderColor,
  double borderWidth = 2,
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (infoButton != null) infoButton,
        ],
      ),
      const SizedBox(height: 8),
      LayoutBuilder(
        builder: (context, constraints) {
          return ToggleButtons(
            constraints: BoxConstraints.expand(
              width: (constraints.maxWidth - 10) / options.length,
              height: height,
            ),
            isSelected: isSelected,
            onPressed: onPressed,
            selectedColor:
                selectedColor ?? Theme.of(context).colorScheme.onSurface,
            fillColor: fillColor ??
                (isEditing
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).focusColor),
            borderColor: borderColor ??
                (isEditing
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).focusColor),
            selectedBorderColor: selectedBorderColor ??
                (isEditing
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).focusColor),
            borderWidth: borderWidth,
            borderRadius: borderRadius,
            children: customChildren ??
                options
                    .map(
                      (option) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    )
                    .toList(),
          );
        },
      ),
    ],
  );
}
