import 'package:flutter/material.dart';
import 'module_type.dart';

class ModuleOption {
  final ModuleType type;
  final String title;
  final IconData icon;

  const ModuleOption({
    required this.type,
    required this.title,
    required this.icon,
  });
}
