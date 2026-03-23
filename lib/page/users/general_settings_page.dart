import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:invitaty/api/invitaty_api.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/core/user_preferences.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/model/user_model.dart';
import 'package:invitaty/providers/language_provider.dart';
import 'package:invitaty/providers/theme_provider.dart';
import 'package:invitaty/widget/components_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// Ajustes generales de Invitaty (idioma, tema, inicio de semana, formato fecha).
class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({super.key});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage>
    with WidgetsBindingObserver {
  String _weekStart = 'monday';
  String _dateFormat = 'dd/MM/yyyy';
  bool _isEditing = false;
  bool _loadingNotificationPermission = true;
  AuthorizationStatus _notificationStatus = AuthorizationStatus.notDetermined;

  late bool _initialIsDarkMode;
  late String _initialLanguage;
  late String _initialWeekStart;
  late String _initialDateFormat;

  final _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadInitialValues();
    _loadNotificationPermissionStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Tras volver de ajustes del sistema (MIUI, etc.), refrescar en el
      // siguiente frame evita setState durante transiciones y pantalla negra.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _loadNotificationPermissionStatus().then((_) {
          if (mounted && globalUserToken.isNotEmpty) {
            // Si activó notificaciones en el sistema, registrar token sin bloquear UI.
            syncPushConfig();
          }
        });
      });
    }
  }

  Future<Map<String, bool>> _confirmChangesDialog() async {
    final result = await showDialog<Map<String, bool>>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(S.current.dialogWarningTitle),
            content: Text(S.current.dialogConfirmSave),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop({"saved": false, "success": false});
                        setState(() {
                          _isEditing = false;
                          final themeProvider = context.read<ThemeProvider>();
                          final langProvider = context.read<LanguageProvider>();
                          if (themeProvider.isDarkMode != _initialIsDarkMode) {
                            themeProvider.toggleTheme();
                          }
                          if (langProvider.currentLanguage != _initialLanguage) {
                            langProvider.changeLanguage(_initialLanguage);
                          }
                          _weekStart = _initialWeekStart;
                          _dateFormat = _initialDateFormat;
                        });
                      },
                      child: Text(S.current.actionNo),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final ok = await _saveSettings();
                        Navigator.of(context)
                            .pop({"saved": true, "success": ok});
                      },
                      child: Text(S.current.actionYes),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    return result ?? {"saved": false, "success": false};
  }

  Future<void> _loadInitialValues() async {
    _initialIsDarkMode = context.read<ThemeProvider>().isDarkMode;
    _initialLanguage = context.read<LanguageProvider>().currentLanguage;

    // Semana y formato fecha desde usuario (backend/caché)
    final u = globalCurrentUser;
    if (u.weekStart == 'sunday' || u.weekStart == 'monday') {
      _weekStart = u.weekStart;
    }
    if (u.dateFormat.isNotEmpty) {
      _dateFormat = u.dateFormat;
    }
    setState(() {
      _initialWeekStart = _weekStart;
      _initialDateFormat = _dateFormat;
    });
  }

  Future<bool> _saveSettings() async {
    if (globalUserToken.isEmpty || globalCurrentUser.username.isEmpty) {
      showCustomSnackBar(S.current.generalSettingsSaveErrorSession, type: -1);
      return false;
    }
    try {
      final result = await InvitatyApi.updateUser(
        userEmail: globalCurrentUser.email,
        language: context.read<LanguageProvider>().currentLanguage,
        dateFormat: _dateFormat,
        weekStart: _weekStart,
      );
      if (result['success'] != true) {
        showCustomSnackBar(S.current.generalSettingsSaveErrorGeneric, type: -1);
        return false;
      }
      final userJson = result['user'];
      if (userJson is Map<String, dynamic>) {
        globalCurrentUser = InvitatyUser.fromJson(userJson);
        await _prefs.setCachedUser(globalCurrentUser);
      }
      showCustomSnackBar(S.current.generalSettingsSaveSuccess, type: 1);
      setState(() {
        _initialWeekStart = _weekStart;
        _initialDateFormat = _dateFormat;
        _initialIsDarkMode = context.read<ThemeProvider>().isDarkMode;
        _initialLanguage = context.read<LanguageProvider>().currentLanguage;
        _isEditing = false;
      });
      return true;
    } catch (_) {
      showCustomSnackBar(S.current.generalSettingsSaveErrorGeneric, type: -1);
      return false;
    }
  }

  Future<void> _loadNotificationPermissionStatus() async {
    if (!(kIsWeb || Platform.isAndroid || Platform.isIOS)) {
      if (!mounted) return;
      setState(() {
        _loadingNotificationPermission = false;
        _notificationStatus = AuthorizationStatus.notDetermined;
      });
      return;
    }
    try {
      final settings = await FirebaseMessaging.instance.getNotificationSettings();
      if (!mounted) return;
      setState(() {
        _notificationStatus = settings.authorizationStatus;
        _loadingNotificationPermission = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _notificationStatus = AuthorizationStatus.notDetermined;
        _loadingNotificationPermission = false;
      });
    }
  }

  Future<void> _openSystemNotificationSettings() async {
    if (kIsWeb) {
      if (!mounted) return;
      final l10n = S.current;
      await showInfoDialogGlobal(
        context,
        title: l10n.notificationsWebSettingsTitle,
        message: l10n.notificationsWebSettingsBody,
      );
      return;
    }
    try {
      // Android: `app-settings:` no existe; iOS sí lo soporta. app_settings abre
      // la ficha de la app en ambos (MIUI, Samsung, etc.).
      await AppSettings.openAppSettings();
    } catch (_) {
      if (!mounted) return;
      showCustomSnackBar(S.current.generalSettingsOpenSystemSettingsError, type: -1);
    }
  }

  bool get _notificationsAllowed {
    return _notificationStatus == AuthorizationStatus.authorized ||
        _notificationStatus == AuthorizationStatus.provisional;
  }

  bool get _showNotificationPermissionSection {
    return kIsWeb ||
        Platform.isAndroid ||
        Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.current;
    final now = DateTime.now();
    final dateFormatsList = [
      'dd/MM/yyyy',
      'dd-MM-yyyy',
      'MM/dd/yyyy',
      'MM-dd-yyyy',
      'yyyy/MM/dd',
      'yyyy-MM-dd',
    ];

    String formatExample(String pattern) {
      return DateFormat(pattern).format(now);
    }

    return PopScope(
      canPop: !_isEditing,
      onPopInvoked: (didPop) async {
        if (_isEditing && !didPop) {
          await _confirmChangesDialog();
          // Siempre salir tras el diálogo (como Fitcron): guardando o sin guardar
          if (context.mounted) Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.generalSettings),
          actions: [
            // Botón editar
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
              ),
            // Botones cancelar / guardar cuando se edita
            if (_isEditing)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () async {
                      final result = await _confirmChangesDialog();
                      if (result["saved"] == false) {
                        // restaurar valores iniciales
                        final themeProvider = context.read<ThemeProvider>();
                        final langProvider = context.read<LanguageProvider>();

                        if (themeProvider.isDarkMode != _initialIsDarkMode) {
                          await themeProvider.toggleTheme();
                        }
                        if (langProvider.currentLanguage != _initialLanguage) {
                          await langProvider.changeLanguage(_initialLanguage);
                        }
                        setState(() {
                          _weekStart = _initialWeekStart;
                          _dateFormat = _initialDateFormat;
                          _isEditing = false;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: () {
                      _saveSettings();
                    },
                  ),
                ],
              ),
            const SizedBox(width: 8),
          ],
        ),
      // Importante: el scroll debe ocupar todo el ancho. El contenido sí se limita.
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
              // Idioma (fila como en Fitcron)
              Row(
                children: [
                  const Icon(Icons.language_rounded),
                  const SizedBox(width: 8),
                  Text(
                    l10n.language,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
                      const SizedBox(height: 8),
                      _LanguageSelectorSettings(isEditing: _isEditing),
                      const SizedBox(height: 16),

              // Tema (toggle grande como Fitcron)
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, _) {
                          return customToggleButtons(
                            context: context,
                            isEditing: _isEditing,
                            options: [l10n.themeLight, l10n.themeDark],
                            isSelected: [
                              !themeProvider.isDarkMode,
                              themeProvider.isDarkMode,
                            ],
                            onPressed: _isEditing
                                ? (_) => themeProvider.toggleTheme()
                                : (_) {},
                            title: l10n.theme,
                            icon: Icons.settings_display_rounded,
                            customChildren: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.wb_sunny_rounded, size: 24),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.themeLight,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.nightlight_round, size: 24),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.themeDark,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 16),

              // Día de inicio de la semana (toggle como Fitcron)
                      customToggleButtons(
                        context: context,
                        isEditing: _isEditing,
                        options: [l10n.weekStartSunday, l10n.weekStartMonday],
                        isSelected: [
                          _weekStart == 'sunday',
                          _weekStart == 'monday',
                        ],
                        onPressed: (index) {
                          if (!_isEditing) return;
                          setState(() {
                            _weekStart = index == 0 ? 'sunday' : 'monday';
                          });
                        },
                        title: l10n.weekStart,
                        icon: Icons.filter_1_rounded,
                      ),

                      const SizedBox(height: 16),

              // Formato de fecha (etiqueta + ejemplo + desplegable sencillo)
                      Row(
                        children: [
                          const Icon(Icons.date_range_rounded),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${l10n.dateFormat} (${formatExample(_dateFormat)})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      DropdownButton<String>(
                        value: _dateFormat,
                        isExpanded: true,
                        onChanged: _isEditing
                            ? (v) {
                                if (v == null) return;
                                setState(() => _dateFormat = v);
                              }
                            : null,
                        items: dateFormatsList.map((pattern) {
                          return DropdownMenuItem<String>(
                            value: pattern,
                            child: Text('$pattern   (${formatExample(pattern)})'),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      if (_showNotificationPermissionSection) ...[
                        // Permisos de notificaciones del dispositivo (sin guardar en DB/SP)
                        Row(
                          children: [
                            const Icon(Icons.notifications_active_rounded),
                            const SizedBox(width: 8),
                            Text(
                              l10n.pushNotificationsLabel,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.notificationsPermissionHint,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 44,
                              child: _loadingNotificationPermission
                                  ? Center(
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      _notificationsAllowed
                                          ? l10n.notificationsStatusOn
                                          : l10n.notificationsStatusOff,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: _notificationsAllowed
                                            ? Colors.green.shade700
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.55),
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _openSystemNotificationSettings,
                                icon: const Icon(Icons.settings_rounded),
                                label: Text(
                                  l10n.notificationsPermissionOpenSettings,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class _LanguageSelectorSettings extends StatelessWidget {
  const _LanguageSelectorSettings({required this.isEditing});

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    return SizedBox(
      width: double.infinity,
      child: PopupMenuButton<String>(
        enabled: isEditing,
        tooltip: S.current.language,
        onOpened: () => unFocusGlobal(),
        onSelected: (value) => lang.changeLanguage(value),
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
      ),
    );
  }
}

