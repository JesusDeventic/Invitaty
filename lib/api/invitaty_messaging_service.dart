import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:invitaty/api/firebase_web_config.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color, debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Servicio centralizado de notificaciones push (Android / iOS / Web),
/// alineado con Fitcron: Firebase sin opciones en nativo, opciones solo en Web.
class InvitatyMessagingService {
  FirebaseMessaging? _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      if (kIsWeb) {
        final o = InvitatyFirebaseWebConfig.webFirebaseOptions;
        if (o.apiKey.isEmpty ||
            o.appId.isEmpty ||
            o.messagingSenderId.isEmpty ||
            o.projectId.isEmpty) {
          debugPrint(
            'FCM Web no configurado: rellena InvitatyFirebaseWebConfig',
          );
          return;
        }
        await Firebase.initializeApp(options: o);
      } else {
        await Firebase.initializeApp();
      }

      _firebaseMessaging = FirebaseMessaging.instance;

      if (!kIsWeb) {
        const androidInit = AndroidInitializationSettings('ic_notification');
        const iosInit = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
        const initSettings = InitializationSettings(
          android: androidInit,
          iOS: iosInit,
        );

        await _flutterLocalNotificationsPlugin.initialize(
          initSettings,
          onDidReceiveNotificationResponse: (NotificationResponse response) {
            debugPrint('Notificación tocada: ${response.payload}');
          },
        );
      }

      await _firebaseMessaging?.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (!kIsWeb) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          debugPrint('Mensaje FCM en primer plano: ${message.messageId}');

          final title = message.notification?.title ?? 'Invitaty';
          final body = message.notification?.body ?? 'Nueva notificación';

          await _showNotification(
            title: title,
            body: body,
            payload: message.data.toString(),
          );
        });
      }

      FirebaseMessaging.onBackgroundMessage(
        _invitatyFirebaseMessagingBackgroundHandler,
      );

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('App abierta desde notificación: ${message.messageId}');
      });

      _firebaseMessaging?.onTokenRefresh.listen((_) async {
        try {
          await syncPushConfig();
        } catch (_) {}
      });
    } catch (e) {
      debugPrint('Error inicializando InvitatyMessagingService: $e');
    }
  }

  Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (kIsWeb) return;

    const androidDetails = AndroidNotificationDetails(
      'invitaty_channel',
      'Invitaty Notifications',
      channelDescription: 'Canal de notificaciones de Invitaty',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: 'ic_notification',
      color: Color(0xFFB8D936),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _invitatyFirebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: InvitatyFirebaseWebConfig.webFirebaseOptions,
      );
    } else {
      await Firebase.initializeApp();
    }
    debugPrint('Mensaje FCM en segundo plano: ${message.messageId}');
  } catch (e) {
    debugPrint('Error en background handler FCM Invitaty: $e');
  }
}
