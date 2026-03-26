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

        // 👁️ BOTÓN PREVIEW
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            tooltip: "Previsualizar",
            onPressed: () {
              context.push('/viewer');
            },
          ),
        ],
      ),

      // 🟢 LISTA DE MÓDULOS
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];

          return ListTile(
            leading: const Icon(Icons.view_agenda),
            title: Text(section["type"] ?? "unknown"),
            subtitle: Text(section["id"] ?? "no-id"),
          );
        },
      ),

      // ➕ BOTÓN AÑADIR
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModulePicker(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔽 ABRE EL SELECTOR DE MÓDULOS
  void _showModulePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ModulePicker(
          onSelected: (type) {
            _addModule(context, type);
          },
        );
      },
    );
  }

  // ➕ AÑADIR MÓDULO SEGÚN TIPO
  void _addModule(BuildContext context, ModuleType type) {
    final provider = context.read<InvitationProvider>();

    final newSection = {
      "id": "section_${DateTime.now().millisecondsSinceEpoch}",
      "type": type.name, // 🔥 MUY IMPORTANTE
      "data": _getDefaultData(type),
    };

    provider.addSection(newSection);
  }

  // 🧠 DATOS INICIALES SEGÚN TIPO
  Map<String, dynamic> _getDefaultData(ModuleType type) {
    switch (type) {
      case ModuleType.text:
        return {"title": "Nuevo texto", "body": "Editar contenido..."};

      case ModuleType.cover:
        return {"title": "Título portada", "subtitle": "Subtítulo"};

      case ModuleType.location:
        return {"name": "Lugar del evento", "address": "Dirección..."};

      case ModuleType.countdown:
        return {"title": "Cuenta atrás"};

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
