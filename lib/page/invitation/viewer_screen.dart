import 'package:flutter/material.dart';
import 'package:invitaty/modules/module_registry.dart';
import 'package:invitaty/modules/module_type.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';

class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invitationProvider = context.watch<InvitationProvider>();
    final sections = invitationProvider.sections;

    return Scaffold(
      appBar: AppBar(title: const Text("Invitaty")),
      body: ListView(
        children: sections.map((section) {
          final typeString = section["type"] as String;
          final data = section["data"] as Map<String, dynamic>;

          final type = _parseModuleType(typeString);

          return ModuleRegistry.build(type, data);
        }).toList(),
      ),
    );
  }

  ModuleType _parseModuleType(String type) {
    switch (type) {
      case "text":
        return ModuleType.text;
      case "cover":
        return ModuleType.cover;
      case "countdown":
        return ModuleType.countdown;
      case "location":
        return ModuleType.location;
      case "rsvp":
        return ModuleType.rsvp;
      case "gallery":
        return ModuleType.gallery;
      case "video":
        return ModuleType.video;
      case "agenda":
        return ModuleType.agenda;
      case "dressCode":
        return ModuleType.dressCode;
      case "gifts":
        return ModuleType.gifts;
      case "music":
        return ModuleType.music;
      default:
        return ModuleType.text; // fallback seguro
    }
  }
}
