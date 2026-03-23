// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(seconds) =>
      "Nieprawidłowa nazwa użytkownika lub hasło.\nPoczekaj ${seconds} sekund przed ponowną próbą";

  static String m1(username) => "Profil @${username} w Invitaty";

  static String m2(username) => "QR użytkownika @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("Ustawienia konta"),
    "actionNo": MessageLookupByLibrary.simpleMessage("Nie"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Tak"),
    "andLabel": MessageLookupByLibrary.simpleMessage("i"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Pierwsza wersja Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Dziennik zmian",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Wstecz"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Anuluj"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage("Zmień hasło"),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Zamknij"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Potwierdź"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("Usuń konto"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("Usuń awatar"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Odśwież",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Zamknij"),
    "code6Digits": MessageLookupByLibrary.simpleMessage("Kod musi mieć 6 cyfr"),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Jeśli konto istnieje, kod został wysłany na e-mail",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Zwiń"),
    "confirm": MessageLookupByLibrary.simpleMessage("Potwierdź"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Potwierdź hasło"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Polityka plików cookie",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Link skopiowany",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Kopiuj link"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Aktualna wersja",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Aktualne hasło"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Dostępna wersja",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Format daty"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Usuń wszystkie powiadomienia",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Czy na pewno chcesz zamknąć aplikację?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Zamknij aplikację",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Czy na pewno chcesz się wylogować?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Zapisać zmiany?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Czy na pewno chcesz usunąć konto? Tej operacji nie można cofnąć.\nWprowadź hasło, aby potwierdzić.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Hasło",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Dostępna jest nowa wersja Invitaty.\nZaktualizuj aplikację, aby kontynuować",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Nie można połączyć się z serwerem Invitaty",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Aplikacja jest obecnie w konserwacji. Spróbuj ponownie później",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Błąd"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Uwaga"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Nazwa wyświetlana (opcjonalnie)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Nie udało się usunąć konta. Spróbuj ponownie",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Ten e-mail jest już zarejestrowany",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage("Kod wygasł"),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Wystąpił błąd. Spróbuj ponownie",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Kod jest nieprawidłowy",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowa nazwa użytkownika lub hasło",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "E-mail jest nieprawidłowy",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Hasło musi mieć co najmniej 6 znaków",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Nazwa użytkownika musi mieć 4–20 znaków i może zawierać tylko litery, cyfry, myślniki i podkreślenia.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Brakuje wymaganych pól",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Podaj nazwę użytkownika lub e-mail",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Nie udało się dokończyć rejestracji. Spróbuj ponownie",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Nie udało się utworzyć sesji. Spróbuj później",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Przekroczono maksymalną liczbę prób",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Zbyt wiele prób. Spróbuj później",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Ta nazwa użytkownika jest już zajęta",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowe hasło",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Nie udało się przetworzyć obrazu",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Rozwiń"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "To aplikacja z bazą filmów, seriali i innych treści audiowizualnych oraz narzędziami do interakcji z innymi użytkownikami, tworzenia list, ocen i recenzji.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Czym jest Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Nie, Invitaty nie jest aplikacją streamingową — to tylko baza danych z różnymi funkcjami dotyczącymi treści.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Czy można oglądać filmy i seriale?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Możesz usunąć konto w ustawieniach konta w aplikacji. Usunięte zostaną wszystkie powiązane dane. Tej operacji nie można cofnąć.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage("Jak usunąć konto?"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "To pole jest wymagane",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Nie pamiętasz hasła?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Ustawienia ogólne",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Nie udało się otworzyć ustawień systemowych",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Nie udało się zapisać ustawień. Sprawdź połączenie i spróbuj ponownie",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Nie można zapisać ustawień. Zaloguj się ponownie",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Ustawienia zapisane pomyślnie",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage(
      "Przejdź do strony głównej",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowy e-mail",
    ),
    "keepSession": MessageLookupByLibrary.simpleMessage("Pozostań zalogowany"),
    "language": MessageLookupByLibrary.simpleMessage("Język"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabski"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Kataloński"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chiński"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Holenderski"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Angielski"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Francuski"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Niemiecki"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonezyjski"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Włoski"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japoński"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Koreański"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polski"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portugalski"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Rumuński"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Rosyjski"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Hiszpański"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Szwedzki"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turecki"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukraiński"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Ostatnie logowanie",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage(
      "Informacje prawne",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Ładowanie..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Oznacz wszystkie jako przeczytane",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Media społecznościowe",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Strona główna"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Hasło zmienione pomyślnie",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się usunąć konta",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Konto usunięte pomyślnie",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Wystąpił błąd",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się zaktualizować profilu",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profil zaktualizowany pomyślnie",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Usuń"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Usunąć tę wiadomość?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Wiadomość usunięta",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Edytuj"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("edytowano"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Nie masz jeszcze rozmów",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Nie udało się usunąć wiadomości",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Nie udało się edytować wiadomości",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Nie udało się wysłać wiadomości",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Brak wiadomości. Napisz coś!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Przeczytano"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Wyślij"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Wysłano"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Napisz wiadomość...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nowe hasło"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "Brak dalszych wpisów",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Usunąć wszystkie powiadomienia?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Oznaczyć wszystkie powiadomienia jako przeczytane?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się oznaczyć powiadomienia jako przeczytane",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Powiadomienie oznaczone jako przeczytane.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Wszystkie powiadomienia oznaczone jako przeczytane",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się usunąć powiadomień",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Powiadomienia usunięte",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Nie masz powiadomień",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Powiadomienia"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Uprawnienia powiadomień urządzenia",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Otwórz ustawienia",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("WYŁ."),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("WŁ."),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Ze względów bezpieczeństwa nie możemy otworzyć ustawień przeglądarki. Aby zezwolić na powiadomienia lub je zablokować, dotknij kłódki obok adresu → Ustawienia witryny → Powiadomienia.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Powiadomienia w przeglądarce",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Hasło"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Hasło zostało pomyślnie zresetowane",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Co najmniej 6 znaków",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Hasła nie są zgodne",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Polityka prywatności",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage(
      "Wiadomości prywatne",
    ),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Profil użytkownika",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Powiadomienia push",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się zweryfikować captchy. Spróbuj ponownie.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Błąd rejestracji"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Wyrażam zgodę na otrzymywanie promocji i komunikacji handlowej",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Przeczytałem(-am) i akceptuję",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Musisz zaakceptować regulamin i politykę prywatności",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage("Usuń datę"),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage("Usuń kraj"),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage(
      "Spróbuj ponownie",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("Wyślij kod"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Wyślij wiadomość",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Ustawienia"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Udostępnij"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Udostępnij"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Zobacz mój profil"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Pokaż kod QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
    "signUp": MessageLookupByLibrary.simpleMessage("Utwórz konto"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Śledź nas w mediach społecznościowych.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się otworzyć linku",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się otworzyć WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Kontakt Invitaty"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Regulamin",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Potrzebujesz pomocy? Skontaktuj się z nami przez dowolny kanał — odpowiemy tak szybko, jak to możliwe.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nazwa wyświetlana",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "E-mail jest wymagany",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "E-mail jest nieprawidłowy",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Data urodzenia",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Kraj"),
    "theme": MessageLookupByLibrary.simpleMessage("Motyw"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Tryb ciemny"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Tryb jasny"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Awatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Opis"),
    "userEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Nie znaleźliśmy tego użytkownika",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Nazwa użytkownika lub e-mail",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Kontakt"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQ"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage(
      "Wyloguj się",
    ),
    "userYears": MessageLookupByLibrary.simpleMessage("lat"),
    "username": MessageLookupByLibrary.simpleMessage("Nazwa użytkownika"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Co najmniej 4 znaki",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Kod weryfikacyjny (6 cyfr)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Wersja"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage(
      "https://twojastrona.pl",
    ),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Strona / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage(
      "Pierwszy dzień tygodnia",
    ),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Poniedziałek"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Niedziela"),
    "welcome": MessageLookupByLibrary.simpleMessage("Witamy!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowe dane logowania",
    ),
  };
}
