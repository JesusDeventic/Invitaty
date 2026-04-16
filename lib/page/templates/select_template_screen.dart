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
      "path": "assets/templates/wedding.json",
      "icon": "💍",
    },
    {
      "name": "Cumpleaños",
      "path": "assets/templates/birthday.json",
      "icon": "🎉",
    },
    {
      "name": "Bautizo / Comunión",
      "path": "assets/templates/baptism.json",
      "icon": "👶",
    },
    {
      "name": "Cena / Fiesta",
      "path": "assets/templates/party.json",
      "icon": "🍽️",
    },
    {
      "name": "Navidad",
      "path": "assets/templates/christmas.json",
      "icon": "🎄",
    },
    {
      "name": "Personalizada",
      "path": "assets/templates/custom.json",
      "icon": "✨",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<InvitationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Elige una plantilla")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: templates.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final template = templates[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                await provider.loadTemplateFromAsset(template["path"]!);

                if (!context.mounted) return;

                context.push(AppRoutes.editor);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      template["icon"]!,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      template["name"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
