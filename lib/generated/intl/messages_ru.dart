// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(seconds) =>
      "Неверное имя пользователя или пароль.\nПодождите ${seconds} секунд перед повторной попыткой";

  static String m1(username) => "Профиль @${username} в Invitaty";

  static String m2(username) => "QR @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки аккаунта",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("Нет"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Да"),
    "andLabel": MessageLookupByLibrary.simpleMessage("и"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Первый выпуск Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Список изменений",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("О себе"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Сменить пароль",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Удалить аватар",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Обновить",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Код должен состоять из 6 цифр",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Если аккаунт существует, код отправлен на email",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Политика cookie",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Ссылка скопирована",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage(
      "Копировать ссылку",
    ),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Текущая версия",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Текущий пароль"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Доступная версия",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Формат даты"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Удалить все уведомления",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Действительно выйти из приложения?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Выйти из приложения",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Действительно выйти из аккаунта?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Сохранить изменения?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Действительно удалить аккаунт? Это действие необратимо.\nВведите пароль для подтверждения.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Пароль",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Доступна новая версия Invitaty.\nОбновите приложение, чтобы продолжить",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Не удалось подключиться к серверу Invitaty",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Приложение на обслуживании. Попробуйте позже",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Внимание"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Отображаемое имя (необязательно)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить аккаунт. Попробуйте снова",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Этот email уже зарегистрирован",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Срок действия кода истёк",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Произошла ошибка. Попробуйте снова",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Код недействителен",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Неверное имя пользователя или пароль",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Неверный email",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Пароль должен содержать не менее 6 символов",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя должно быть от 4 до 20 символов и содержать только буквы, цифры, дефисы и подчёркивания.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Не заполнены обязательные поля",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Укажите имя пользователя или email",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось завершить регистрацию. Попробуйте снова",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать сессию. Попробуйте позже",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Превышено максимальное число попыток",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Слишком много попыток. Попробуйте позже",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Это имя пользователя уже занято",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Неверный пароль",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Не удалось обработать изображение",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Развернуть"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Это приложение с базой фильмов, сериалов и другого аудиовизуального контента, инструментами для общения с участниками, списками, оценками и отзывами.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Что такое Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Нет, Invitaty — не стриминговое приложение; это база данных с различными функциями вокруг контента.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Можно ли смотреть фильмы и сериалы?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт можно в настройках аккаунта в приложении. Будут удалены все связанные данные. Это действие необратимо.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Как удалить аккаунт?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Это поле обязательно",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("Общие настройки"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Не удалось открыть системные настройки",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить настройки. Проверьте подключение и попробуйте снова",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить настройки. Войдите снова",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Настройки сохранены",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("На главную"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Неверный email"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Оставаться в системе"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Арабский"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Каталанский"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Китайский"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Нидерландский"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Английский"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Французский"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Немецкий"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Хинди"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Индонезийский"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Итальянский"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Японский"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Корейский"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Польский"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Португальский"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Румынский"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Русский"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Испанский"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Шведский"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Турецкий"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Украинский"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Последний визит",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage(
      "Правовая информация",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Отметить всё как прочитанное",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("Соцсети"),
    "menuHome": MessageLookupByLibrary.simpleMessage("Главная"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Пароль успешно изменён",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить аккаунт",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Аккаунт успешно удалён",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Произошла ошибка",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить профиль",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно обновлён",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Удалить это сообщение?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Сообщение удалено",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Изменить"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("изменено"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "У вас пока нет бесед",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить сообщение",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Не удалось изменить сообщение",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Не удалось отправить сообщение",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Пока нет сообщений. Напишите что-нибудь!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Прочитано"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Отправить"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Отправлено"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Напишите сообщение...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("Больше записей нет"),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Удалить все уведомления?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Отметить все уведомления как прочитанные?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Не удалось отметить уведомление как прочитанное",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Уведомление отмечено как прочитанное.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Все уведомления отмечены как прочитанные",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить уведомления",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Уведомления удалены",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "У вас нет уведомлений",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Уведомления"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Разрешения на уведомления устройства",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Открыть настройки",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("ВЫКЛ"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("ВКЛ"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Из соображений безопасности мы не можем открыть настройки браузера. Чтобы разрешить или заблокировать уведомления для этого сайта, нажмите на замок рядом с адресом → Настройки сайта → Уведомления.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Уведомления в браузере",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Пароль успешно сброшен",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Не менее 6 символов",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Личные сообщения"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Профиль пользователя",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Push-уведомления",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Не удалось подтвердить капчу. Попробуйте снова.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Ошибка регистрации"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Я согласен(на) получать рекламные и коммерческие сообщения",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Я прочитал(а) и принимаю",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Необходимо принять условия использования и политику конфиденциальности",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Убрать дату",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Убрать страну",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Повторить"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Отправить код"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Отправить сообщение",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Настройки"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Мой профиль"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Показать QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Войти"),
    "signUp": MessageLookupByLibrary.simpleMessage("Создать аккаунт"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage(
      "Электронная почта",
    ),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Подписывайтесь на нас в соцсетях.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть ссылку",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Статус"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Связь с Invitaty"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Условия использования",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Нужна помощь? Напишите нам в любой из каналов — ответим как можно скорее.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Отображаемое имя",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "Email обязателен",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "Неверный email",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Дата рождения",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Страна"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Тёмная тема"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Светлая тема"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Аватар"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Описание"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Пользователь не найден",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя или email",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Контакты"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("Частые вопросы"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Выйти"),
    "userYears": MessageLookupByLibrary.simpleMessage("лет"),
    "username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Не менее 4 символов",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Код подтверждения (6 цифр)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Версия"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://ваш-сайт.ru"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Сайт / блог"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Первый день недели"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Понедельник"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Воскресенье"),
    "welcome": MessageLookupByLibrary.simpleMessage("Добро пожаловать!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("Неверные данные"),
  };
}
