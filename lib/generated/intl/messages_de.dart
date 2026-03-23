// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(seconds) =>
      "Benutzername oder Passwort falsch.\nBitte warten Sie ${seconds} Sekunden, bevor Sie es erneut versuchen.";

  static String m1(username) => "Profil von @${username} auf Invitaty";

  static String m2(username) => "QR für @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Kontoeinstellungen",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("Nein"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Ja"),
    "andLabel": MessageLookupByLibrary.simpleMessage("und"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Erstveröffentlichung von Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Änderungsprotokoll",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Zurück"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Passwort ändern",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Schließen"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Konto löschen",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Avatar entfernen",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Aktualisieren",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Schließen"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Der Code muss 6 Ziffern haben",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Falls das Konto existiert, wurde ein Code an Ihre E-Mail gesendet.",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Einklappen"),
    "confirm": MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort bestätigen",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Cookie-Richtlinie",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Link kopiert",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Link kopieren"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Aktuelle Version",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Aktuelles Passwort",
    ),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Verfügbare Version",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Datumsformat"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Alle Benachrichtigungen löschen",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Möchten Sie die App wirklich beenden?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("App beenden"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Möchten Sie sich wirklich abmelden?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Änderungen speichern?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Möchten Sie Ihr Konto wirklich löschen? Dies kann nicht rückgängig gemacht werden.\nGeben Sie Ihr Passwort zur Bestätigung ein.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Eine neue Version von Invitaty ist verfügbar.\nBitte aktualisieren Sie die App, um fortzufahren.",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Verbindung zum Invitaty-Server nicht möglich.",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Die App befindet sich derzeit in Wartung. Bitte versuchen Sie es später erneut.",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Fehler"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Achtung"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Anzeigename (optional)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Konto konnte nicht gelöscht werden. Bitte erneut versuchen.",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Diese E-Mail ist bereits registriert.",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Der Code ist abgelaufen.",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Ein Fehler ist aufgetreten. Bitte erneut versuchen.",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Der Code ist ungültig.",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Benutzername oder Passwort falsch.",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Die E-Mail ist ungültig.",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Das Passwort muss mindestens 6 Zeichen haben.",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Der Benutzername muss 4–20 Zeichen lang sein und darf nur Buchstaben, Zahlen, Bindestriche und Unterstriche enthalten.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Pflichtfelder fehlen.",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Bitte Benutzername oder E-Mail angeben.",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Registrierung konnte nicht abgeschlossen werden. Bitte erneut versuchen.",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Sitzung konnte nicht erstellt werden. Bitte später erneut versuchen.",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Maximale Anzahl an Versuchen überschritten.",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Zu viele Versuche. Bitte später erneut versuchen.",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Dieser Benutzername ist bereits vergeben.",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Falsches Passwort.",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Bild konnte nicht verarbeitet werden.",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Ausklappen"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Es ist eine App mit einer Datenbank für Filme, Serien und andere audiovisuelle Inhalte, mit Funktionen zum Austausch mit anderen Mitgliedern, für Listen, Bewertungen und Rezensionen und mehr.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Was ist Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Nein, Invitaty ist keine Streaming-App; es ist nur eine Datenbank mit verschiedenen Funktionen rund um die Inhalte.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Kann ich Filme und Serien ansehen?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Sie können Ihr Konto in den Kontoeinstellungen in der App löschen. Dadurch werden alle zugehörigen Daten entfernt. Dieser Vorgang kann nicht rückgängig gemacht werden.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Wie lösche ich mein Konto?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Dieses Feld ist erforderlich",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort vergessen?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Allgemeine Einstellungen",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Systemeinstellungen konnten nicht geöffnet werden.",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Einstellungen konnten nicht gespeichert werden. Prüfen Sie Ihre Verbindung und versuchen Sie es erneut.",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Einstellungen können nicht gespeichert werden. Bitte melden Sie sich erneut an.",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Einstellungen erfolgreich gespeichert.",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Zur Startseite"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Ungültige E-Mail"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Angemeldet bleiben"),
    "language": MessageLookupByLibrary.simpleMessage("Sprache"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabisch"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Katalanisch"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chinesisch"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Niederländisch"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Englisch"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Französisch"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Deutsch"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesisch"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italienisch"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japanisch"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Koreanisch"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polnisch"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portugiesisch"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Rumänisch"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Russisch"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Spanisch"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Schwedisch"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Türkisch"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukrainisch"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Zuletzt online",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Impressum"),
    "loading": MessageLookupByLibrary.simpleMessage("Laden..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Alle als gelesen markieren",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Soziale Netzwerke",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Start"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Passwort erfolgreich geändert.",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Konto konnte nicht gelöscht werden.",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Konto erfolgreich gelöscht.",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Ein Fehler ist aufgetreten.",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Profil konnte nicht aktualisiert werden.",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profil erfolgreich aktualisiert.",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Löschen"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Diese Nachricht löschen?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Nachricht gelöscht",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("bearbeitet"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Sie haben noch keine Unterhaltungen.",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Nachricht konnte nicht gelöscht werden.",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Nachricht konnte nicht bearbeitet werden.",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Nachricht konnte nicht gesendet werden.",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Noch keine Nachrichten. Schreiben Sie etwas!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Gelesen"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Senden"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Gesendet"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Nachricht schreiben...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "Keine weiteren Einträge.",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Alle Benachrichtigungen löschen?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Alle Benachrichtigungen als gelesen markieren?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigung konnte nicht als gelesen markiert werden.",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigung als gelesen markiert.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Alle Benachrichtigungen als gelesen markiert.",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungen konnten nicht gelöscht werden.",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungen gelöscht.",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Sie haben keine Benachrichtigungen.",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungen",
    ),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Geräte-Benachrichtigungsberechtigungen",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Einstellungen öffnen",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("AUS"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("AN"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Aus Sicherheitsgründen können wir die Browser-Einstellungen nicht öffnen. Um Benachrichtigungen für diese Website zu erlauben oder zu blockieren, tippen Sie auf das Schloss neben der Adressleiste → Website-Einstellungen → Benachrichtigungen.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungen im Browser",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Passwort"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Passwort erfolgreich zurückgesetzt.",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Mindestens 6 Zeichen",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwörter stimmen nicht überein",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage("Datenschutz"),
    "privateMessages": MessageLookupByLibrary.simpleMessage(
      "Private Nachrichten",
    ),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Benutzerprofil",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Push-Benachrichtigungen",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Captcha konnte nicht bestätigt werden. Bitte erneut versuchen.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Registrierungsfehler",
    ),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Ich möchte Werbe- und Marketingmitteilungen erhalten",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Ich habe die folgenden Dokumente gelesen und akzeptiere sie:",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Sie müssen die AGB und die Datenschutzerklärung akzeptieren",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Datum entfernen",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Land entfernen",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage(
      "Erneut versuchen",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("Code senden"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Nachricht senden",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Teilen"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Teilen"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage(
      "Mein Profil anzeigen",
    ),
    "showQrOption": MessageLookupByLibrary.simpleMessage("QR anzeigen"),
    "signIn": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "signUp": MessageLookupByLibrary.simpleMessage("Konto erstellen"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Folgen Sie uns in den sozialen Netzwerken.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Link konnte nicht geöffnet werden.",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "WhatsApp konnte nicht geöffnet werden.",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Invitaty Kontakt"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Allgemeine Geschäftsbedingungen",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Brauchen Sie Hilfe? Kontaktieren Sie uns über einen unserer Kanäle – wir melden uns so schnell wie möglich.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Anzeigename",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "E-Mail ist erforderlich",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "Ungültige E-Mail",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Geburtsdatum",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Land"),
    "theme": MessageLookupByLibrary.simpleMessage("Design"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dunkler Modus"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Heller Modus"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "userEmail": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Dieser Benutzer wurde nicht gefunden.",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Benutzername oder E-Mail",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Kontakt"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQ"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "userYears": MessageLookupByLibrary.simpleMessage("Jahre"),
    "username": MessageLookupByLibrary.simpleMessage("Benutzername"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Mindestens 4 Zeichen",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Bestätigungscode (6 Ziffern)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage(
      "https://ihrewebsite.de",
    ),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Website / Blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Wochenbeginn"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Montag"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Sonntag"),
    "welcome": MessageLookupByLibrary.simpleMessage("Willkommen!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Falsche Anmeldedaten",
    ),
  };
}
