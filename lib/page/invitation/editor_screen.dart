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
          context.read<InvitationProvider>().reorderSections(
            oldIndex,
            newIndex,
          );
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
                          child: Icon(_getIconForType(section["type"] ?? "")),
                        ),

                        const SizedBox(width: 16),

                        // 🔹 NOMBRE BONITO + NUMERADO
                        Expanded(
                          child: Text(
                            _getDisplayName(sections, index),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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

  // ===============================
  // 🔽 MODULE PICKER
  // ===============================
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

  // ===============================
  // ➕ ADD MODULE
  // ===============================
  void _addModule(BuildContext context, ModuleType type) {
    final provider = context.read<InvitationProvider>();
    final sections = provider.sections;

    // 🔥 contar cuántos hay de este tipo
    final count = sections.where((s) => s["type"] == type.name).length + 1;

    final newSection = {
      "id": "${type.name}_${DateTime.now().millisecondsSinceEpoch}",
      "type": type.name,
      "data": _getDefaultData(type),

      // 👇 opcional: guardas el número
      "order": count,
    };

    provider.addSection(newSection);
  }

  // ===============================
  // 🧠 NOMBRE BONITO + NUMERACIÓN
  // ===============================
  String _getDisplayName(List sections, int index) {
    final section = sections[index];
    final type = section["type"] ?? "";

    final baseName = _getPrettyName(type);

    // 🔥 calcular número dinámicamente
    int count = 0;
    for (int i = 0; i <= index; i++) {
      if (sections[i]["type"] == type) {
        count++;
      }
    }

    return "$baseName $count";
  }

  // ===============================
  // 🧾 NOMBRES BONITOS
  // ===============================
  String _getPrettyName(String type) {
    switch (type) {
      case "text":
        return "Texto";
      case "cover":
        return "Portada";
      case "countdown":
        return "Cuenta atrás";
      case "location":
        return "Localización";
      case "rsvp":
        return "Confirmación";
      case "gallery":
        return "Galería";
      case "video":
        return "Vídeo";
      case "agenda":
        return "Agenda";
      case "dressCode":
        return "Vestimenta";
      case "gifts":
        return "Regalos";
      case "music":
        return "Música";
      default:
        return "Módulo";
    }
  }

  // ===============================
  // ✏️ EDIT MODULE
  // ===============================
  void _editModule(
    BuildContext context,
    int index,
    Map<String, dynamic> section,
  ) {
    final String type = section["type"] ?? "";
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

  // ===============================
  // 🎨 ICONOS
  // ===============================
  IconData _getIconForType(String type) {
    switch (type) {
      case "text":
        return Icons.text_fields;
      case "cover":
        return Icons.panorama_rounded;
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

  // ===============================
  // 🧠 DEFAULT DATA
  // ===============================
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
