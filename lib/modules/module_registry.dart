import 'package:flutter/material.dart';
import 'module_type.dart';

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

class ModuleRegistry {
  static Widget build(ModuleType type, Map<String, dynamic> data) {
    switch (type) {
      case ModuleType.text:
        return TextModule(data: data);

      case ModuleType.cover:
        return CoverModule(data: data);

      case ModuleType.countdown:
        return CountdownModule(data: data);

      case ModuleType.location:
        return LocationModule(data: data);

      case ModuleType.rsvp:
        return RsvpModule(data: data);

      case ModuleType.gallery:
        return GalleryModule(data: data);

      case ModuleType.video:
        return VideoModule(data: data);

      case ModuleType.agenda:
        return AgendaModule(data: data);

      case ModuleType.dressCode:
        return DressCodeModule(data: data);

      case ModuleType.gifts:
        return GiftsModule(data: data);

      case ModuleType.music:
        return MusicModule(data: data);
    }
  }
}
