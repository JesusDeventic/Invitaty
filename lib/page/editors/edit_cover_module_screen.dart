import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';

class EditCoverModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditCoverModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditCoverModuleScreen> createState() => _EditCoverModuleScreenState();
}

class _EditCoverModuleScreenState extends State<EditCoverModuleScreen> {
  late TextEditingController titleController;
  late TextEditingController subtitleController;

  String selectedFont = "Poppins";
  double titleSize = 28;
  double subtitleSize = 18;

  Color selectedColor = Colors.white;

  String imageUrl = "";

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(text: data["title"] ?? "");
    subtitleController = TextEditingController(text: data["subtitle"] ?? "");

    selectedFont = data["font"] ?? "Poppins";

    titleSize = (data["fontSizeTitle"] ?? 28).toDouble();
    subtitleSize = (data["fontSizeSubtitle"] ?? 18).toDouble();

    imageUrl = data["imageUrl"] ?? "";

    final colorHex = data["textColor"] ?? "#FFFFFF";
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

    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "subtitle": subtitleController.text,
        "font": selectedFont,
        "fontSizeTitle": titleSize,
        "fontSizeSubtitle": subtitleSize,
        "textColor": _colorToHex(selectedColor),
        "imageUrl": imageUrl,
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🎨 COLOR PICKER (igual estilo text)
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
                  onColorChanged: (color) => tempColor = color,
                  enableAlpha: false,
                  displayThumbColor: true,
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
                setState(() {
                  selectedColor = tempColor;
                });
                Navigator.pop(context);
              },
              child: Text(S.of(context).buttonConfirm),
            ),
          ],
        );
      },
    );
  }

  void _setFakeImage() {
    setState(() {
      imageUrl = "https://picsum.photos/800/400";
    });
  }

  @override
  Widget build(BuildContext context) {
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
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: S.of(context).editTitle),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(
                  labelText: S.of(context).editSubtitle,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                S.of(context).editFont,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

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
                    ].map((font) {
                      return DropdownMenuItem(
                        value: font,
                        child: Text(
                          font,
                          style: TextStyle(fontFamily: font, fontSize: 16),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() => selectedFont = value!);
                },
              ),

              const SizedBox(height: 16),

              Text(S.of(context).sizeTitle),
              Slider(
                value: titleSize,
                min: 18,
                max: 48,
                divisions: 15,
                onChanged: (v) => setState(() => titleSize = v),
              ),

              Text(S.of(context).sizeSubtitle),
              Slider(
                value: subtitleSize,
                min: 14,
                max: 32,
                divisions: 10,
                onChanged: (v) => setState(() => subtitleSize = v),
              ),

              const SizedBox(height: 16),

              Text(
                S.of(context).editColor,
                style: TextStyle(fontWeight: FontWeight.bold),
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

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _setFakeImage,
                icon: const Icon(Icons.image),
                label: Text(S.of(context).selectImage),
              ),

              const SizedBox(height: 24),

              Text(
                S.of(context).actionPreview,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

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
                      ? const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                        )
                      : null,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                      const SizedBox(height: 8),
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

  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse(hex, radix: 16));
  }

  String _colorToHex(Color color) {
    final value = color.toARGB32();
    return "#${value.toRadixString(16).substring(2).toUpperCase()}";
  }
}
