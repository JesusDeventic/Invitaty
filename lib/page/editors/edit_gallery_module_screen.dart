import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';

/// ✏️ EDITOR DE GALERÍA
///
/// 🔹 Permite:
///    - añadir imágenes (fake ahora)
///    - eliminar
///    - reordenar (drag & drop)
///
/// 🔥 FUTURO BACKEND:
///    - selector de imágenes real (gallery / cámara)
///    - subida a servidor
///    - guardado de URLs reales
class EditGalleryModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditGalleryModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditGalleryModuleScreen> createState() =>
      _EditGalleryModuleScreenState();
}

class _EditGalleryModuleScreenState extends State<EditGalleryModuleScreen> {
  late List<String> images;
  late TextEditingController titleController;
  bool _didInitLocalizedDefaults = false;

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    /// 🖼️ Normalización segura de lista
    final rawImages = data["images"];
    images = rawImages is List ? List<String>.from(rawImages) : [];

    /// 🏷️ Título
    titleController = TextEditingController(
      // ⚠️ No usar S.of(context) en initState (puede crashear).
      text: (data["title"] ?? "").toString(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Localizations seguro aquí.
    if (!_didInitLocalizedDefaults) {
      _didInitLocalizedDefaults = true;

      if (titleController.text.trim().isEmpty) {
        titleController.text = S.of(context).moduleNameGallery;
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // 💾 SAVE (consistente con resto de módulos)
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "images": images},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 DELETE MODULE
  Future<void> _deleteModule() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(S.of(context).deleteGallery),
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
      context.read<InvitationProvider>().removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // ➕ ADD IMAGE
  void _addImage() {
    setState(() {
      /// 🎲 Placeholder actual
      /// 🔥 FUTURO:
      ///   - image_picker
      ///   - subida a backend
      ///   - recibir URL final
      images.add(
        "https://picsum.photos/400?random=${DateTime.now().millisecondsSinceEpoch}",
      );
    });
  }

  // ❌ REMOVE IMAGE
  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  // 🔀 REORDER (drag & drop)
  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;

      final item = images.removeAt(oldIndex);
      images.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editGallery),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteModule,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),

      /// ➕ FAB añadir imagen
      floatingActionButton: FloatingActionButton(
        onPressed: _addImage,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷️ TÍTULO
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: S.of(context).editTitle),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            Text(
              S.of(context).editGalleryInstructions,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// 🖼️ GRID EDITABLE
            Expanded(
              child: images.isEmpty
                  ? _buildEmptyState()
                  : ReorderableGridView.builder(
                      itemCount: images.length,
                      onReorder: _reorder,

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                          ),

                      itemBuilder: (context, index) {
                        final imageUrl = images[index];

                        return Container(
                          key: ValueKey(imageUrl),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              /// ❌ BOTÓN ELIMINAR
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📭 EMPTY STATE
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.photo_library_outlined,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            S.of(context).editGalleryNoImages,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
