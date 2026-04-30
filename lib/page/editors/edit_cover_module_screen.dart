import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class EditCoverModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;
  final InvitationTheme theme;

  const EditCoverModuleScreen({
    super.key,
    required this.index,
    required this.section,
    required this.theme,
  });

  @override
  State<EditCoverModuleScreen> createState() => _EditCoverModuleScreenState();
}

class _EditCoverModuleScreenState extends State<EditCoverModuleScreen> {
  // 🔤 CONTROLADORES DE TEXTO
  late TextEditingController titleController;
  late TextEditingController subtitleController;

  // 🎨 CONFIGURACIÓN VISUAL
  String selectedFont = "Poppins";
  double titleSize = 28;
  double subtitleSize = 18;

  Color selectedColor = Colors.white;

  // 🖼️ URL DE IMAGEN
  // 🔥 IMPORTANTE:
  // - Ahora: URL externa (mock)
  // - Futuro: vendrá del backend tras subir imagen
  String imageUrl = "";

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};
    final provider = context.read<InvitationProvider>();

    final effectiveTheme = widget.theme.copyWithOverride(
      provider.themeOverride,
    );

    titleController = TextEditingController(
      text: (data["title"] ?? "").toString(),
    )..addListener(() => setState(() {}));

    subtitleController = TextEditingController(
      text: (data["subtitle"] ?? "").toString(),
    )..addListener(() => setState(() {}));

    selectedFont = (data["font"] ?? effectiveTheme.fontFamily).toString();

    titleSize = (data["fontSizeTitle"] ?? effectiveTheme.titleFontSize)
        .toDouble();

    subtitleSize = (data["fontSizeSubtitle"] ?? effectiveTheme.bodyFontSize)
        .toDouble();

    imageUrl = (data["imageUrl"] ?? "").toString();

    final colorHex = data["textColor"] ?? _colorToHex(effectiveTheme.textColor);

    selectedColor = _hexToColor(colorHex);
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  // 💾 SAVE
  void _save() {
    final provider = context.read<InvitationProvider>();
    final theme = widget.theme;

    // 🧠 SOLO GUARDAMOS OVERRIDES SI DIFIEREN DEL THEME
    final cleanData = <String, dynamic>{
      "title": titleController.text,
      "subtitle": subtitleController.text,

      // 🔥 BACKEND READY:
      // Aquí guardaremos la URL que devuelva el backend
      "imageUrl": imageUrl,
    };

    if (selectedFont != theme.fontFamily) {
      cleanData["font"] = selectedFont;
    }

    if (titleSize != theme.titleFontSize) {
      cleanData["fontSizeTitle"] = titleSize;
    }

    if (subtitleSize != theme.bodyFontSize) {
      cleanData["fontSizeSubtitle"] = subtitleSize;
    }

    if (selectedColor != theme.textColor) {
      cleanData["textColor"] = _colorToHex(selectedColor);
    }

    final updatedSection = {...widget.section, "data": cleanData};

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🎨 COLOR PICKER
  void _openColorPicker() {
    Color tempColor = selectedColor;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).selectTextColor),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ColorPicker(
                  pickerColor: tempColor,
                  onColorChanged: (c) => tempColor = c,
                  enableAlpha: false,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).buttonCancel),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => selectedColor = tempColor);
                Navigator.pop(context);
              },
              child: Text(S.of(context).buttonConfirm),
            ),
          ],
        );
      },
    );
  }

  // 🖼️ MOCK DE IMAGEN
  // 🔥 FUTURO:
  // - abrir galería
  // - subir imagen
  // - guardar URL del backend
  void _setFakeImage() {
    setState(() {
      imageUrl = "https://picsum.photos/800/400";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editCover),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _save)],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏷️ TÍTULO
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: S.of(context).editTitle),
              ),

              const SizedBox(height: 12),

              // 📝 SUBTÍTULO
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(
                  labelText: S.of(context).editSubtitle,
                ),
              ),

              const SizedBox(height: 16),

              DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                items:
                    const [
                      "Poppins",
                      "Playfair",
                      "Fredoka",
                      "GreatVibes",
                      "Creepster",
                      "Disney",
                      "Roboto",
                    ].map((font) {
                      return DropdownMenuItem(
                        value: font,
                        child: Text(font, style: TextStyle(fontFamily: font)),
                      );
                    }).toList(),
                onChanged: (v) => setState(() => selectedFont = v!),
              ),

              const SizedBox(height: 16),

              // 🔠 TAMAÑOS
              Text(S.of(context).sizeTitle),
              Slider(
                value: titleSize,
                min: 16,
                max: 64,
                onChanged: (v) => setState(() => titleSize = v),
              ),

              Text(S.of(context).sizeSubtitle),
              Slider(
                value: subtitleSize,
                min: 12,
                max: 48,
                onChanged: (v) => setState(() => subtitleSize = v),
              ),

              const SizedBox(height: 16),

              /// 🎨 COLOR PICKER CON LABEL (FIX UX)
              Text(
                S.of(context).editColor,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  GestureDetector(
                    onTap: _openColorPicker,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(S.of(context).selectTextColor),
                ],
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _setFakeImage,
                child: Text(S.of(context).selectImage),
              ),

              const SizedBox(height: 16),

              /// 👁️ PREVIEW FIXED (IMAGEN + TEXTO)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                  gradient: imageUrl.isEmpty
                      ? LinearGradient(
                          colors: [theme.primaryColor, theme.accentColor],
                        )
                      : null,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),

                  // 🔥 overlay para mejorar legibilidad del texto
                  color: imageUrl.isNotEmpty
                      ? Colors.black.withValues(alpha: 0.3)
                      : null,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        titleController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontFamily: selectedFont,
                          color: selectedColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitleController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: subtitleSize,
                          fontFamily: selectedFont,
                          color: selectedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🎨 HEX → COLOR
  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse(hex, radix: 16));
  }

  // 🎨 COLOR → HEX (para guardar en backend)
  String _colorToHex(Color color) {
    final value = color.toARGB32();
    return "#${value.toRadixString(16).substring(2).toUpperCase()}";
  }
}
