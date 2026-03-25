import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🟢 Escuchamos el provider (reactivo)
    final invitationProvider = context.watch<InvitationProvider>();

    // 🟢 Obtenemos las secciones (módulos)
    final sections = invitationProvider.sections;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editor de invitación"),

        // 🔥 AQUÍ AÑADIMOS EL BOTÓN DE PREVIEW
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            tooltip: "Previsualizar invitación",

            onPressed: () {
              // 🟢 Navegamos al viewer
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

            // tipo de módulo (text, cover, etc.)
            title: Text(section["type"] ?? "unknown"),

            // id del módulo
            subtitle: Text(section["id"] ?? "no-id"),
          );
        },
      ),

      // 🟢 BOTÓN PARA AÑADIR MÓDULOS
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addModule(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔧 FUNCIÓN PARA AÑADIR UN MÓDULO
  void _addModule(BuildContext context) {
    final provider = context.read<InvitationProvider>();

    final newSection = {
      "id": "section_${DateTime.now().millisecondsSinceEpoch}",
      "type": "text",
      "data": {"title": "Nuevo módulo", "body": "Editar contenido..."},
    };

    provider.addSection(newSection);
  }
}
