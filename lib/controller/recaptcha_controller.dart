import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:invitaty/api/invitaty_api.dart';
import 'package:invitaty/api/recaptcha_config_api.dart';

/// Servicio para gestionar Google reCAPTCHA v3 en Invitaty (basado en Fitcron).
class RecaptchaService {
  static String _token = '';
  static bool _isReady = false;

  RecaptchaService._();

  /// Inicializa reCAPTCHA v3 (solo en web).
  static Future<void> initiate() async {
    if (kIsWeb) {
      try {
        await GRecaptchaV3.ready(
          ConfigGcaptcha.siteKey,
          showBadge: false,
        );
        _isReady = true;
      } catch (_) {
        // No marcamos ready para que el flujo de verificación intente
        // nuevamente si hace falta.
        _isReady = false;
        rethrow;
      }
    }
  }

  /// Devuelve true si la petición parece de un humano (solo verifica en web).
  static Future<bool> isNotABot() async {
    bool isNotBot = true;

    if (kIsWeb) {
      // En localhost permitimos todo para desarrollo.
      /*if (Uri.base.host == 'localhost' || Uri.base.host == '127.0.0.1') {
        return true;
      }*/

      final verificationResponse = await _getVerificationResponse();
      final score = verificationResponse?.score ?? 0.0;
      // Igual que en Fitcron: mínimo 0.5
      isNotBot = score >= 0.5 && score <= 1.0;
    }

    return isNotBot;
  }

  /// Muestra el badge en web.
  static void showBadge() {
    if (kIsWeb) {
      GRecaptchaV3.showBadge();
    }
  }

  /// Oculta el badge en web.
  static void hideBadge() {
    if (kIsWeb) {
      GRecaptchaV3.hideBadge();
    }
  }

  static Future<RecaptchaResponse?> _getVerificationResponse() async {
    // Evita que falle si se llama a isNotABot() antes de Splash/ready().
    if (kIsWeb && !_isReady) {
      await initiate();
    }

    try {
      _token = await GRecaptchaV3.execute('submit') ?? '';
    } catch (e) {
      debugPrint('Error ejecutando reCAPTCHA (intentando re-init).');
      // Un único reintento tras hacer ready.
      await initiate();
      _token = await GRecaptchaV3.execute('submit') ?? '';
    }

    RecaptchaResponse? recaptchaResponse;

    if (_token.isNotEmpty) {
      try {
        final response = await InvitatyApi.verifyRecaptcha(_token);
        recaptchaResponse = RecaptchaResponse.fromMap(response);
      } catch (e) {
        debugPrint('Error en la verificación de reCAPTCHA.');
      }
    }
    return recaptchaResponse;
  }
}

/// Modelo de respuesta de reCAPTCHA (mismo esquema que Fitcron / Google).
class RecaptchaResponse {
  final bool success;
  final DateTime challengeTimeStamp;
  final String hostName;
  final double score;
  final String action;
  final List<String> errorCodes;

  RecaptchaResponse({
    required this.success,
    required this.challengeTimeStamp,
    required this.hostName,
    required this.score,
    required this.action,
    this.errorCodes = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'challengeTimeStamp': challengeTimeStamp.millisecondsSinceEpoch,
      'hostname': hostName,
      'score': score,
      'action': action,
      'error-codes': errorCodes,
    };
  }

  factory RecaptchaResponse.fromMap(Map<String, dynamic> map) {
    return RecaptchaResponse(
      success: map['success'] ?? false,
      challengeTimeStamp: DateTime.tryParse(map['challenge_ts'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(
            (map['challengeTimeStamp'] ?? 0) as int,
          ),
      hostName: map['hostname'] ?? '',
      score: (map['score'] is num) ? (map['score'] as num).toDouble() : 0.0,
      action: map['action'] ?? '',
      errorCodes: (map['error-codes'] as List?)?.cast<String>() ?? const [],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecaptchaResponse.fromJson(String source) =>
      RecaptchaResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

