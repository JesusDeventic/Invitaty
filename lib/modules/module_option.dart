import 'package:flutter/material.dart';
import 'module_type.dart';

class ModuleOption {
  final ModuleType type;
  final String title;
  final IconData icon;
  final bool isAddable;

  const ModuleOption({
    required this.type,
    required this.title,
    required this.icon,
    this.isAddable = true, // 👈 por defecto se puede añadir
  });
}
