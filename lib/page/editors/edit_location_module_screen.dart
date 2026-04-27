import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invitaty/generated/l10n.dart';

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

    /// 🔹 INIT NORMALIZADO
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

  /// 💾 SAVE (backend-ready)
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {
        /// 🔹 TRIM + CLEAN (clave para backend)
        "name": nameController.text.trim(),
        "address": addressController.text.trim(),
        "mapsUrl": mapsUrlController.text.trim(),
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  /// 🗑 DELETE
  Future<void> _delete() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteLocation),
        content: Text(S.of(context).deleteModuleConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).buttonCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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

  /// 🧠 GENERADOR DE URL (clave backend-friendly)
  void _generateMapsUrl() {
    final address = addressController.text.trim();

    if (address.isEmpty) return;

    final encoded = Uri.encodeComponent(address);

    setState(() {
      mapsUrlController.text =
          "https://www.google.com/maps/search/?api=1&query=$encoded";
    });
  }

  /// 🔗 OPEN MAPS (seguro)
  Future<void> _openMaps() async {
    final url = mapsUrlController.text.trim();
    if (url.isEmpty) return;

    final uri = Uri.tryParse(url);
    if (uri == null) return;

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).errorOpenLink)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasContent =
        nameController.text.isNotEmpty ||
        addressController.text.isNotEmpty ||
        mapsUrlController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editLocation),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷️ NOMBRE
            TextField(
              controller: nameController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                labelText: S.of(context).locationName,
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            // 📍 DIRECCIÓN
            TextField(
              controller: addressController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                labelText: S.of(context).locationAddress,
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _generateMapsUrl,
              icon: const Icon(Icons.map),
              label: Text(S.of(context).locationGenerator),
            ),

            const SizedBox(height: 16),

            // 🔗 URL
            TextField(
              controller: mapsUrlController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                labelText: S.of(context).locationMaps,
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 24),

            /// 🔥 PREVIEW SOLO SI HAY CONTENIDO
            if (hasContent) ...[
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (nameController.text.isNotEmpty)
                      Text(
                        nameController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    const SizedBox(height: 8),

                    if (addressController.text.isNotEmpty)
                      Text(addressController.text, textAlign: TextAlign.center),

                    const SizedBox(height: 12),

                    if (mapsUrlController.text.isNotEmpty)
                      InkWell(
                        onTap: _openMaps,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.map, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              S.of(context).openMaps,
                              style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
