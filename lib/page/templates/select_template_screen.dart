import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/routes/app_routes.dart';
import 'package:invitaty/generated/l10n.dart';

class TemplateItem {
  final String Function(BuildContext) name;
  final String Function(BuildContext) description;
  final String path;
  final String icon;

  const TemplateItem({
    required this.name,
    required this.description,
    required this.path,
    required this.icon,
  });
}

class SelectTemplateScreen extends StatelessWidget {
  const SelectTemplateScreen({super.key});

  /// 📦 Lista de plantillas disponibles en la app
  /// Cada plantilla apunta a un JSON en assets
  List<TemplateItem> _templates(BuildContext context) => [
    TemplateItem(
      name: (ctx) => S.of(ctx).templateWeddingName,
      description: (ctx) => S.of(ctx).templateWeddingDesc,
      path: "assets/templates/wedding.json",
      icon: "💍",
    ),
    TemplateItem(
      name: (ctx) => S.of(ctx).templateBirthdayName,
      description: (ctx) => S.of(ctx).templateBirthdayDesc,
      path: "assets/templates/birthday.json",
      icon: "🎉",
    ),
    TemplateItem(
      name: (ctx) => S.of(ctx).templateBaptismName,
      description: (ctx) => S.of(ctx).templateBaptismDesc,
      path: "assets/templates/baptism.json",
      icon: "👶",
    ),
    TemplateItem(
      name: (ctx) => S.of(ctx).templatePartyName,
      description: (ctx) => S.of(ctx).templatePartyDesc,
      path: "assets/templates/party.json",
      icon: "🍽️",
    ),
    TemplateItem(
      name: (ctx) => S.of(ctx).templateChristmasName,
      description: (ctx) => S.of(ctx).templateChristmasDesc,
      path: "assets/templates/christmas.json",
      icon: "🎄",
    ),
    TemplateItem(
      name: (ctx) => S.of(ctx).templateCustomName,
      description: (ctx) => S.of(ctx).templateCustomDesc,
      path: "assets/templates/custom.json",
      icon: "✨",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<InvitationProvider>();
    final height = MediaQuery.of(context).size.height;
    final templates = _templates(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).selectTemplateTitle)),

      body: Padding(
        padding: const EdgeInsets.all(12),

        /// 📦 GRID de plantillas
        child: GridView.builder(
          itemCount: templates.length,

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

              /// 🚀 Selección de plantilla
              onTap: () async {
                await provider.loadTemplateFromAsset(template.path);

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
                    /// 🎨 icono visual de plantilla
                    Text(template.icon, style: const TextStyle(fontSize: 26)),

                    const SizedBox(height: 8),

                    /// 🏷️ nombre traducido
                    Text(
                      template.name(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// 📝 descripción traducida
                    Text(
                      template.description(context),
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
