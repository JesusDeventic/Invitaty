import 'package:filmaniak/generated/l10n.dart';

/// Devuelve el mensaje de error localizado según el código del backend.
/// Si el código no se reconoce, devuelve [S.current.errorAuthGeneric].
String getAuthErrorMessage(String? code) {
  if (code == null || code.isEmpty) return S.current.errorAuthGeneric;
  switch (code) {
    case 'invalid_username':
      return S.current.errorAuthInvalidUsername;
    case 'invalid_email':
      return S.current.errorAuthInvalidEmail;
    case 'invalid_password':
      return S.current.errorAuthInvalidPassword;
    case 'username_exists':
      return S.current.errorAuthUsernameExists;
    case 'email_exists':
      return S.current.errorAuthEmailExists;
    case 'register_failed':
      return S.current.errorAuthRegisterFailed;
    case 'session_failed':
      return S.current.errorAuthSessionFailed;
    case 'too_many_requests':
      return S.current.errorAuthTooManyRequests;
    case 'missing_fields':
      return S.current.errorAuthMissingFields;
    case 'invalid_credentials':
      return S.current.errorAuthInvalidCredentials;
    case 'missing_login':
      return S.current.errorAuthMissingLogin;
    case 'invalid_code':
      return S.current.errorAuthInvalidCode;
    case 'too_many_attempts':
      return S.current.errorAuthTooManyAttempts;
    case 'expired_code':
      return S.current.errorAuthExpiredCode;
    case 'wrong_password':
      return S.current.errorAuthWrongPassword;
    case 'missing_password':
      return S.current.errorAuthInvalidPassword;
    case 'delete_failed':
      return S.current.errorAuthDeleteAccountFailed;
    default:
      return S.current.errorAuthGeneric;
  }
}
