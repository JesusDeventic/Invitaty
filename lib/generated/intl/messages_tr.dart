// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m0(seconds) =>
      "Kullanıcı adı veya şifre hatalı.\nTekrar denemeden önce ${seconds} saniye bekleyin";

  static String m1(username) => "Invitaty\'ta @${username} profili";

  static String m2(username) => "@${username} için QR";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("Hesap ayarları"),
    "actionNo": MessageLookupByLibrary.simpleMessage("Hayır"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Evet"),
    "andLabel": MessageLookupByLibrary.simpleMessage("ve"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Invitaty\'ın ilk sürümü.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Değişiklik günlüğü",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Geri"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Biyografi"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("İptal"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Şifre değiştir",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Kapat"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Onayla"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("Hesabı sil"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Avatarı kaldır",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage("Yenile"),
    "close": MessageLookupByLibrary.simpleMessage("Kapat"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Kod 6 haneli olmalıdır",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Hesap varsa bir kod e-postanıza gönderildi",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Daralt"),
    "confirm": MessageLookupByLibrary.simpleMessage("Onayla"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Şifreyi onayla"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Çerez politikası",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Bağlantı kopyalandı",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage(
      "Bağlantıyı kopyala",
    ),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Mevcut sürüm",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Mevcut şifre"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Mevcut sürüm",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Tarih biçimi"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Tüm bildirimleri sil",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Uygulamadan çıkmak istediğinizden emin misiniz?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Uygulamadan çık",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Çıkış yapmak istediğinizden emin misiniz?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Değişiklikler kaydedilsin mi?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.\nOnaylamak için şifrenizi girin.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Şifre",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Invitaty\'ın yeni bir sürümü var.\nDevam etmek için uygulamayı güncelleyin",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Invitaty sunucusuna bağlanılamadı",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Uygulama şu anda bakımda. Daha sonra tekrar deneyin",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Hata"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Dikkat"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Görünen ad (isteğe bağlı)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("E-posta"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Hesap silinemedi. Tekrar deneyin",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Bu e-posta zaten kayıtlı",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Kodun süresi doldu",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Bir hata oluştu. Tekrar deneyin",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Kod geçersiz",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Kullanıcı adı veya şifre hatalı",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "E-posta geçersiz",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Şifre en az 6 karakter olmalıdır",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Kullanıcı adı 4–20 karakter olmalı ve yalnızca harf, rakam, tire ve alt çizgi içerebilir.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Zorunlu alanlar eksik",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Kullanıcı adı veya e-posta girin",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Kayıt tamamlanamadı. Tekrar deneyin",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Oturum oluşturulamadı. Daha sonra deneyin",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Maksimum deneme sayısı aşıldı",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Çok fazla deneme. Daha sonra deneyin",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Bu kullanıcı adı zaten alınmış",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Şifre hatalı",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Görsel işlenemedi",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Genişlet"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Filmler, diziler ve diğer görsel-işitsel içerikler için bir veritabanı sunan; üyelerle etkileşim, listeler, puanlar ve incelemeler gibi özellikler içeren bir uygulamadır.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Invitaty nedir?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Hayır, Invitaty bir yayın uygulaması değildir; yalnızca içerikle ilgili çeşitli özelliklere sahip bir veritabanıdır.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Film ve dizi izlenebilir mi?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Hesabınızı uygulamadaki hesap ayarlarından silebilirsiniz. Hesabınızla ilişkili her şey kaldırılır. Bu işlem geri alınamaz.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Hesabımı nasıl silerim?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("Bu alan zorunludur"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Şifrenizi mi unuttunuz?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage("Genel ayarlar"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage("Sistem ayarları açılamadı"),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Ayarlar kaydedilemedi. Bağlantınızı kontrol edip tekrar deneyin",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Ayarlar kaydedilemiyor. Tekrar giriş yapın",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Ayarlar kaydedildi",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Ana sayfaya git"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Geçersiz e-posta"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Oturumu açık tut"),
    "language": MessageLookupByLibrary.simpleMessage("Dil"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arapça"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Katalanca"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Çince"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Felemenkçe"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("İngilizce"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Fransızca"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Almanca"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hintçe"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Endonezce"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("İtalyanca"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japonca"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Korece"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Lehçe"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portekizce"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Romence"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Rusça"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("İspanyolca"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("İsveççe"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Türkçe"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukraynaca"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Son çevrimiçi",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Yasal uyarı"),
    "loading": MessageLookupByLibrary.simpleMessage("Yükleniyor..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Çıkış yap"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Tümünü okundu işaretle",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Sosyal medya",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Ana sayfa"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Şifre değiştirildi",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Hesap silinemedi",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Hesap silindi",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Bir hata oluştu",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Profil güncellenemedi",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profil güncellendi",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Sil"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Bu mesaj silinsin mi?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("Mesaj silindi"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Düzenle"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("düzenlendi"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Henüz sohbetiniz yok",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Mesaj silinemedi",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Mesaj düzenlenemedi",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Mesaj gönderilemedi",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Henüz mesaj yok. Bir şey yazın!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Okundu"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Gönder"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Gönderildi"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage("Mesaj yazın..."),
    "newPassword": MessageLookupByLibrary.simpleMessage("Yeni şifre"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("Başka kayıt yok"),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Tüm bildirimler silinsin mi?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Tüm bildirimler okundu olarak işaretlensin mi?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Bildirim okundu olarak işaretlenemedi",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Bildirim okundu olarak işaretlendi.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Tüm bildirimler okundu olarak işaretlendi",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Bildirimler silinemedi",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Bildirimler silindi",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Bildiriminiz yok",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Bildirimler"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Cihaz bildirim izinleri",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Ayarları aç",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("KAPALI"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("AÇIK"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Güvenlik nedeniyle tarayıcı ayarlarını açamıyoruz. Bu site için bildirimlere izin vermek veya engellemek için adres çubuğundaki kilit simgesine dokunun → Site ayarları → Bildirimler.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Tarayıcıda bildirimler",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Şifre"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Şifre başarıyla sıfırlandı",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "En az 6 karakter",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Şifreler eşleşmiyor",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Gizlilik politikası",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Özel mesajlar"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Kullanıcı profili",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Anlık bildirimler",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Captcha doğrulanamadı. Tekrar deneyin.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Kayıt hatası"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Tanıtım ve ticari iletiler almayı kabul ediyorum",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Okudum ve kabul ediyorum:",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Şartları ve gizlilik politikasını kabul etmelisiniz",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Tarihi kaldır",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Ülkeyi kaldır",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Yeniden dene"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Kod gönder"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("Mesaj gönder"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Ayarlar"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Paylaş"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Paylaş"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Profilimi göster"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("QR göster"),
    "signIn": MessageLookupByLibrary.simpleMessage("Giriş yap"),
    "signUp": MessageLookupByLibrary.simpleMessage("Hesap oluştur"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("E-posta"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Bizi sosyal medyada takip edin.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Bağlantı açılamadı",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "WhatsApp açılamadı",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Durum"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Invitaty iletişim"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Şartlar ve koşullar",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Yardıma mı ihtiyacınız var? Kanallarımızdan biriyle bize ulaşın; en kısa sürede yanıt verelim.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Görünen ad",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "E-posta zorunludur",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "E-posta geçersiz",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Doğum tarihi",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Ülke"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Koyu tema"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Açık tema"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Açıklama"),
    "userEmail": MessageLookupByLibrary.simpleMessage("E-posta"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Bu kullanıcı bulunamadı",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Kullanıcı adı veya e-posta",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("İletişim"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("SSS"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage(
      "Çıkış yap",
    ),
    "userYears": MessageLookupByLibrary.simpleMessage("yaş"),
    "username": MessageLookupByLibrary.simpleMessage("Kullanıcı adı"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "En az 4 karakter",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Doğrulama kodu (6 hane)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Sürüm"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://siteniz.com"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Web sitesi / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Haftanın ilk günü"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Pazartesi"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Pazar"),
    "welcome": MessageLookupByLibrary.simpleMessage("Hoş geldiniz!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("Hatalı bilgiler"),
  };
}
