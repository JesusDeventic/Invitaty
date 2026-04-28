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
    // 🔹 NORMALIZACIÓN DE DATOS (backend-safe)
    final title = (data["title"] ?? S.of(context).moduleNameCountdown)
        .toString();

    final eventDateTime = _parseDate(data["eventDateTime"]);

    /// ❗ CASO: FECHA NO CONFIGURADA
    if (eventDateTime == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),

        /// 🎨 fondo consistente con theme
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Text(
          S.of(context).dateNotSet,
          style: TextStyle(
            fontFamily: theme.fontFamily,
            color: theme.textColor,
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

      /// 🎨 fondo global del theme
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
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: theme.fontFamily,
              color: theme.primaryColor,
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
              fontSize: 18,
              fontFamily: theme.fontFamily,
              color: isPast ? Colors.redAccent : theme.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
