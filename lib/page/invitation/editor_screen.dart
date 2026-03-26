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
            key: ValueKey(section["id"]), // 🔥 obligatorio
            index: index,

            child: ListTile(
              title: Text(section["type"] ?? "unknown"),
              subtitle: Text(section["id"] ?? "no-id"),

              onTap: () {
                _editModule(context, index, section);
              },
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
