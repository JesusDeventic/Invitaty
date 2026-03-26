import 'package:flutter/material.dart';

class InvitationProvider extends ChangeNotifier {
  Map<String, dynamic> _invitation = {"sections": []};

  // 🔍 GETTER SECCIONES
  List<Map<String, dynamic>> get sections {
    return List<Map<String, dynamic>>.from(_invitation["sections"]);
  }

  // 🔍 GETTER INVITATION COMPLETA (útil para debug/viewer)
  Map<String, dynamic> get invitation => _invitation;

  // 🆕 SET INVITATION COMPLETA
  void setInvitation(Map<String, dynamic> invitation) {
    _invitation = {
      ...invitation,

      // 🔥 MUY IMPORTANTE: asegurar lista modificable
      "sections": List<Map<String, dynamic>>.from(invitation["sections"] ?? []),
    };

    notifyListeners();
  }

  // ➕ AÑADIR SECCIÓN
  void addSection(Map<String, dynamic> section) {
    final List<dynamic> currentSections = _invitation["sections"];

    currentSections.add(section);

    notifyListeners();
  }

  // ✏️ ACTUALIZAR SECCIÓN
  void updateSection(int index, Map<String, dynamic> newSection) {
    final List<dynamic> currentSections = _invitation["sections"];

    currentSections[index] = newSection;

    notifyListeners();
  }

  // ❌ ELIMINAR SECCIÓN
  void removeSection(int index) {
    final List<dynamic> currentSections = _invitation["sections"];

    currentSections.removeAt(index);

    notifyListeners();
  }

  void reorderSections(int oldIndex, int newIndex) {
    final List<dynamic> currentSections = _invitation["sections"];

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = currentSections.removeAt(oldIndex);
    currentSections.insert(newIndex, item);

    notifyListeners();
  }
}
