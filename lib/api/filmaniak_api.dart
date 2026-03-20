import 'dart:convert';
import 'dart:typed_data';

import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/core/secure_storage.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/model/app_status_model.dart';
import 'package:filmaniak/model/private_message_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:http/http.dart' as http;

/// Base URL del WordPress (La Retroteca).
const String filmaniakBaseUrl = 'https://retroteca.org/wp-json/filmaniak/v1';
/// Base pública de la app Flutter Web para enlaces compartibles de perfil.
/// Ajusta este valor al dominio real donde publiques la app web.
const String filmaniakAppPublicBaseUrl = 'https://app.filmaniak.com';

final FilmaniakSecureStorage _secureStorage = FilmaniakSecureStorage();

/// User-Agent con app + dispositivo para que el backend lo guarde en user_agent.
String _getFilmaniakUserAgent() {
  final v = globalCurrentVersionApp.isNotEmpty ? globalCurrentVersionApp : '1.0.0';
  if (kIsWeb) return 'Filmaniak/$v (Web)';
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'Filmaniak/$v (Android)';
    case TargetPlatform.iOS:
      return 'Filmaniak/$v (iOS)';
    case TargetPlatform.windows:
      return 'Filmaniak/$v (Windows)';
    case TargetPlatform.macOS:
      return 'Filmaniak/$v (macOS)';
    case TargetPlatform.linux:
      return 'Filmaniak/$v (Linux)';
    default:
      return 'Filmaniak/$v';
  }
}

class FilmaniakApi {
  static const String _baseUrl = filmaniakBaseUrl;

  static String buildPublicProfileUrl(String username) {
    final clean = username.trim();
    if (clean.isEmpty) return '';
    // Deep link para navegación dentro de la app web (y que también se puede
    // mapear a la app nativa con App Links / Universal Links).
    return '$filmaniakAppPublicBaseUrl/user/${Uri.encodeComponent(clean)}';
  }

  static Map<String, String> _headers({String? token}) {
    final map = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': _getFilmaniakUserAgent(),
    };
    if (token != null && token.isNotEmpty) {
      map['Authorization'] = 'Bearer $token';
    }
    return map;
  }

  /// POST /auth/register
  /// Devuelve el usuario y token en éxito; en error lanza o devuelve mapa con code/message.
  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    String? displayName,
    bool marketingConsent = false,
    String? language,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    final body = <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'marketing_consent': marketingConsent,
    };
    if (displayName != null && displayName.isNotEmpty) {
      body['display_name'] = displayName;
    }
    if (language != null && language.isNotEmpty) {
      body['language'] = language;
    }
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(body),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    if (response.statusCode == 201 && (data['success'] == true)) {
      return data;
    }
    // Error: WP_Error style { code, message } o similar
    final message = data['message'] as String? ?? 'Error de registro';
    final code = data['code'] as String?;
    return {'success': false, 'message': message, 'code': code, 'data': data};
  }

  /// POST /auth/login
  static Future<Map<String, dynamic>> login({
    required String login,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({'login': login, 'password': password}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    if (response.statusCode == 200 && (data['success'] == true)) {
      return data;
    }
    final message = data['message'] as String? ?? 'Credenciales incorrectas';
    final code = data['code'] as String?;
    return {'success': false, 'message': message, 'code': code, 'data': data};
  }

  /// GET /auth/me — valida token y devuelve usuario o null.
  static Future<FilmaniakUser?> validateToken(String token) async {
    final url = Uri.parse('$_baseUrl/auth/me');
    final response = await http.get(
      url,
      headers: _headers(token: token),
    );
    if (response.statusCode != 200) return null;
    final data = jsonDecode(response.body) as Map<String, dynamic>?;
    if (data == null || data['success'] != true) return null;
    final userJson = data['user'];
    if (userJson is! Map<String, dynamic>) return null;
    return FilmaniakUser.fromJson(userJson);
  }

  /// POST /auth/logout
  static Future<bool> logout(String token) async {
    final url = Uri.parse('$_baseUrl/auth/logout');
    final response = await http.post(
      url,
      headers: _headers(token: token),
    );
    return response.statusCode == 200;
  }

  /// POST /auth/forgot-password
  static Future<Map<String, dynamic>> forgotPassword(String login) async {
    final url = Uri.parse('$_baseUrl/auth/forgot-password');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({'login': login}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    final success = response.statusCode == 200 && (data['success'] == true);
    final message = data['message'] as String? ?? (success ? 'OK' : 'Error');
    final code = data['code'] as String?;
    return {'success': success, 'message': message, 'code': code};
  }

  /// POST /auth/reset-password
  static Future<Map<String, dynamic>> resetPassword({
    required String login,
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/reset-password');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({
        'login': login,
        'code': code,
        'new_password': newPassword,
      }),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    final success = response.statusCode == 200 && (data['success'] == true);
    final message = data['message'] as String? ?? (success ? 'OK' : 'Error');
    final errorCode = data['code'] as String?;
    return {'success': success, 'message': message, 'code': errorCode};
  }

  /// Guarda el token en secure storage (tras login o registro).
  static Future<void> saveToken(String token) async {
    await _secureStorage.setToken(token);
    globalUserToken = token;
  }

  /// Cierra sesión en servidor y borra token local.
  static Future<void> logoutAndClear() async {
    if (globalUserToken.isNotEmpty) {
      await logout(globalUserToken);
    }
    globalUserToken = '';
    globalCurrentUser = FilmaniakUser();
    await _secureStorage.removeToken();
  }

  /// Verifica un token de reCAPTCHA v3 contra el endpoint de WordPress.
  static Future<Map<String, dynamic>> verifyRecaptcha(String token) async {
    final url = Uri.parse('$filmaniakBaseUrl/verify-recaptcha');
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode({'token': token}),
    );

    try {
      return jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    } catch (_) {
      return <String, dynamic>{
        // En caso de respuesta inesperada, fuerza un fallo "silencioso"
        // dejando que el score caiga a 0.0.
        'success': false,
      };
    }
  }

  /// GET /status — devuelve versión mínima y estado (mantenimiento).
  static Future<FilmaniakAppStatus?> getStatus() async {
    final url = Uri.parse('$filmaniakBaseUrl/status');
    try {
      final response = await http.get(url, headers: _headers());
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return FilmaniakAppStatus.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  /// POST /push/register-token — guarda/actualiza el token FCM del dispositivo.
  ///
  /// Backend esperado (WordPress): `wordpress_backend/notificaciones.php`
  static Future<bool> registerPushToken({
    required String token,
    required String fcmToken,
  }) async {
    final url = Uri.parse('$_baseUrl/push/register-token');
    try {
      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: jsonEncode({
          'fcm_token': fcmToken,
        }),
      );
      if (response.statusCode != 200) return false;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return data['success'] == true;
    } catch (_) {
      return false;
    }
  }

  /// POST /user/update — actualiza perfil. Multipart si hay avatar.
  /// [avatarBytes] permite subir avatar en web y móvil (usa bytes de file_picker).
  static Future<Map<String, dynamic>> updateUser({
    required String userEmail,
    String? websiteUrl,
    String? displayName,
    String? firstName,
    String? lastName,
    String? description,
    String? language,
    String? dateFormat,
    String? weekStart,
    String? country,
    String? birthdate,
    bool? marketingConsent,
    bool deleteAvatar = false,
    Uint8List? avatarBytes,
    String avatarFilename = 'avatar.jpg',
  }) async {
    final token = globalUserToken;
    if (token.isEmpty) return {'success': false, 'message': 'No token', 'code': 'missing_token'};

    final url = Uri.parse('$_baseUrl/user/update');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['User-Agent'] = _getFilmaniakUserAgent();
    request.headers['Accept'] = 'application/json';

    request.fields['user_email'] = userEmail;
    if (websiteUrl != null) request.fields['user_url'] = websiteUrl;
    if (displayName != null) request.fields['display_name'] = displayName;
    if (firstName != null) request.fields['first_name'] = firstName;
    if (lastName != null) request.fields['last_name'] = lastName;
    if (description != null) request.fields['description'] = description;
    if (language != null) request.fields['language'] = language;
    if (dateFormat != null) request.fields['date_format'] = dateFormat;
    if (weekStart != null) request.fields['start_day_week'] = weekStart;
    if (country != null) request.fields['country'] = country;
    if (birthdate != null) request.fields['birthdate'] = birthdate;
    if (marketingConsent != null) request.fields['marketing_consent'] = marketingConsent.toString();
    if (deleteAvatar) request.fields['delete_avatar'] = 'true';

    if (avatarBytes != null && avatarBytes.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
        'avatar',
        avatarBytes,
        filename: avatarFilename,
      ));
    }

    try {
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};

      if (response.statusCode == 200 && (data['success'] == true)) {
        return data;
      }
      final message = data['message'] as String? ?? 'Error al actualizar';
      final code = data['code'] as String?;
      return {'success': false, 'message': message, 'code': code, 'data': data};
    } catch (e) {
      return {'success': false, 'message': e.toString(), 'code': 'network_error'};
    }
  }

  /// GET /user/public/{username}
  static Future<FilmaniakUser?> getPublicUserByUsername(String username) async {
    final clean = username.trim();
    if (clean.isEmpty) return null;

    final url = Uri.parse('$_baseUrl/user/public/${Uri.encodeComponent(clean)}');
    try {
      final response = await http.get(
        url,
        headers: _headers(),
      );
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      if (data['success'] != true) return null;
      final userJson = data['user'];
      if (userJson is! Map<String, dynamic>) return null;
      return FilmaniakUser.fromJson(userJson);
    } catch (_) {
      return null;
    }
  }

  /// POST /auth/delete-account — elimina la cuenta (requiere contraseña).
  static Future<Map<String, dynamic>> deleteAccount(String password) async {
    final token = globalUserToken;
    if (token.isEmpty) return {'success': false, 'message': 'No token', 'code': 'missing_token'};

    final url = Uri.parse('$_baseUrl/auth/delete-account');
    final response = await http.post(
      url,
      headers: _headers(token: token),
      body: jsonEncode({'password': password}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
    if (response.statusCode == 200 && (data['success'] == true)) {
      return data;
    }
    final message = data['message'] as String? ?? 'Error al eliminar';
    final code = data['code'] as String?;
    return {'success': false, 'message': message, 'code': code, 'data': data};
  }

  /// POST /auth/change-password — cambia la contraseña del usuario autenticado.
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = globalUserToken;
    if (token.isEmpty) return {'success': false, 'code': 'missing_token'};

    final url = Uri.parse('$_baseUrl/auth/change-password');
    try {
      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: jsonEncode({'current_password': currentPassword, 'new_password': newPassword}),
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      if (response.statusCode == 200 && data['success'] == true) return data;
      final code = data['code'] as String?;
      return {'success': false, 'code': code, 'message': data['message']};
    } catch (e) {
      return {'success': false, 'code': 'network_error', 'message': e.toString()};
    }
  }

  /// POST /push/unregister-token — marca un token (o deviceId) como inactivo.
  static Future<bool> unregisterPushToken({
    required String token,
    required String fcmToken,
  }) async {
    final url = Uri.parse('$_baseUrl/push/unregister-token');
    try {
      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: jsonEncode({
          'fcm_token': fcmToken,
        }),
      );
      if (response.statusCode != 200) return false;
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return data['success'] == true;
    } catch (_) {
      return false;
    }
  }

  /// GET /notifications/unread-count
  static Future<int> getUnreadNotificationsCount() async {
    final token = globalUserToken;
    if (token.isEmpty) return 0;
    try {
      final url = Uri.parse('$_baseUrl/notifications/unread-count');
      final response = await http.get(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return (data['unread_count'] as num?)?.toInt() ?? 0;
    } catch (_) {
      return 0;
    }
  }

  /// GET /notifications?page=X&per_page=Y
  static Future<Map<String, dynamic>> getNotifications({
    int page = 1,
    int perPage = 20,
  }) async {
    final token = globalUserToken;
    if (token.isEmpty) {
      return {
        'notifications': <Map<String, dynamic>>[],
        'total': 0,
        'page': page,
        'per_page': perPage,
        'total_pages': 0,
      };
    }
    try {
      final url =
          Uri.parse('$_baseUrl/notifications?page=$page&per_page=$perPage');
      final response = await http.get(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      final list = data['notifications'] as List<dynamic>? ?? [];
      return {
        'notifications': list
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList(),
        'total': (data['total'] as num?)?.toInt() ?? 0,
        'page': (data['page'] as num?)?.toInt() ?? page,
        'per_page': (data['per_page'] as num?)?.toInt() ?? perPage,
        'total_pages': (data['total_pages'] as num?)?.toInt() ?? 0,
      };
    } catch (_) {
      return {
        'notifications': <Map<String, dynamic>>[],
        'total': 0,
        'page': page,
        'per_page': perPage,
        'total_pages': 0,
      };
    }
  }

  /// POST /notifications/mark-read
  /// notificationId = 0 => marcar todas como leídas.
  static Future<bool> markNotificationAsRead(int notificationId) async {
    final token = globalUserToken;
    if (token.isEmpty) return false;
    try {
      final url = Uri.parse('$_baseUrl/notifications/mark-read');
      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: jsonEncode({'notification_id': notificationId}),
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return response.statusCode == 200 && data['success'] == true;
    } catch (_) {
      return false;
    }
  }

  /// DELETE /notifications?notification_id=X
  /// notificationId = 0 => borrar todas.
  static Future<bool> deleteNotifications({int notificationId = 0}) async {
    final token = globalUserToken;
    if (token.isEmpty) return false;
    try {
      final url = Uri.parse('$_baseUrl/notifications').replace(
        queryParameters: {'notification_id': '$notificationId'},
      );
      final response = await http.delete(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return response.statusCode == 200 && data['success'] == true;
    } catch (_) {
      return false;
    }
  }

  // =========================================================
  // MENSAJERÍA PRIVADA
  // =========================================================

  /// GET /messages/conversations
  static Future<List<Conversation>> getConversations({int limit = 20, int offset = 0}) async {
    final token = globalUserToken;
    if (token.isEmpty) return [];
    try {
      final url = Uri.parse('$_baseUrl/messages/conversations?limit=$limit&offset=$offset');
      final response = await http.get(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      final list = data['conversations'] as List<dynamic>? ?? [];
      return list.map((e) => Conversation.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  /// GET /messages?other_user_id=X[&before_id=Y|after_created=Z]
  static Future<List<PrivateMessage>> getMessages({
    required int otherUserId,
    int? beforeId,
    String? afterCreated,
  }) async {
    final token = globalUserToken;
    if (token.isEmpty) return [];
    try {
      final params = <String, String>{'other_user_id': '$otherUserId'};
      if (beforeId != null) params['before_id'] = '$beforeId';
      if (afterCreated != null) params['after_created'] = afterCreated;
      final url = Uri.parse('$_baseUrl/messages').replace(queryParameters: params);
      final response = await http.get(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      final list = data['messages'] as List<dynamic>? ?? [];
      return list.map((e) => PrivateMessage.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  /// GET /messages/unread-count
  static Future<int> getUnreadMessagesCount() async {
    final token = globalUserToken;
    if (token.isEmpty) return 0;
    try {
      final url = Uri.parse('$_baseUrl/messages/unread-count');
      final response = await http.get(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return (data['unread_count'] as num?)?.toInt() ?? 0;
    } catch (_) {
      return 0;
    }
  }

  /// GET /messages/read-status?other_user_id=X
  static Future<bool?> getMessageReadStatus(int otherUserId) async {
    final token = globalUserToken;
    if (token.isEmpty) return null;
    try {
      final url = Uri.parse('$_baseUrl/messages/read-status?other_user_id=$otherUserId');
      final response = await http.get(url, headers: _headers(token: token));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      final v = data['is_read'];
      if (v == null) return null;
      return v == true || v == 1;
    } catch (_) {
      return null;
    }
  }

  /// POST /messages/send
  static Future<PrivateMessage?> sendMessage({required int recipientId, required String message}) async {
    final token = globalUserToken;
    if (token.isEmpty) return null;
    try {
      final url = Uri.parse('$_baseUrl/messages/send');
      final response = await http.post(url,
          headers: _headers(token: token),
          body: jsonEncode({'recipient_id': recipientId, 'message': message}));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      if (data['success'] == true && data['message'] != null) {
        return PrivateMessage.fromJson(data['message'] as Map<String, dynamic>);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// POST /messages/edit
  static Future<bool> editMessage({required int id, required String message}) async {
    final token = globalUserToken;
    if (token.isEmpty) return false;
    try {
      final url = Uri.parse('$_baseUrl/messages/edit');
      final response = await http.post(url,
          headers: _headers(token: token),
          body: jsonEncode({'id': id, 'message': message}));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return data['success'] == true;
    } catch (_) {
      return false;
    }
  }

  /// POST /messages/delete
  static Future<bool> deleteMessage(int id) async {
    final token = globalUserToken;
    if (token.isEmpty) return false;
    try {
      final url = Uri.parse('$_baseUrl/messages/delete');
      final response = await http.post(url,
          headers: _headers(token: token),
          body: jsonEncode({'id': id}));
      final data = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      return data['success'] == true;
    } catch (_) {
      return false;
    }
  }
}
