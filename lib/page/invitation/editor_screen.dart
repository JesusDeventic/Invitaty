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
          // 👁️ PREVISUALIZAR INVITACIÓN
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              context.push('/viewer');
            },
          ),
        ],
      ),

      // 🔥 LISTA ORDENABLE DE MÓDULOS
      body: ReorderableListView.builder(
        itemCount: sections.length,

        // ❗ Permite arrastrar desde cualquier parte del módulo
        buildDefaultDragHandles: false,

        // 🔄 REORDENAR MÓDULOS
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

                  // ✏️ EDITAR MÓDULO
                  onTap: () => _editModule(context, index, section),

                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Row(
                      children: [
                        // 🔹 ICONO DEL MÓDULO
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(_getIconForType(section["type"] ?? "")),
                        ),

                        const SizedBox(width: 16),

                        // 🔹 INFO DEL MÓDULO
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

                        // 🔹 ICONO VISUAL DE DRAG
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

      // ➕ BOTÓN AÑADIR MÓDULO
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModulePicker(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔽 ABRIR SELECTOR DE MÓDULOS
  void _showModulePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 🔥 importante para evitar overflow

      builder: (_) => FractionallySizedBox(
        heightFactor: 0.6, // 🔥 ocupa el 60% de la pantalla
        child: ModulePicker(onSelected: (type) => _addModule(context, type)),
      ),
    );
  }

  // ➕ AÑADIR NUEVO MÓDULO
  void _addModule(BuildContext context, ModuleType type) {
    final provider = context.read<InvitationProvider>();

    final newSection = {
      "id": "${type.name}_${DateTime.now().millisecondsSinceEpoch}",
      "type": type.name,
      "data": _getDefaultData(type),
    };

    provider.addSection(newSection);
  }

  // ✏️ EDITAR MÓDULO SEGÚN SU TIPO
  void _editModule(
    BuildContext context,
    int index,
    Map<String, dynamic> section,
  ) {
    // 🔥 IMPORTANTE: aseguramos que siempre es String
    final String type = section["type"] ?? "";

    // 🔹 Extra reutilizable
    final extra = {"index": index, "section": section};

    switch (type) {
      case "text":
        context.push('/edit-text', extra: extra);
        break;

      case "countdown":
        context.push('/edit-countdown', extra: extra);
        break;

      case "location":
        context.push('/edit-location', extra: extra);
        break;

      case "music":
        context.push('/edit-music', extra: extra);
        break;

      case "agenda":
        context.push('/edit-agenda', extra: extra);
        break;

      case "dressCode":
        context.push('/edit-dress', extra: extra);
        break;

      case "gifts":
        context.push('/edit-gifts', extra: extra);
        break;

      case "gallery":
        context.push('/edit-gallery', extra: extra);
        break;

      case "video":
        context.push('/edit-video', extra: extra);
        break;

      case "rsvp":
        context.push('/edit-rsvp', extra: extra);
        break;

      case "cover":
        context.push('/edit-cover', extra: extra);
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Edición no implementada para este módulo"),
          ),
        );
    }
  }

  // 🎨 ICONOS SEGÚN TIPO DE MÓDULO
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

  // 🧠 DATOS POR DEFECTO DE CADA MÓDULO
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
