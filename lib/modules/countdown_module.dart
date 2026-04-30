import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

class CountdownModule extends StatelessWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  /// 👉 Define estética base del módulo
  final InvitationTheme theme;

  const CountdownModule({super.key, required this.data, required this.theme});

  /// 🔧 PARSER SEGURO DE FECHA (backend-ready)
  /// Acepta string ISO (recomendado para backend)
  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;

    try {
      return DateTime.tryParse(value.toString());
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🧠 NORMALIZACIÓN DE DATOS (backend-safe)
    final title = (data["title"] ?? S.of(context).moduleNameCountdown)
        .toString();

    final eventDateTime = _parseDate(data["eventDateTime"]);

    /// 🔤 FONT (data > theme)
    final font = (data["font"] as String?)?.isNotEmpty == true
        ? data["font"]
        : theme.fontFamily;

    /// 🎨 COLORS (data > theme)
    final titleColor = _hexToColor(data["titleColor"]) ?? theme.primaryColor;

    final textColor = _hexToColor(data["textColor"]) ?? theme.textColor;

    final accentColor = _hexToColor(data["accentColor"]) ?? theme.accentColor;

    /// 📏 SIZES (CONSISTENTE CON RESTO DE MÓDULOS)
    final titleSize =
        (data["titleFontSize"] as num?)?.toDouble() ?? theme.titleFontSize;

    final bodySize =
        (data["bodyFontSize"] as num?)?.toDouble() ?? theme.bodyFontSize;

    /// ❗ CASO: FECHA NO CONFIGURADA
    if (eventDateTime == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),

        /// 🎨 fondo consistente
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Text(
          S.of(context).dateNotSet,
          style: TextStyle(
            fontSize: bodySize,
            fontFamily: font,
            color: textColor,
          ),
        ),
      );
    }

    /// 🧠 LÓGICA DE TIEMPO
    final now = DateTime.now();
    final difference = eventDateTime.difference(now);

    /// 🔴 Si ya pasó el evento
    final isPast = difference.isNegative;

    /// 🔒 Evita valores negativos en UI
    final safeDifference = isPast ? Duration.zero : difference;

    /// ⏱ DESGLOSE DE TIEMPO
    final days = safeDifference.inDays;
    final hours = safeDifference.inHours % 24;
    final minutes = safeDifference.inMinutes % 60;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(20),

      /// 🎨 fondo global theme
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 TÍTULO
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              fontFamily: font,
              color: titleColor,
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 CONTADOR / ESTADO
          Text(
            isPast
                ? S.of(context).eventAlreadyStarted
                : S.of(context).countdownFull(days, hours, minutes),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: bodySize,
              fontFamily: font,
              color: isPast ? Colors.redAccent : textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 🎨 HEX → COLOR (backend-safe igual que CoverModule)
  Color? _hexToColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.startsWith("0x")) hex = hex.substring(2);
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }
}
