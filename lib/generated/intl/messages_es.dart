// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(seconds) =>
      "Usuario o contraseña incorrectos.\nPor favor espera ${seconds} segundos para intentarlo de nuevo";

  static String m1(username) => "Perfil de @${username} en Invitaty";

  static String m2(username) => "QR de @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Ajustes de la cuenta",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("No"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Sí"),
    "andLabel": MessageLookupByLibrary.simpleMessage("y"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Versión inicial de Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Registro de cambios",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Volver"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Eliminar cuenta",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("Borrar avatar"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Recargar",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "El código debe tener 6 dígitos",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Si la cuenta existe, se ha enviado un código al email",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Contraer"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Política de cookies",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Enlace copiado",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Copiar enlace"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Versión actual",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Contraseña actual",
    ),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Versión disponible",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Formato de fecha"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Eliminar todas las notificaciones",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres salir de la aplicación?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Salir de la aplicación",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres cerrar la sesión?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "¿Quieres guardar los cambios realizados?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres eliminar tu cuenta? Esta acción es irreversible.\nIntroduce tu contraseña para confirmar.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Contraseña",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Hay una nueva versión de Invitaty disponible.\nActualiza la app para continuar",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "No se ha podido conectar con el servidor de Invitaty",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "La aplicación está en mantenimiento en este momento. Vuelve a intentarlo más tarde",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Atención"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Nombre para mostrar (opcional)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo eliminar la cuenta. Inténtalo de nuevo",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Ese email ya está registrado",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "El código ha expirado",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Ha ocurrido un error. Inténtalo de nuevo",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "El código no es válido",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Usuario o contraseña incorrectos",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "El email no es válido",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "La contraseña debe tener al menos 6 caracteres",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "El nombre de usuario debe tener entre 4 y 20 caracteres y solo puede contener letras, números, guiones y guiones bajos.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Faltan campos obligatorios",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Debes indicar usuario o email",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo completar el registro. Inténtalo de nuevo",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo crear la sesión. Inténtalo más tarde",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Has superado el número máximo de intentos",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Demasiados intentos. Inténtalo más tarde",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Ese nombre de usuario ya existe",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Contraseña incorrecta",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Error al procesar la imagen",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Expandir"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Es una aplicación con una base de datos de películas, series y otro tipo de contenido audiovisual, que dispone de herramientas que permiten a los usuarios interactuar con otros miembros, crear listas, añadir valoraciones y reseñas entre otras funcionalidades.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("¿Qué es Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "No, Invitaty no es una aplicación de streaming, tan solo funciona como base de datos con funcionalidades diversas sobre el contenido.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "¿Se pueden ver películas y series?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Puedes eliminar tu usuario desde los ajustes de la cuenta en la propia App. Esto elimina todo lo relacionado y asociado a tu usuario. Esta acción es irreversible.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "¿Cómo elimino mi cuenta?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Este campo es obligatorio",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "¿Olvidaste tu contraseña?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Ajustes generales",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "No se pudieron abrir los ajustes del sistema",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "No se pudieron guardar los ajustes. Comprueba tu conexión e inténtalo de nuevo",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "No se pueden guardar los ajustes. Vuelve a iniciar sesión",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Ajustes guardados correctamente",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Ir a inicio"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Email no válido"),
    "keepSession": MessageLookupByLibrary.simpleMessage(
      "Mantener sesión iniciada",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Árabe"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Catalán"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chino"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Neerlandés"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Inglés"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Francés"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Alemán"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesio"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italiano"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japonés"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Coreano"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polaco"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portugués"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Rumano"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Ruso"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Español"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Sueco"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turco"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ucraniano"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Última conexión",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Aviso legal"),
    "loading": MessageLookupByLibrary.simpleMessage("Cargando..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Marcar todo como leído",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Redes sociales",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Inicio"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Contraseña cambiada correctamente",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Error al eliminar la cuenta",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Cuenta eliminada correctamente",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Ha ocurrido un error",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Error al actualizar el perfil",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Perfil actualizado correctamente",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Eliminar este mensaje?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Mensaje eliminado",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Editar"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("editado"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "No tienes conversaciones todavía",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "No se pudo eliminar el mensaje",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "No se pudo editar el mensaje",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "No se pudo enviar el mensaje",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Aún no hay mensajes. ¡Escribe algo!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Leído"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Enviar"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Enviado"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Escribe un mensaje...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "No hay más registros",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "¿Quieres eliminar todas las notificaciones?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "¿Quieres marcar todas las notificaciones como leídas?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "No se pudo marcar la notificación como leída",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Notificación marcada como leída.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Todas las notificaciones marcadas como leídas",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "No se pudieron eliminar las notificaciones",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Notificaciones eliminadas",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "No tienes notificaciones",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notificaciones",
    ),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Permisos de notificaciones del dispositivo",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Abrir ajustes",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("OFF"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("ON"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Por seguridad, no podemos abrir los ajustes del navegador. Para permitir o bloquear las notificaciones de este sitio, pulsa el candado junto a la dirección web → Configuración del sitio → Notificaciones.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Notificaciones en el navegador",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Contraseña restablecida correctamente",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Mínimo 6 caracteres",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage(
      "Mensajes privados",
    ),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Perfil de usuario",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notificaciones Push",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "No se pudo validar el captcha. Inténtalo de nuevo",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Error en el registro",
    ),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Acepto recibir promociones y comunicaciones comerciales",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "He leído y acepto los",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Debes aceptar los términos y condiciones y la política de privacidad",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Quitar fecha",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage("Quitar país"),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Enviar código"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Enviar mensaje",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Compartir"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Compartir"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Ver mi perfil"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Mostrar QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "signUp": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Síguenos en redes sociales.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el enlace",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Estado"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Contacto Invitaty"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Términos y condiciones",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "¿Necesitas ayuda? Escríbenos por cualquiera de nuestros canales de comunicación y te responderemos lo antes posible.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nombre para mostrar",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "El email es obligatorio",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "El email no es válido",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Fecha de nacimiento",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("País"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Modo oscuro"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Modo claro"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Descripción"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "No hemos encontrado este usuario",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Usuario o correo electrónico",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Contacto"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQs"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage(
      "Cerrar sesión",
    ),
    "userYears": MessageLookupByLibrary.simpleMessage("años"),
    "username": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Mínimo 4 caracteres",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Código de verificación (6 dígitos)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Versión"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://tuweb.com"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Página web / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage(
      "Día de inicio de semana",
    ),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Lunes"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Domingo"),
    "welcome": MessageLookupByLibrary.simpleMessage("Bienvenid@!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Credenciales incorrectas",
    ),
  };
}
