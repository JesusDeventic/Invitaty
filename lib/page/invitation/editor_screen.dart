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
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          final provider = context.read<InvitationProvider>();
          provider.reorderSections(oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          final section = sections[index];

          return ReorderableDragStartListener(
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
                  onTap: () => _editModule(context, index, section),
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
        onPressed: () => _showModulePicker(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔽 Abrir selector de módulos
  void _showModulePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.6,
        child: ModulePicker(onSelected: (type) => _addModule(context, type)),
      ),
    );
  }

  // ➕ Añadir módulo
  void _addModule(BuildContext context, ModuleType type) {
    final provider = context.read<InvitationProvider>();
    final newSection = {
      "id": "${type.name}_${DateTime.now().millisecondsSinceEpoch}",
      "type": type.name,
      "data": _getDefaultData(type),
    };
    provider.addSection(newSection);
  }

  // ✏️ Editar módulo según tipo
  void _editModule(
    BuildContext context,
    int index,
    Map<String, dynamic> section,
  ) {
    final type = section["type"];

    switch (type) {
      case "text":
        context.push('/edit-text', extra: {"index": index, "section": section});
        break;
      case "countdown":
        context.push(
          '/edit-countdown',
          extra: {"index": index, "section": section},
        );
        break;
      case "location":
        context.push(
          '/edit-location',
          extra: {"index": index, "section": section},
        );
        break;
      case "music":
        context.push(
          '/edit-music',
          extra: {"index": index, "section": section},
        );
        break;
      case "agenda":
        context.push(
          '/edit-agenda',
          extra: {"index": index, "section": section},
        );
        break;
      case "dressCode":
        context.push(
          '/edit-dress',
          extra: {"index": index, "section": section},
        );
        break;
      case "gifts":
        context.push(
          '/edit-gifts',
          extra: {"index": index, "section": section},
        );
        break;
      case "gallery":
        context.push(
          '/edit-gallery',
          extra: {"index": index, "section": section},
        );
        break;
      case "video":
        context.push(
          '/edit-video',
          extra: {"index": index, "section": section},
        );
        break;
      case "rsvp":
        context.push('/edit-rsvp', extra: {"index": index, "section": section});
        break;
      case "cover":
        context.push(
          '/edit-cover',
          extra: {"index": index, "section": section},
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Edición no implementada para este módulo"),
          ),
        );
    }
  }

  // 🔹 Iconos de módulos
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

  // 🧠 Datos por defecto según módulo
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
        return {"videos": []};
      case ModuleType.rsvp:
        return {
          "fields": ["name", "email", "attending"],
        };
      case ModuleType.agenda:
        return {"items": []};
      case ModuleType.dressCode:
        return {
          "title": "Código de vestimenta",
          "style": "",
          "description": "",
        };
      case ModuleType.gifts:
        return {
          "title": "Regalos",
          "message": "",
          "iban": "",
          "bizum": "",
          "link": "",
        };
    }
  }
}
