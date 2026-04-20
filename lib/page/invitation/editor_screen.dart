import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/modules/module_type.dart';
import 'package:invitaty/modules/module_catalog.dart'; // 👈 IMPORTANTE
import 'package:invitaty/widget/module_picker.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invitationProvider = context.watch<InvitationProvider>();
    final sections = invitationProvider.sections;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).invitationEditor),
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
          final typeString = section["type"] ?? "";

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
                        // 🔹 ICONO (AHORA DESDE CATALOG)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(_getIconFromCatalog(typeString)),
                        ),

                        const SizedBox(width: 16),

                        // 🔹 NOMBRE BONITO + NUMERADO
                        Expanded(
                          child: Text(
                            _getDisplayName(context, sections, index),
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

    final count = sections.where((s) => s["type"] == type.name).length + 1;

    final newSection = {
      "id": "${type.name}_${DateTime.now().millisecondsSinceEpoch}",
      "type": type.name,
      "data": _getDefaultData(type),
      "order": count,
    };

    provider.addSection(newSection);
  }

  // ===============================
  // 🧠 NOMBRE BONITO + NUMERACIÓN
  // ===============================
  String _getDisplayName(BuildContext context, List sections, int index) {
    final section = sections[index];
    final type = section["type"] ?? "";

    final baseName = _getPrettyName(context, type);

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
  String _getPrettyName(BuildContext context, String type) {
    final s = S.of(context);

    final map = {
      "text": s.moduleNameText,
      "cover": s.moduleNameCover,
      "countdown": s.moduleNameCountdown,
      "location": s.moduleNameLocation,
      "rsvp": s.moduleNameRsvp,
      "gallery": s.moduleNameGallery,
      "video": s.moduleNameVideo,
      "agenda": s.moduleNameAgenda,
      "dressCode": s.moduleNameDressCode,
      "gifts": s.moduleNameGifts,
      "music": s.moduleNameMusic,
    };

    return map[type] ?? s.moduleNameDefault;
  }

  // ===============================
  // 🔥 NUEVO: ICONO DESDE CATALOG
  // ===============================
  IconData _getIconFromCatalog(String type) {
    try {
      final module = ModuleCatalog.modules.firstWhere(
        (m) => m.type.name == type,
      );
      return module.icon;
    } catch (e) {
      return Icons.widgets;
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
