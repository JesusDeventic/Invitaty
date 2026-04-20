import 'package:flutter/material.dart';
import 'module_option.dart';
import 'module_type.dart';
import 'package:invitaty/generated/l10n.dart';

class ModuleCatalog {
  static List<ModuleOption> modules = [
    ModuleOption(
      type: ModuleType.cover,
      title: S.current.moduleNameCover,
      icon: Icons.image,
      isAddable: false, // ❌ NO SE PUEDE AÑADIR
    ),

    ModuleOption(
      type: ModuleType.text,
      title: S.current.moduleNameText,
      icon: Icons.text_fields,
    ),

    ModuleOption(
      type: ModuleType.location,
      title: S.current.moduleNameLocation,
      icon: Icons.location_on,
    ),

    ModuleOption(
      type: ModuleType.countdown,
      title: S.current.moduleNameCountdown,
      icon: Icons.timer,
    ),

    ModuleOption(
      type: ModuleType.music,
      title: S.current.moduleNameMusic,
      icon: Icons.music_note,
    ),

    ModuleOption(
      type: ModuleType.gallery,
      title: S.current.moduleNameGallery,
      icon: Icons.photo_library,
    ),

    ModuleOption(
      type: ModuleType.video,
      title: S.current.moduleNameVideo,
      icon: Icons.play_circle,
    ),

    ModuleOption(
      type: ModuleType.rsvp,
      title: S.current.moduleNameRsvp,
      icon: Icons.how_to_reg,
    ),

    ModuleOption(
      type: ModuleType.agenda,
      title: S.current.moduleNameAgenda,
      icon: Icons.event,
    ),

    ModuleOption(
      type: ModuleType.dressCode,
      title: S.current.moduleNameDressCode,
      icon: Icons.checkroom,
    ),

    ModuleOption(
      type: ModuleType.gifts,
      title: S.current.moduleNameGifts,
      icon: Icons.card_giftcard,
    ),
  ];
}
