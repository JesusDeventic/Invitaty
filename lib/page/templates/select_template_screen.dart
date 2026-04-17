import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/routes/app_routes.dart';

class SelectTemplateScreen extends StatelessWidget {
  const SelectTemplateScreen({super.key});

  final List<Map<String, String>> templates = const [
    {
      "name": "Boda elegante",
      "description": "Diseño clásico y romántico",
      "path": "assets/templates/wedding.json",
      "icon": "💍",
    },
    {
      "name": "Cumpleaños",
      "description": "Colorido y divertido",
      "path": "assets/templates/birthday.json",
      "icon": "🎉",
    },
    {
      "name": "Bautizo / Comunión",
      "description": "Estilo suave y familiar",
      "path": "assets/templates/baptism.json",
      "icon": "👶",
    },
    {
      "name": "Cena / Fiesta",
      "description": "Perfecto para eventos sociales",
      "path": "assets/templates/party.json",
      "icon": "🍽️",
    },
    {
      "name": "Felicitación estacional",
      "description": "Ambiente festivo navideño",
      "path": "assets/templates/christmas.json",
      "icon": "🎄",
    },
    {
      "name": "Personalizada",
      "description": "Empieza desde cero",
      "path": "assets/templates/custom.json",
      "icon": "✨",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<InvitationProvider>();
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Elige una plantilla")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: templates.length,

          // 🔥 esto asegura 3 filas visibles SIEMPRE
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: height / 3.8,
          ),

          itemBuilder: (context, index) {
            final template = templates[index];

            return InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () async {
                await provider.loadTemplateFromAsset(template["path"]!);

                if (!context.mounted) return;

                context.push(AppRoutes.editor);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🔹 ICONO
                    Text(
                      template["icon"]!,
                      style: const TextStyle(fontSize: 26),
                    ),

                    const SizedBox(height: 8),

                    // 🔹 NOMBRE
                    Text(
                      template["name"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // 🔹 DESCRIPCIÓN
                    Text(
                      template["description"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
