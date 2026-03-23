// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m0(seconds) =>
      "Nama pengguna atau kata sandi salah.\nHarap tunggu ${seconds} detik sebelum mencoba lagi";

  static String m1(username) => "Profil @${username} di Invitaty";

  static String m2(username) => "QR @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("Pengaturan akun"),
    "actionNo": MessageLookupByLibrary.simpleMessage("Tidak"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Ya"),
    "andLabel": MessageLookupByLibrary.simpleMessage("dan"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Rilis awal Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Log perubahan",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Kembali"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Ubah kata sandi",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Tutup"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Konfirmasi"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("Hapus akun"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("Hapus avatar"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Muat ulang",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Tutup"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Kode harus berisi 6 digit",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Jika akun ada, kode telah dikirim ke email Anda",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Ciutkan"),
    "confirm": MessageLookupByLibrary.simpleMessage("Konfirmasi"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi kata sandi",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Kebijakan cookie",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Tautan disalin",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Salin tautan"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Versi saat ini",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi saat ini",
    ),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Versi tersedia",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Format tanggal"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Hapus semua notifikasi",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Yakin ingin keluar dari aplikasi?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Keluar dari aplikasi",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Yakin ingin keluar?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Simpan perubahan?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Yakin ingin menghapus akun? Tindakan ini tidak dapat dibatalkan.\nMasukkan kata sandi untuk mengonfirmasi.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Versi baru Invitaty tersedia.\nPerbarui aplikasi untuk melanjutkan",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat terhubung ke server Invitaty",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Aplikasi sedang dalam pemeliharaan. Coba lagi nanti",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Kesalahan"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Perhatian"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Nama tampilan (opsional)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menghapus akun. Coba lagi",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Email sudah terdaftar",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Kode telah kedaluwarsa",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan. Coba lagi",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Kode tidak valid",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Nama pengguna atau kata sandi salah",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Email tidak valid",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi minimal 6 karakter",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Nama pengguna harus 4–20 karakter dan hanya mengandung huruf, angka, tanda hubung, dan garis bawah.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Bidang wajib kosong",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Masukkan nama pengguna atau email",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menyelesaikan pendaftaran. Coba lagi",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat membuat sesi. Coba lagi nanti",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Melebihi jumlah percobaan maksimum",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Terlalu banyak percobaan. Coba lagi nanti",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Nama pengguna sudah digunakan",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi salah",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memproses gambar",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Luaskan"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Ini adalah aplikasi untuk membuat undangan untuk berbagai jenis acara. Anda dapat memilih template, menyesuaikan undangan, membagikannya di media sosial, menerima notifikasi konfirmasi, dan memantau kehadiran.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Apa itu Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Tidak, Anda dapat menggunakan Invitaty untuk mendesain undangan Anda, tetapi untuk mempublikasikannya Anda perlu melakukan pembayaran untuk setiap undangan.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage("Apakah gratis?"),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Anda dapat menghapus akun di pengaturan akun dalam aplikasi. Semua data terkait akan dihapus. Tindakan ini tidak dapat dibatalkan.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Bagaimana cara menghapus akun saya?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Bidang ini wajib diisi",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Lupa kata sandi?"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("Pengaturan umum"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Tidak dapat membuka pengaturan sistem",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menyimpan pengaturan. Periksa koneksi dan coba lagi",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menyimpan pengaturan. Masuk lagi",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Pengaturan berhasil disimpan",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Ke beranda"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Create invitation",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tap Create invitation to get started.",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "No invitations created yet.",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Email tidak valid"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Tetap masuk"),
    "language": MessageLookupByLibrary.simpleMessage("Bahasa"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arab"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Katalan"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Mandarin"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Belanda"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Inggris"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Prancis"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Jerman"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesia"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italia"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Jepang"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Korea"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polandia"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portugis"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Rumania"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Rusia"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Spanyol"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Swedia"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turki"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukraina"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Terakhir online",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage(
      "Pemberitahuan hukum",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Memuat..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Keluar"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Tandai semua sebagai dibaca",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Media sosial",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Beranda"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Kata sandi berhasil diubah",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menghapus akun",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Akun berhasil dihapus",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memperbarui profil",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profil berhasil diperbarui",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Hapus"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Hapus pesan ini?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("Pesan dihapus"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("diedit"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Anda belum memiliki percakapan",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menghapus pesan",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat mengedit pesan",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat mengirim pesan",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Belum ada pesan. Tulis sesuatu!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Dibaca"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Kirim"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Terkirim"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage("Tulis pesan..."),
    "newPassword": MessageLookupByLibrary.simpleMessage("Kata sandi baru"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "Tidak ada lagi data",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Hapus semua notifikasi?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Tandai semua notifikasi sebagai dibaca?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menandai notifikasi sebagai dibaca",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Notifikasi ditandai sebagai dibaca.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Semua notifikasi ditandai sebagai dibaca",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menghapus notifikasi",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Notifikasi dihapus",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Anda tidak memiliki notifikasi",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Notifikasi"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Izin notifikasi perangkat",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Buka pengaturan",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("MATI"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("NYALA"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Demi keamanan, kami tidak dapat membuka pengaturan browser. Untuk mengizinkan atau memblokir notifikasi situs ini, ketuk ikon gembok di samping alamat → Pengaturan situs → Notifikasi.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifikasi di browser",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Kata sandi"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Kata sandi berhasil diatur ulang",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Minimal 6 karakter",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Kata sandi tidak cocok",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Kebijakan privasi",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Pesan pribadi"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Profil pengguna",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notifikasi push",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memverifikasi captcha. Coba lagi.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Kesalahan pendaftaran",
    ),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Saya setuju menerima promosi dan komunikasi komersial",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Saya telah membaca dan menerima",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Anda harus menerima syarat dan ketentuan serta kebijakan privasi",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Hapus tanggal",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Hapus negara",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Coba lagi"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Kirim kode"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("Kirim pesan"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Bagikan"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Bagikan"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Lihat profil saya"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Tampilkan QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Masuk"),
    "signUp": MessageLookupByLibrary.simpleMessage("Buat akun"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Ikuti kami di media sosial.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat membuka tautan",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat membuka WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Kontak Invitaty"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Syarat dan ketentuan",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Butuh bantuan? Hubungi kami melalui saluran mana pun — kami akan merespons secepat mungkin.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nama tampilan",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "Email wajib diisi",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "Email tidak valid",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Tanggal lahir",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Negara"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Mode gelap"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Mode terang"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Deskripsi"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Kami tidak menemukan pengguna ini",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Nama pengguna atau email",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Kontak"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQ"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Keluar"),
    "userYears": MessageLookupByLibrary.simpleMessage("tahun"),
    "username": MessageLookupByLibrary.simpleMessage("Nama pengguna"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Minimal 4 karakter",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Kode verifikasi (6 digit)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Versi"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage(
      "https://situsanda.com",
    ),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Situs / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Hari pertama minggu"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Senin"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Minggu"),
    "welcome": MessageLookupByLibrary.simpleMessage("Selamat datang!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Kredensial salah",
    ),
  };
}
