// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(seconds) =>
      "Nome utente o password errati.\nAttendi ${seconds} secondi prima di riprovare";

  static String m1(username) => "Profilo di @${username} su Invitaty";

  static String m2(username) => "QR di @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Impostazioni account",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("No"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Sì"),
    "andLabel": MessageLookupByLibrary.simpleMessage("e"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Versione iniziale di Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Registro modifiche",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Indietro"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Cambia password",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Chiudi"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Conferma"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Elimina account",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Rimuovi avatar",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Aggiorna",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Chiudi"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Il codice deve avere 6 cifre",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Se l\'account esiste, è stato inviato un codice all\'email",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Comprimi"),
    "confirm": MessageLookupByLibrary.simpleMessage("Conferma"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Conferma password",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("Cookie policy"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Link copiato",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Copia link"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Versione attuale",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Password attuale"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Versione disponibile",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Formato data"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Elimina tutte le notifiche",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Vuoi davvero uscire dall\'app?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Esci dall\'app",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Vuoi davvero uscire?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Salvare le modifiche?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Vuoi davvero eliminare il tuo account? Questa azione è irreversibile.\nInserisci la password per confermare.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Password",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "È disponibile una nuova versione di Invitaty.\nAggiorna l\'app per continuare",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Impossibile connettersi al server Invitaty",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "L\'app è in manutenzione. Riprova più tardi",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Errore"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Attenzione"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Nome visualizzato (facoltativo)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile eliminare l\'account. Riprova",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Questa email è già registrata",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Il codice è scaduto",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Si è verificato un errore. Riprova",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Il codice non è valido",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Nome utente o password errati",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "L\'email non è valida",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "La password deve avere almeno 6 caratteri",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Il nome utente deve avere tra 4 e 20 caratteri e può contenere solo lettere, numeri, trattini e underscore.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Mancano campi obbligatori",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Indica nome utente o email",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile completare la registrazione. Riprova",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile creare la sessione. Riprova più tardi",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Hai superato il numero massimo di tentativi",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Troppi tentativi. Riprova più tardi",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Questo nome utente esiste già",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Password errata",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Impossibile elaborare l\'immagine",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Espandi"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "È un\'app per creare inviti per tutti i tipi di eventi. Ti permette di scegliere modelli e personalizzare l\'invito, condividerlo sui social, ricevere notifiche di conferma e tenere traccia delle presenze.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Cos\'è Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "No, puoi usare Invitaty per progettare i tuoi inviti, ma per poterli pubblicare devi effettuare un pagamento per ciascuno di essi.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage("È gratis?"),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Puoi eliminare il tuo account dalle impostazioni dell\'account nell\'app. Vengono rimossi tutti i dati associati. Questa azione è irreversibile.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Come elimino il mio account?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Questo campo è obbligatorio",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Password dimenticata?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Impostazioni generali",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Impossibile aprire le impostazioni di sistema",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Impossibile salvare le impostazioni. Controlla la connessione e riprova",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Impossibile salvare le impostazioni. Accedi di nuovo",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Impostazioni salvate correttamente",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Vai alla home"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Create invitation",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tap Create invitation to get started.",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "No invitations created yet.",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Email non valida"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Resta connesso"),
    "language": MessageLookupByLibrary.simpleMessage("Lingua"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabo"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Catalano"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Cinese"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Olandese"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Inglese"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Francese"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Tedesco"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesiano"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italiano"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Giapponese"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Coreano"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polacco"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portoghese"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Rumeno"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Russo"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Spagnolo"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Svedese"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turco"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ucraino"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Ultimo accesso",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Note legali"),
    "loading": MessageLookupByLibrary.simpleMessage("Caricamento..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Esci"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Segna tutto come letto",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("Social"),
    "menuHome": MessageLookupByLibrary.simpleMessage("Home"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password modificata correttamente",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Impossibile eliminare l\'account",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Account eliminato correttamente",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Si è verificato un errore",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Impossibile aggiornare il profilo",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profilo aggiornato correttamente",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Elimina"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Eliminare questo messaggio?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Messaggio eliminato",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Modifica"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("modificato"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Non hai ancora conversazioni",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Impossibile eliminare il messaggio",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Impossibile modificare il messaggio",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Impossibile inviare il messaggio",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Ancora nessun messaggio. Scrivi qualcosa!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Letto"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Invia"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Inviato"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Scrivi un messaggio...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nuova password"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "Nessun altro record",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Eliminare tutte le notifiche?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Segnare tutte le notifiche come lette?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Impossibile segnare la notifica come letta",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Notifica segnata come letta.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Tutte le notifiche segnate come lette",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Impossibile eliminare le notifiche",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Notifiche eliminate",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Non hai notifiche",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Notifiche"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Autorizzazioni notifiche del dispositivo",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Apri impostazioni",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("OFF"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("ON"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Per motivi di sicurezza non possiamo aprire le impostazioni del browser. Per consentire o bloccare le notifiche di questo sito, tocca il lucchetto accanto all\'indirizzo → Impostazioni sito → Notifiche.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifiche nel browser",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Password reimpostata correttamente",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Almeno 6 caratteri",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Le password non coincidono",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Informativa sulla privacy",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Messaggi privati"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Profilo utente",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notifiche push",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Impossibile verificare il captcha. Riprova.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Errore di registrazione",
    ),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Accetto di ricevere promozioni e comunicazioni commerciali",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Ho letto e accetto i",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Devi accettare i termini e condizioni e l\'informativa sulla privacy",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Rimuovi data",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Rimuovi paese",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Riprova"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Invia codice"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Invia messaggio",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Condividi"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Condividi"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage(
      "Vedi il mio profilo",
    ),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Mostra QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Accedi"),
    "signUp": MessageLookupByLibrary.simpleMessage("Crea account"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Seguici sui social.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Impossibile aprire il link",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Impossibile aprire WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Stato"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Contatto Invitaty"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Termini e condizioni",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Hai bisogno di aiuto? Contattaci tramite uno dei nostri canali e ti risponderemo il prima possibile.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nome visualizzato",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "L\'email è obbligatoria",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "L\'email non è valida",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Data di nascita",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Paese"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Modalità scura"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Modalità chiara"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Descrizione"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Non abbiamo trovato questo utente",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("Nome utente o email"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Contatto"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQ"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Esci"),
    "userYears": MessageLookupByLibrary.simpleMessage("anni"),
    "username": MessageLookupByLibrary.simpleMessage("Nome utente"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Almeno 4 caratteri",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Codice di verifica (6 cifre)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Versione"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://tuosito.it"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Sito web / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage(
      "Primo giorno della settimana",
    ),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Lunedì"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Domenica"),
    "welcome": MessageLookupByLibrary.simpleMessage("Benvenuto/a!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Credenziali errate",
    ),
  };
}
