import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import 'package:invitaty/providers/invitation_provider.dart';

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

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    images = List<String>.from(data["images"] ?? []);
    titleController = TextEditingController(text: data["title"] ?? "Galería");
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  // 💾 GUARDAR
  void _save() {
    final provider = context.read<InvitationProvider>();

    final updatedSection = {
      ...widget.section,
      "data": {"title": titleController.text, "images": images},
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // ❌ ELIMINAR MÓDULO
  Future<void> _deleteModule() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar galería"),
        content: const Text(
          "¿Estás seguro de que quieres eliminar este módulo? Esta acción no se puede deshacer.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      context.read<InvitationProvider>().removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // ➕ AÑADIR IMAGEN (FAKE)
  void _addImage() {
    setState(() {
      images.add(
        "https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}",
      );
    });
  }

  // ❌ ELIMINAR IMAGEN
  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  // 🔀 REORDENAR
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
        title: const Text("Editar galería"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteModule,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addImage,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷️ TÍTULO
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Título de la galería",
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Imágenes (mantén pulsado para mover)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: images.isEmpty
                  ? const Center(child: Text("No hay imágenes"))
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
                        return Container(
                          key: ValueKey(images[index]),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // ❌ BOTÓN ELIMINAR
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
}
