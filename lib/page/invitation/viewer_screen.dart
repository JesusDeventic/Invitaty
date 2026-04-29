import 'package:flutter/material.dart';
import 'package:invitaty/modules/module_registry.dart';
import 'package:invitaty/modules/module_type.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/theme_registry.dart';

class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invitationProvider = context.watch<InvitationProvider>();

    /// 📦 SECCIONES DE LA INVITACIÓN
    final sections = invitationProvider.sections;

    /// 🎨 OBTENER THEME DESDE EL JSON
    final themeId = invitationProvider.invitation["theme"];

    final baseTheme = ThemeRegistry.get(themeId);

    /// 🎨 OVERRIDE (si existe)
    final override = invitationProvider.themeOverride;

    /// 🎨 THEME FINAL (BASE + OVERRIDE)
    final theme = baseTheme.copyWithOverride(override);

    return Scaffold(
      appBar: AppBar(title: Text(S.current.appName)),

      /// 🆕 BOTONES FLOTANTES (SELECTOR + CUSTOMIZER)
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: "theme_customizer",
            onPressed: () => _openThemeCustomizer(context),
            child: const Icon(Icons.tune),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "theme_selector",
            onPressed: () => _openThemeSelector(context),
            child: const Icon(Icons.palette),
          ),
        ],
      ),

      /// 🎨 FONDO GLOBAL DE LA INVITACIÓN
      body: Container(
        color: theme.backgroundColor,

        child: ListView(
          children: sections.map((section) {
            final typeString = section["type"] as String;
            final data = section["data"] as Map<String, dynamic>;

            final type = _parseModuleType(typeString);

            return ModuleRegistry.build(type, data, theme);
          }).toList(),
        ),
      ),
    );
  }

  /// 🎨 SELECTOR DE THEMES (SIN CAMBIOS LÓGICOS)
  void _openThemeSelector(BuildContext context) {
    final provider = context.read<InvitationProvider>();

    final currentThemeId = provider.invitation["theme"];
    final themes = ThemeRegistry.getAll();

    final selectedThemeId = ValueNotifier<String>(currentThemeId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<String>(
            valueListenable: selectedThemeId,
            builder: (context, value, _) {
              final previewTheme = ThemeRegistry.get(value);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).themeSelect,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: previewTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: previewTheme.primaryColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          previewTheme.getDisplayName(context),
                          style: TextStyle(
                            fontSize: previewTheme.titleFontSize,
                            color: previewTheme.primaryColor,
                            fontFamily: previewTheme.fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          S.of(context).sampleText,
                          style: TextStyle(
                            color: previewTheme.textColor,
                            fontFamily: previewTheme.fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  ...themes.map((theme) {
                    final isSelected = theme.id == value;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.primaryColor,
                      ),
                      title: Text(theme.getDisplayName(context)),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () => selectedThemeId.value = theme.id,
                    );
                  }),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.setTheme(selectedThemeId.value);
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).applyChanges),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// 🎛️ CUSTOMIZADOR REAL FUNCIONAL (FIX FINAL)
  void _openThemeCustomizer(BuildContext context) {
    final provider = context.read<InvitationProvider>();

    final themeId = provider.invitation["theme"];
    final baseTheme = ThemeRegistry.get(themeId);

    final background = ValueNotifier<Color>(baseTheme.backgroundColor);
    final primary = ValueNotifier<Color>(baseTheme.primaryColor);
    final font = ValueNotifier<String>(baseTheme.fontFamily);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Personalizar tema",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              /// 🎨 BACKGROUND
              ValueListenableBuilder<Color>(
                valueListenable: background,
                builder: (_, value, __) {
                  return ListTile(
                    title: const Text("Color de fondo"),
                    trailing: Container(width: 24, height: 24, color: value),
                    onTap: () async {
                      final picked = await _pickColor(context, value);
                      if (picked != null) background.value = picked;
                    },
                  );
                },
              ),

              /// 🎨 PRIMARY
              ValueListenableBuilder<Color>(
                valueListenable: primary,
                builder: (_, value, __) {
                  return ListTile(
                    title: const Text("Color principal"),
                    trailing: Container(width: 24, height: 24, color: value),
                    onTap: () async {
                      final picked = await _pickColor(context, value);
                      if (picked != null) primary.value = picked;
                    },
                  );
                },
              ),

              /// 🔤 FONT SELECTOR REAL
              ValueListenableBuilder<String>(
                valueListenable: font,
                builder: (_, value, __) {
                  return ListTile(
                    title: const Text("Tipografía"),
                    subtitle: Text(value),
                    onTap: () async {
                      final selected = await _pickFont(context, value);
                      if (selected != null) font.value = selected;
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  provider.applyThemeOverride(
                    background: background.value,
                    primary: primary.value,
                    font: font.value,
                  );

                  Navigator.pop(context);
                },
                child: const Text("Aplicar"),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🎨 COLOR PICKER (FIX CONTEXT OK)
  Future<Color?> _pickColor(BuildContext context, Color current) async {
    return showDialog<Color>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Seleccionar color"),
          content: Wrap(
            spacing: 8,
            children: [
              _colorDot(dialogContext, Colors.white, current),
              _colorDot(dialogContext, Colors.black, current),
              _colorDot(dialogContext, Colors.pink, current),
              _colorDot(dialogContext, Colors.blue, current),
              _colorDot(dialogContext, Colors.green, current),
              _colorDot(dialogContext, Colors.orange, current),
            ],
          ),
        );
      },
    );
  }

  Widget _colorDot(BuildContext context, Color color, Color current) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: current == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  /// 🔤 FONT PICKER
  Future<String?> _pickFont(BuildContext context, String current) async {
    final fonts = [
      "Poppins",
      "Playfair",
      "Fredoka",
      "GreatVibes",
      "Creepster",
      "Disney",
    ];

    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Seleccionar tipografía"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: fonts.map((f) {
              return ListTile(
                title: Text(f, style: TextStyle(fontFamily: f)),
                trailing: f == current ? const Icon(Icons.check) : null,
                onTap: () => Navigator.of(dialogContext).pop(f),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  /// 🔄 PARSER STRING → ENUM
  ModuleType _parseModuleType(String type) {
    switch (type) {
      case "text":
        return ModuleType.text;
      case "cover":
        return ModuleType.cover;
      case "countdown":
        return ModuleType.countdown;
      case "location":
        return ModuleType.location;
      case "rsvp":
        return ModuleType.rsvp;
      case "gallery":
        return ModuleType.gallery;
      case "video":
        return ModuleType.video;
      case "agenda":
        return ModuleType.agenda;
      case "dressCode":
        return ModuleType.dressCode;
      case "gifts":
        return ModuleType.gifts;
      case "music":
        return ModuleType.music;
      default:
        return ModuleType.text;
    }
  }
}
