import 'package:flutter/material.dart';
import '../modules/module_catalog.dart';
import '../modules/module_type.dart';
import 'package:invitaty/generated/l10n.dart';

class ModulePicker extends StatelessWidget {
  final Function(ModuleType type) onSelected;

  const ModulePicker({super.key, required this.onSelected});

  // 🔥 Función de traducción
  String _getModuleTitle(BuildContext context, ModuleType type) {
    final s = S.of(context);

    final map = {
      ModuleType.text: s.moduleNameText,
      ModuleType.cover: s.moduleNameCover,
      ModuleType.countdown: s.moduleNameCountdown,
      ModuleType.location: s.moduleNameLocation,
      ModuleType.rsvp: s.moduleNameRsvp,
      ModuleType.gallery: s.moduleNameGallery,
      ModuleType.video: s.moduleNameVideo,
      ModuleType.agenda: s.moduleNameAgenda,
      ModuleType.dressCode: s.moduleNameDressCode,
      ModuleType.gifts: s.moduleNameGifts,
      ModuleType.music: s.moduleNameMusic,
    };

    return map[type] ?? s.moduleNameDefault;
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 FILTRAR SOLO LOS MÓDULOS AÑADIBLES
    final addableModules = ModuleCatalog.modules
        .where((m) => m.isAddable)
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🔝 BARRITA SUPERIOR (DRAG HANDLE)
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Text(
            S.of(context).addModule,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // 🔥 GRID SCROLLEABLE
          Expanded(
            child: GridView.builder(
              itemCount: addableModules.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final module = addableModules[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(module.type);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(module.icon, size: 28),
                        const SizedBox(height: 8),

                        Text(
                          _getModuleTitle(context, module.type),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
