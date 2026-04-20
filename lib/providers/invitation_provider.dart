import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class InvitationProvider extends ChangeNotifier {
  Map<String, dynamic> _invitation = {"sections": []};

  // 🔍 GETTER SECCIONES (TIPADO SEGURO)
  List<Map<String, dynamic>> get sections {
    return List<Map<String, dynamic>>.from(_invitation["sections"] ?? []);
  }

  // 🔍 GETTER INVITATION COMPLETA
  Map<String, dynamic> get invitation => _invitation;

  // 🆕 SET INVITATION COMPLETA
  void setInvitation(Map<String, dynamic> invitation) {
    final sections = List<Map<String, dynamic>>.from(
      invitation["sections"] ?? [],
    );

    final hasCover = sections.any((s) => s["type"] == "cover");

    if (!hasCover) {
      sections.insert(0, _buildDefaultCover());
    }

    _invitation = {...invitation, "sections": sections};

    notifyListeners();
  }

  Future<void> loadTemplateFromAsset(String path) async {
    try {
      final String jsonString = await rootBundle.loadString(path);
      final Map<String, dynamic> template = json.decode(jsonString);

      final rawSections = List<Map<String, dynamic>>.from(
        template["sections"] ?? [],
      );

      final sections = rawSections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;

        return {
          "id":
              section["id"] ??
              "${section["type"]}_${index}_${DateTime.now().millisecondsSinceEpoch}",
          "type": section["type"],
          "data": section["data"] ?? {},
        };
      }).toList();

      final hasCover = sections.any((s) => s["type"] == "cover");

      if (!hasCover) {
        sections.insert(0, _buildDefaultCover());
      }

      _invitation = {
        "id": template["id"] ?? "",
        "name": template["name"] ?? "",
        "theme": template["theme"] ?? "",
        "sections": sections,
      };

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error loading template: $e");
    }
  }

  // ➕ AÑADIR SECCIÓN
  void addSection(Map<String, dynamic> section) {
    final List<Map<String, dynamic>> currentSections =
        List<Map<String, dynamic>>.from(_invitation["sections"]);

    currentSections.add(section);

    _invitation["sections"] = currentSections;

    notifyListeners();
  }

  // ✏️ ACTUALIZAR SECCIÓN
  void updateSection(int index, Map<String, dynamic> newSection) {
    final List<Map<String, dynamic>> currentSections =
        List<Map<String, dynamic>>.from(_invitation["sections"]);

    currentSections[index] = newSection;

    _invitation["sections"] = currentSections;

    notifyListeners();
  }

  // ❌ ELIMINAR SECCIÓN
  void removeSection(int index) {
    final List<Map<String, dynamic>> currentSections =
        List<Map<String, dynamic>>.from(_invitation["sections"]);

    currentSections.removeAt(index);

    _invitation["sections"] = currentSections;

    notifyListeners();
  }

  // 🔄 REORDENAR
  void reorderSections(int oldIndex, int newIndex) {
    final List<Map<String, dynamic>> currentSections =
        List<Map<String, dynamic>>.from(_invitation["sections"]);

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = currentSections.removeAt(oldIndex);
    currentSections.insert(newIndex, item);

    _invitation["sections"] = currentSections;

    notifyListeners();
  }

  // 🧠 COVER POR DEFECTO
  Map<String, dynamic> _buildDefaultCover() {
    return {
      "id": "cover_auto",
      "type": "cover",
      "data": {"title": "Nueva invitación", "subtitle": "", "image": ""},
    };
  }
}
