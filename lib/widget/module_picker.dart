import 'package:flutter/material.dart';
import '../modules/module_catalog.dart';
import '../modules/module_type.dart';

class ModulePicker extends StatelessWidget {
  final Function(ModuleType type) onSelected;

  const ModulePicker({super.key, required this.onSelected});

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

          const Text(
            "Añadir módulo",
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
                        Text(module.title, textAlign: TextAlign.center),
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
