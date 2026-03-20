// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m0(seconds) =>
      "Usuari o contrasenya incorrectes. Per favor espera ${seconds} segons abans de tornar-ho a intentar";

  static String m1(username) => "Perfil de @${username} a Filmaniak";

  static String m2(username) => "QR per @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountAndProfile": MessageLookupByLibrary.simpleMessage(
      "Compte i perfil",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("No"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Sí"),
    "ageChipPrefix": MessageLookupByLibrary.simpleMessage("Edat: "),
    "andLabel": MessageLookupByLibrary.simpleMessage("i"),
    "appName": MessageLookupByLibrary.simpleMessage("Filmaniak"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "· Versió inicial de Filmaniak.\n· Login, registre i recuperació de contrasenya.\n· Connexió amb La Retroteca (WordPress).",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Registre de canvis",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Enrere"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Canviar contrasenya",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Tancar"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Esborrar avatar",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Tancar"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "El codi ha de tenir 6 dígits",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Si el compte existeix, s\'ha enviat un codi al correu.",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Contraure"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar contrasenya",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Política de galetes",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Enllaç copiat",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage(
      "Copiar enllaç de perfil",
    ),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Versió actual",
    ),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Versió disponible",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Format de data"),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Sortir de l\'aplicació",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Tancar la sessió?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Vols desar els canvis realitzats?",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Hi ha una nova versió de Filmaniak disponible.\nActualitza l\'app per continuar.",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut connectar amb el servidor de Filmaniak.",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "L\'aplicació està en manteniment en aquest moment. Torna-ho a provar més tard.",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Atenció"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Nom a mostrar (opcional)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Correu electrònic"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Aquest correu electrònic ja està registrat.",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "El codi ha caducat.",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "S\'ha produït un error. Torna-ho a provar.",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "El codi no és vàlid.",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Usuari o contrasenya incorrectes.",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "El correu electrònic no és vàlid.",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "La contrasenya ha de tenir almenys 6 caràcters.",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "El nom d\'usuari ha de tenir entre 4 i 20 caràcters i només pot contenir lletres, números, guions i guions baixos.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Falten camps obligatoris.",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Has d\'indicar l\'usuari o el correu electrònic.",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut completar el registre. Torna-ho a provar.",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut crear la sessió. Torna-ho a provar més tard.",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Has superat el nombre màxim d\'intents.",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Massa intents. Torna-ho a provar més tard.",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Aquest nom d\'usuari ja existeix.",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Expandir"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "És una aplicació amb una base de dades de cinema i sèries, amb una sèrie d\'eines que permeten als usuaris interactuar amb altres membres, crear llistes, afegir valoracions i ressenyes entre altres funcionalitats.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Què és Filmaniak?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "No, Filmaniak no és una aplicació de streaming, només funciona com a base de dades amb funcionalitats diverses sobre aquestes dades.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Es poden veure pel·lícules i sèries?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Pots eliminar el teu compte des dels ajustos del teu compte a la pròpia App. Això elimina tot el relacionat amb el teu usuari. Aquesta acció és irreversible.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Com elimino el meu compte?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Aquest camp és obligatori",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Has oblidat la contrasenya?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage("Ajustos generals"),
    "goToHome": MessageLookupByLibrary.simpleMessage("Anar a l\'inici"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Email no vàlid"),
    "keepSession": MessageLookupByLibrary.simpleMessage(
      "Mantenir sessió iniciada",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Àrab"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Català"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Xinès"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Neerlandès"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Anglès"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Francès"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Alemany"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italià"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japonès"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Coreà"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polonès"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portuguès"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Romanès"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Rus"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Espanyol"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Suec"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turc"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ucraïnès"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Últim accés: ",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Avís legal"),
    "loading": MessageLookupByLibrary.simpleMessage("Carregant..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Tancar sessió"),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Xarxes socials",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Inici"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Contrasenya canviada correctament.",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nova contrasenya"),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Notificacions"),
    "password": MessageLookupByLibrary.simpleMessage("Contrasenya"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Contrasenya restablerta correctament.",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Mínim 6 caràcters",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Les contrasenyes no coincideixen",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Política de privacitat",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage(
      "Missatges privats",
    ),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Perfil d\'usuari",
    ),
    "qrTitle": m2,
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Error en el registre",
    ),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Accepto rebre promocions i comunicacions comercials",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "He llegit i accepto els",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Has d\'acceptar els termes i condicions i la política de privacitat",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Eliminar data de naixement",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Eliminar país",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Enviar codi"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Enviar missatge",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Configuració"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Compartir"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Compartir"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage(
      "Veure el meu perfil",
    ),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Mostrar QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Iniciar sessió"),
    "signUp": MessageLookupByLibrary.simpleMessage("Registrar-se"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Segueix-nos a les xarxes socials.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut obrir l\'enllaç.",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut obrir WhatsApp.",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusChipPrefix": MessageLookupByLibrary.simpleMessage("Estat: "),
    "subjectSupport": MessageLookupByLibrary.simpleMessage(
      "Contacte Filmaniak",
    ),
    "success": MessageLookupByLibrary.simpleMessage("Èxit"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Termes i condicions",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Necessites ajuda? Escriu-nos per correu o visita la nostra web.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Mode fosc"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Mode clar"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "No hem trobat aquest usuari.",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("Usuari o email"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Contacte"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQs"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage(
      "Tancar sessió",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Nom d\'usuari"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Mínim 4 caràcters",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Codi de verificació (6 dígits)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Versió"),
    "vipChipLabel": MessageLookupByLibrary.simpleMessage("Retroteca VIP"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage(
      "https://yourwebsite.com",
    ),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Lloc web / bloc"),
    "weekStart": MessageLookupByLibrary.simpleMessage(
      "Dia d\'inici de setmana",
    ),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Dilluns"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Diumenge"),
    "welcome": MessageLookupByLibrary.simpleMessage("Benvingut"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Credencials incorrectes",
    ),
  };
}
