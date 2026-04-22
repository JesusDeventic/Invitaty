import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/providers/invitation_provider.dart';

class EditTextModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditTextModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditTextModuleScreen> createState() => _EditTextModuleScreenState();
}

class _EditTextModuleScreenState extends State<EditTextModuleScreen> {
  // 🧠 CONTENIDO
  late TextEditingController titleController;
  late TextEditingController bodyController;

  // 🎨 CONFIGURACIÓN VISUAL
  String selectedFont = "Poppins";
  double fontSize = 18;
  Color textColor = Colors.black;

  // 📦 CATÁLOGO DE FUENTES (frontend-driven)
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

    // 🧠 inicialización desde backend
    titleController = TextEditingController(
      text: (data["title"] ?? "").toString(),
    );
    bodyController = TextEditingController(
      text: (data["body"] ?? "").toString(),
    );

    selectedFont = (data["font"] ?? "Poppins").toString();

    // 🔧 clamp para evitar valores rotos del backend
    fontSize = (data["fontSize"] ?? 18).toDouble().clamp(18.0, 48.0);

    textColor = _parseColor(data["color"]);
  }

  // 🎨 parseo seguro de color desde backend
  Color _parseColor(dynamic value) {
    if (value == null) return Colors.black;

    try {
      if (value is String) {
        String hex = value.replaceAll("#", "");
        if (hex.length == 6) hex = "FF$hex";
        return Color(int.parse(hex, radix: 16));
      }

      if (value is int) {
        return Color(value);
      }
    } catch (_) {}

    return Colors.black;
  }

  // 🎨 convierte Color → HEX (#RRGGBB)
  String _colorToHex(Color color) {
    final int value = color.toARGB32();
    final hex = value.toRadixString(16).padLeft(8, '0');
    return "#${hex.substring(2).toUpperCase()}";
  }

  // 🎨 selector visual de color
  void _pickColor() {
    Color tempColor = textColor;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).selectTextColor),

          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (color) => tempColor = color,
              enableAlpha: false,
              displayThumbColor: true,
            ),
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
        );
      },
    );
  }

  // 💾 guardar en provider (estructura limpia backend-ready)
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "body": bodyController.text,
        "font": selectedFont,
        "fontSize": fontSize,
        "color": _colorToHex(textColor),
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 eliminar módulo
  Future<void> _delete() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
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
        );
      },
    );

    if (confirm == true) {
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              // 🧠 título
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: S.of(context).editTitle),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // 📝 contenido
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                  labelText: S.of(context).editContent,
                ),
                maxLines: 4,
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // 🎨 selector de fuente
              Text(
                S.of(context).editFont,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

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

              // 📏 tamaño de fuente
              Text(
                S.of(context).labelSize,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              Slider(
                value: fontSize,
                min: 18,
                max: 48,
                divisions: 15,
                label: fontSize.toStringAsFixed(0),
                onChanged: (v) => setState(() => fontSize = v),
              ),

              const SizedBox(height: 16),

              // 🎨 color
              Text(
                S.of(context).editColor,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  GestureDetector(
                    onTap: _pickColor,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(S.of(context).selectTextColor),
                ],
              ),

              const SizedBox(height: 24),

              // 👁 PREVIEW (clave para UX)
              Text(
                S.of(context).actionPreview,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleController.text,
                      style: TextStyle(
                        fontSize: fontSize + 4,
                        fontWeight: FontWeight.bold,
                        fontFamily: selectedFont,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 8),

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
