import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/modules/module_type.dart';
import 'package:invitaty/widget/module_picker.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invitationProvider = context.watch<InvitationProvider>();
    final sections = invitationProvider.sections;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editor de invitación"),
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              context.push('/viewer');
            },
          ),
        ],
      ),

      body: ReorderableListView.builder(
        itemCount: sections.length,

        // 🔥 IMPORTANTE
        buildDefaultDragHandles: false,

        onReorder: (oldIndex, newIndex) {
          final provider = context.read<InvitationProvider>();
          provider.reorderSections(oldIndex, newIndex);
        },

        itemBuilder: (context, index) {
          final section = sections[index];

          return ReorderableDelayedDragStartListener(
            key: ValueKey(section["id"]),
            index: index,

            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: InkWell(
                  borderRadius: BorderRadius.circular(12),

                  onTap: () {
                    _editModule(context, index, section);
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Row(
                      children: [
                        // 🔹 ICONO
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(_getIconForType(section["type"])),
                        ),

                        const SizedBox(width: 16),

                        // 🔹 TEXTO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section["type"] ?? "unknown",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                section["id"] ?? "no-id",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 🔹 ICONO DRAG (visual, no obligatorio)
                        const Icon(Icons.drag_indicator),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModulePicker(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔽 ABRIR SELECTOR
  void _showModulePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 🔥 IMPORTANTE
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.6, // 🔥 ocupa 60% pantalla
          child: ModulePicker(
            onSelected: (type) {
              _addModule(context, type);
            },
          ),
        );
      },
    );
  }

  // ➕ AÑADIR MÓDULO
  void _addModule(BuildContext context, ModuleType type) {
    final provider = context.read<InvitationProvider>();

    final newSection = {
      "id": "section_${DateTime.now().millisecondsSinceEpoch}",
      "type": type.name,
      "data": _getDefaultData(type),
    };

    provider.addSection(newSection);
  }

  // ✏️ EDITAR SEGÚN TIPO
  void _editModule(
    BuildContext context,
    int index,
    Map<String, dynamic> section,
  ) {
    final type = section["type"];

    if (type == "text") {
      context.push('/edit-text', extra: {"index": index, "section": section});
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case "text":
        return Icons.text_fields;

      case "cover":
        return Icons.image;

      case "countdown":
        return Icons.timer;

      case "location":
        return Icons.location_on;

      case "rsvp":
        return Icons.check_circle;

      case "gallery":
        return Icons.photo_library;

      case "video":
        return Icons.videocam;

      case "agenda":
        return Icons.event;

      case "dressCode":
        return Icons.checkroom;

      case "gifts":
        return Icons.card_giftcard;

      case "music":
        return Icons.music_note;

      default:
        return Icons.widgets;
    }
  }

  // 🧠 DATOS POR DEFECTO
  Map<String, dynamic> _getDefaultData(ModuleType type) {
    switch (type) {
      case ModuleType.text:
        return {"title": "Nuevo texto", "body": "Editar contenido..."};

      case ModuleType.cover:
        return {"title": "Título portada", "subtitle": "Subtítulo"};

      case ModuleType.location:
        return {"name": "Lugar del evento", "address": "Dirección..."};

      case ModuleType.countdown:
        return {
          "title": "Cuenta atrás",
          "eventDateTime": DateTime.now()
              .add(const Duration(days: 1))
              .toIso8601String(),
        };

      case ModuleType.music:
        return {"title": "Música", "url": ""};

      case ModuleType.gallery:
        return {"images": []};

      case ModuleType.video:
        return {"url": ""};

      case ModuleType.rsvp:
        return {"title": "Confirmar asistencia"};

      case ModuleType.agenda:
        return {"events": []};

      case ModuleType.dressCode:
        return {"text": "Dress code..."};

      case ModuleType.gifts:
        return {"text": "Lista de regalos..."};
    }
  }
}
