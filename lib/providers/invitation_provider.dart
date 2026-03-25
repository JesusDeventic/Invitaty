import 'package:flutter/material.dart';

class InvitationProvider extends ChangeNotifier {
  // 🟢 1. JSON de la invitación en memoria
  Map<String, dynamic> _invitation = {};

  // 🟢 2. Getter (para leer desde fuera)
  Map<String, dynamic> get invitation => _invitation;

  // 🟢 3. Inicializar invitación (por ejemplo con mock o plantilla)
  void setInvitation(Map<String, dynamic> newInvitation) {
    _invitation = _deepCopy(newInvitation);
    notifyListeners();
  }

  Map<String, dynamic> _deepCopy(Map<String, dynamic> original) {
    final sections = (original["sections"] as List).map((section) {
      final sectionMap = section as Map;

      return {
        ...sectionMap,
        "data": Map<String, dynamic>.from(sectionMap["data"] as Map),
      };
    }).toList();

    return {...original, "sections": sections};
  }

  // 🟢 4. Obtener secciones
  List get sections => _invitation["sections"] ?? [];

  // 🟢 5. Añadir sección
  void addSection(Map<String, dynamic> section) {
    _invitation["sections"].add(section);
    notifyListeners();
  }

  // 🟢 6. Actualizar sección
  void updateSection(int index, Map<String, dynamic> newData) {
    _invitation["sections"][index]["data"] = newData;
    notifyListeners();
  }

  // 🟢 7. Eliminar sección
  void removeSection(int index) {
    _invitation["sections"].removeAt(index);
    notifyListeners();
  }

  // 🟢 8. Reordenar secciones
  void reorderSections(int oldIndex, int newIndex) {
    final sections = _invitation["sections"];

    if (newIndex > oldIndex) newIndex--;

    final item = sections.removeAt(oldIndex);
    sections.insert(newIndex, item);

    notifyListeners();
  }
}
