import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/main.dart';
import 'package:filmoly/page/users/version_changelog_page.dart';
import 'package:filmoly/providers/language_provider.dart';
import 'package:filmoly/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

/// Avatar del usuario: usa [avatarUrl] si existe (Gravatar/MonsterID/etc. de WP),
/// o la inicial del username como fallback.
Widget userAvatar(
  BuildContext context, {
  required String avatarUrl,
  required String username,
  double size = 40,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).colorScheme.secondary,
        width: 1,
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: avatarUrl.isNotEmpty
        ? Image.network(
            avatarUrl,
            fit: BoxFit.cover,
            width: size,
            height: size,
            errorBuilder: (_, __, ___) => _buildInitialAvatar(
                context, username, size),
          )
        : _buildInitialAvatar(context, username, size),
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
                fontSize: 18.0,
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
