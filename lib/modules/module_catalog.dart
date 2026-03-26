import 'package:flutter/material.dart';
import 'module_option.dart';
import 'module_type.dart';

class ModuleCatalog {
  static const List<ModuleOption> modules = [
    ModuleOption(
      type: ModuleType.text,
      title: "Texto",
      icon: Icons.text_fields,
    ),
    ModuleOption(type: ModuleType.cover, title: "Portada", icon: Icons.image),
    ModuleOption(
      type: ModuleType.location,
      title: "Localización",
      icon: Icons.location_on,
    ),
    ModuleOption(
      type: ModuleType.countdown,
      title: "Cuenta atrás",
      icon: Icons.timer,
    ),
    ModuleOption(
      type: ModuleType.music,
      title: "Música",
      icon: Icons.music_note,
    ),
    ModuleOption(
      type: ModuleType.gallery,
      title: "Galería",
      icon: Icons.photo_library,
    ),
    ModuleOption(
      type: ModuleType.video,
      title: "Vídeo",
      icon: Icons.play_circle,
    ),
    ModuleOption(type: ModuleType.rsvp, title: "RSVP", icon: Icons.how_to_reg),
  ];
}
