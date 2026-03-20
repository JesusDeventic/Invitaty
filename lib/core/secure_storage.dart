import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Almacenamiento seguro del token de sesión (Filmaniak).
class FilmaniakSecureStorage {
  static const _keyToken = 'filmaniak_auth_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _keyToken);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: _keyToken);
  }
}
