import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:invitaty/providers/invitation_provider.dart';

class EditLocationModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditLocationModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditLocationModuleScreen> createState() =>
      _EditLocationModuleScreenState();
}

class _EditLocationModuleScreenState extends State<EditLocationModuleScreen> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController mapsUrlController;

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    nameController = TextEditingController(text: data["name"] ?? "");
    addressController = TextEditingController(text: data["address"] ?? "");
    mapsUrlController = TextEditingController(text: data["mapsUrl"] ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    mapsUrlController.dispose();
    super.dispose();
  }

  // 💾 GUARDAR
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        "name": nameController.text,
        "address": addressController.text,
        "mapsUrl": mapsUrlController.text,
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // ❌ ELIMINAR
  void _delete() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar ubicación"),
          content: const Text("¿Seguro que quieres eliminar este módulo?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Eliminar"),
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

  // 🧠 GENERAR LINK
  void _generateMapsUrl() {
    final address = addressController.text.trim();

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Introduce una dirección primero")),
      );
      return;
    }

    final encoded = Uri.encodeComponent(address);

    setState(() {
      mapsUrlController.text =
          "https://www.google.com/maps/search/?api=1&query=$encoded";
    });
  }

  // 🌍 ABRIR MAPS
  void _openMaps() async {
    final url = mapsUrlController.text;

    if (url.isEmpty) return;

    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el enlace")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar ubicación"),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 NOMBRE
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nombre del lugar",
                ),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // 🔹 DIRECCIÓN
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Dirección"),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // 🔹 BOTÓN GENERAR
              ElevatedButton.icon(
                onPressed: _generateMapsUrl,
                icon: const Icon(Icons.map),
                label: const Text("Generar enlace de Google Maps"),
              ),

              const SizedBox(height: 16),

              // 🔹 URL
              TextField(
                controller: mapsUrlController,
                decoration: const InputDecoration(
                  labelText: "Enlace de Google Maps",
                ),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 24),

              // 🔹 PREVIEW
              const Text(
                "Vista previa",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                    if (nameController.text.isNotEmpty)
                      Text(
                        nameController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    const SizedBox(height: 8),

                    if (addressController.text.isNotEmpty)
                      Text(addressController.text),

                    const SizedBox(height: 12),

                    if (mapsUrlController.text.isNotEmpty)
                      InkWell(
                        onTap: _openMaps,
                        child: Row(
                          children: const [
                            Icon(Icons.map, size: 16),
                            SizedBox(width: 6),
                            Text(
                              "Abrir en Google Maps",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
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
