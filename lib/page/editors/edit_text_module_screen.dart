import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class EditTextModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  /// 🎨 THEME GLOBAL (IMPORTANTE)
  final InvitationTheme theme;

  const EditTextModuleScreen({
    super.key,
    required this.index,
    required this.section,
    required this.theme,
  });

  @override
  State<EditTextModuleScreen> createState() => _EditTextModuleScreenState();
}

class _EditTextModuleScreenState extends State<EditTextModuleScreen> {
  // 🧠 CONTENIDO
  late TextEditingController titleController;
  late TextEditingController bodyController;

  // 🎨 CONFIGURACIÓN VISUAL
  late String selectedFont;
  late double fontSize;
  late Color textColor;

  // 📦 CATÁLOGO DE FUENTES
  final List<String> availableFonts = [
    "Poppins",
    "Playfair",
    "Fredoka",
    "GreatVibes",
    "Creepster",
    "Disney",
  ];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};
    final theme = widget.theme;

    // 🧠 TEXTO
    titleController = TextEditingController(
      text: (data["title"] ?? "").toString(),
    );

    bodyController = TextEditingController(
      text: (data["body"] ?? "").toString(),
    );

    // 🎨 FONT
    /// PRIORIDAD:
    /// 1. data
    /// 2. theme
    selectedFont = (data["font"] as String?) ?? theme.fontFamily;

    // 🎨 SIZE
    fontSize = (data["fontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    // 🎨 COLOR
    textColor = _parseColor(data["color"]) ?? theme.textColor;
  }

  // 🎨 parseo seguro
  Color? _parseColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().replaceAll("#", "");
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }

  // 🎨 color → HEX
  String _colorToHex(Color color) {
    final hex = color.toARGB32().toRadixString(16).padLeft(8, '0');
    return "#${hex.substring(2).toUpperCase()}";
  }

  // 🎨 PICKER
  void _pickColor() {
    Color tempColor = textColor;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(S.of(context).selectTextColor),
        content: ColorPicker(
          pickerColor: tempColor,
          onColorChanged: (c) => tempColor = c,
          enableAlpha: false,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).buttonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => textColor = tempColor);
              Navigator.pop(context);
            },
            child: Text(S.of(context).buttonConfirm),
          ),
        ],
      ),
    );
  }

  // 💾 SAVE (CLAVE)
  void _save() {
    final provider = context.read<InvitationProvider>();
    final theme = widget.theme;

    /// 🧠 SOLO GUARDAMOS SI DIFERENTE AL THEME
    final Map<String, dynamic> cleanData = {
      "title": titleController.text,
      "body": bodyController.text,
    };

    if (selectedFont != theme.fontFamily) {
      cleanData["font"] = selectedFont;
    }

    if (fontSize != theme.bodyFontSize) {
      cleanData["fontSize"] = fontSize;
    }

    if (textColor != theme.textColor) {
      cleanData["color"] = _colorToHex(textColor);
    }

    final updatedSection = {...widget.section, "data": cleanData};

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 DELETE
  Future<void> _delete() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(S.of(context).deleteText),
        content: Text(S.of(context).deleteModuleConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).buttonCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(S.of(context).messagesDelete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editText),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _delete,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // 🧠 TÍTULO
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: S.of(context).editTitle),
              ),

              const SizedBox(height: 16),

              // 📝 BODY
              TextField(
                controller: bodyController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: S.of(context).editContent,
                ),
              ),

              const SizedBox(height: 16),

              // 🎨 FONT
              DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                items: availableFonts.map((font) {
                  return DropdownMenuItem(
                    value: font,
                    child: Text(font, style: TextStyle(fontFamily: font)),
                  );
                }).toList(),
                onChanged: (v) => setState(() => selectedFont = v!),
              ),

              const SizedBox(height: 16),

              // 📏 SIZE
              Slider(
                value: fontSize,
                min: 12,
                max: 48,
                label: fontSize.toStringAsFixed(0),
                onChanged: (v) => setState(() => fontSize = v),
              ),

              const SizedBox(height: 16),

              // 🎨 COLOR
              GestureDetector(
                onTap: _pickColor,
                child: Container(width: 40, height: 40, color: textColor),
              ),

              const SizedBox(height: 24),

              // 👁 PREVIEW (USA THEME SI NO CAMBIAS)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: theme.backgroundColor),
                child: Column(
                  children: [
                    Text(
                      titleController.text,
                      style: TextStyle(
                        fontSize: fontSize + 4,
                        fontFamily: selectedFont,
                        color: textColor,
                      ),
                    ),
                    Text(
                      bodyController.text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: selectedFont,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
