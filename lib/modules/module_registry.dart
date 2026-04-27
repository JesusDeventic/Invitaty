import 'package:flutter/material.dart';
import 'module_type.dart';

// 🆕 IMPORT DEL THEME
import 'package:invitaty/themes/invitation_theme.dart';

// 📦 MÓDULOS
import 'text_module.dart';
import 'cover_module.dart';
import 'countdown_module.dart';
import 'location_module.dart';
import 'rsvp_module.dart';
import 'gallery_module.dart';
import 'video_module.dart';
import 'agenda_module.dart';
import 'dress_code_module.dart';
import 'gifts_module.dart';
import 'music_module.dart';

/// 📦 REGISTRO DE MÓDULOS
///
/// 👉 Se encarga de construir cada módulo según su tipo
/// 👉 Ahora también inyecta el theme global
class ModuleRegistry {
  /// 🧩 BUILD DE MÓDULO
  ///
  /// 🔥 CAMBIO IMPORTANTE:
  /// - Ahora recibe el theme
  /// - Lo pasa a TODOS los módulos
  static Widget build(
    ModuleType type,
    Map<String, dynamic> data,
    InvitationTheme theme, // 🆕 NUEVO PARÁMETRO
  ) {
    switch (type) {
      case ModuleType.text:
        return TextModule(
          data: data,
          theme: theme, // 🆕
        );

      case ModuleType.cover:
        return CoverModule(data: data, theme: theme);

      case ModuleType.countdown:
        return CountdownModule(data: data, theme: theme);

      case ModuleType.location:
        return LocationModule(data: data, theme: theme);

      case ModuleType.rsvp:
        return RsvpModule(data: data, theme: theme);

      case ModuleType.gallery:
        return GalleryModule(data: data, theme: theme);

      case ModuleType.video:
        return VideoModule(data: data, theme: theme);

      case ModuleType.agenda:
        return AgendaModule(data: data, theme: theme);

      case ModuleType.dressCode:
        return DressCodeModule(data: data, theme: theme);

      case ModuleType.gifts:
        return GiftsModule(data: data, theme: theme);

      case ModuleType.music:
        return MusicModule(data: data, theme: theme);
    }
  }
}
