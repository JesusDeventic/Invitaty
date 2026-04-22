// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m3(number) => "Evento ${number}";

  static String m4(days, hours, minutes) =>
      "${days} días · ${hours} horas · ${minutes} minutos";

  static String m0(seconds) =>
      "Incorrect username or password.\nPlease wait ${seconds} seconds before trying again.";

  static String m1(username) => "Profile of @${username} on Invitaty";

  static String m2(username) => "QR for @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("Account settings"),
    "actionNo": MessageLookupByLibrary.simpleMessage("No"),
    "actionPause": MessageLookupByLibrary.simpleMessage("Pausar"),
    "actionPlay": MessageLookupByLibrary.simpleMessage("Reproducir"),
    "actionPlayVideo": MessageLookupByLibrary.simpleMessage("Ver vídeo"),
    "actionPreview": MessageLookupByLibrary.simpleMessage("Vista previa"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Yes"),
    "addEventAgenda": MessageLookupByLibrary.simpleMessage("Añadir evento"),
    "addFieldsRsvp": MessageLookupByLibrary.simpleMessage(
      "Añade los campos que quieras que aparezcan en el formulario",
    ),
    "addModule": MessageLookupByLibrary.simpleMessage("Añadir módulo"),
    "addVideo": MessageLookupByLibrary.simpleMessage("Añadir vídeo"),
    "additionalNotes": MessageLookupByLibrary.simpleMessage(
      "Notas adicionales",
    ),
    "agendaEventNumber": m3,
    "agreeAttendance": MessageLookupByLibrary.simpleMessage(
      "Confirmar asistencia",
    ),
    "andLabel": MessageLookupByLibrary.simpleMessage("and"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Initial release of Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Changelog",
    ),
    "attendanceConfirmation": MessageLookupByLibrary.simpleMessage(
      "Confirmación de asistencia",
    ),
    "authRequiredFunctionAction": MessageLookupByLibrary.simpleMessage("GO"),
    "authRequiredFunctionMessage": MessageLookupByLibrary.simpleMessage(
      "This feature requires you to sign in",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change password",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Close"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Delete account",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("Remove avatar"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage("Reload"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "The code must be 6 digits",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "If the account exists, a code has been sent to your email.",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Collapse"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("Cookie policy"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Link copied",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Copy link"),
    "countdownFull": m4,
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Current version",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current password"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Available version",
    ),
    "dateCountdown": MessageLookupByLibrary.simpleMessage("Fecha"),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Date format"),
    "dateNotSet": MessageLookupByLibrary.simpleMessage("Fecha no definida"),
    "deleteAgenda": MessageLookupByLibrary.simpleMessage("Eliminar agenda"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Delete all notifications",
    ),
    "deleteCountdown": MessageLookupByLibrary.simpleMessage(
      "Eliminar cuenta atrás",
    ),
    "deleteDresscode": MessageLookupByLibrary.simpleMessage(
      "Eliminar código de vestimenta",
    ),
    "deleteGallery": MessageLookupByLibrary.simpleMessage("Eliminar galería"),
    "deleteGifts": MessageLookupByLibrary.simpleMessage("Eliminar regalos"),
    "deleteLocation": MessageLookupByLibrary.simpleMessage(
      "Eliminar ubicación",
    ),
    "deleteModuleConfirmation": MessageLookupByLibrary.simpleMessage(
      "¿Estás seguro de que quieres eliminar este módulo? Esta acción no se puede deshacer",
    ),
    "deleteMusic": MessageLookupByLibrary.simpleMessage("Eliminar música"),
    "deleteRsvp": MessageLookupByLibrary.simpleMessage(
      "Eliminar formulario de asistencia",
    ),
    "deleteText": MessageLookupByLibrary.simpleMessage("Eliminar texto"),
    "deleteVideo": MessageLookupByLibrary.simpleMessage("Eliminar vídeos"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to exit the app?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("Exit the app"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Save your changes?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Password",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "A new version of Invitaty is available.\nUpdate the app to continue.",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Could not connect to the Invitaty server.",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "The app is currently under maintenance. Please try again later.",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Attention"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Display name (optional)",
    ),
    "dressCodeCasual": MessageLookupByLibrary.simpleMessage("Casual"),
    "dressCodeCostume": MessageLookupByLibrary.simpleMessage("Disfraces"),
    "dressCodeElegant": MessageLookupByLibrary.simpleMessage("Elegante"),
    "dressCodeFormal": MessageLookupByLibrary.simpleMessage("Formal"),
    "dressCodeFree": MessageLookupByLibrary.simpleMessage("Libre"),
    "dressCodeSwimwear": MessageLookupByLibrary.simpleMessage("Traje de baño"),
    "dressCodeThematic": MessageLookupByLibrary.simpleMessage("Temático"),
    "editAddGift": MessageLookupByLibrary.simpleMessage("Añadir regalo"),
    "editAgenda": MessageLookupByLibrary.simpleMessage("Editar agenda"),
    "editColor": MessageLookupByLibrary.simpleMessage("Color"),
    "editContent": MessageLookupByLibrary.simpleMessage("Contenido"),
    "editCountdown": MessageLookupByLibrary.simpleMessage(
      "Editar cuenta atrás",
    ),
    "editCover": MessageLookupByLibrary.simpleMessage("Editar portada"),
    "editDescription": MessageLookupByLibrary.simpleMessage("Descripción"),
    "editDressType": MessageLookupByLibrary.simpleMessage("Tipo de vestimenta"),
    "editDresscode": MessageLookupByLibrary.simpleMessage(
      "Editar código de vestimenta",
    ),
    "editField": MessageLookupByLibrary.simpleMessage("Editar campo"),
    "editFont": MessageLookupByLibrary.simpleMessage("Fuente"),
    "editGallery": MessageLookupByLibrary.simpleMessage("Editar galería"),
    "editGalleryInstructions": MessageLookupByLibrary.simpleMessage(
      "Imágenes (mantén pulsado para arrastrar y mover)",
    ),
    "editGalleryNoImages": MessageLookupByLibrary.simpleMessage(
      "No hay imágenes",
    ),
    "editGiftIdeas": MessageLookupByLibrary.simpleMessage("Ideas de regalos"),
    "editGifts": MessageLookupByLibrary.simpleMessage("Editar regalos"),
    "editLocation": MessageLookupByLibrary.simpleMessage("Editar ubicación"),
    "editMusic": MessageLookupByLibrary.simpleMessage("Editar música"),
    "editRsvp": MessageLookupByLibrary.simpleMessage(
      "Editar formulario de asistencia",
    ),
    "editSubtitle": MessageLookupByLibrary.simpleMessage("Subtítulo"),
    "editText": MessageLookupByLibrary.simpleMessage("Editar texto"),
    "editTime": MessageLookupByLibrary.simpleMessage("Hora (ej: 18:00)"),
    "editTitle": MessageLookupByLibrary.simpleMessage("Título"),
    "editVideo": MessageLookupByLibrary.simpleMessage("Editar vídeos"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enterWithoutUser": MessageLookupByLibrary.simpleMessage(
      "Enter without user",
    ),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Could not delete the account. Please try again.",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "That email is already registered.",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "The code has expired.",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "The code is not valid.",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect username or password.",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "The email is not valid.",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters.",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Required fields are missing.",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "You must enter a username or email.",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Registration could not be completed. Please try again.",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Could not create a session. Please try again later.",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "You have exceeded the maximum number of attempts.",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later.",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "That username is already taken.",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect password.",
    ),
    "errorOpenLink": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el enlace",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Could not process the image.",
    ),
    "errorVideoPlay": MessageLookupByLibrary.simpleMessage(
      "No se pudo reproducir el vídeo",
    ),
    "eventAlreadyStarted": MessageLookupByLibrary.simpleMessage(
      "El evento ya ha comenzado",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Expand"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "It\'s an app to create invitations for all kinds of events. It lets you choose templates and personalize the invitation, share it on social media, receive confirmation notifications, and track attendance.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("What is Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "No, you can use Invitaty to design your invitations, but to publish them you need to make a payment for each one.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage("Is it free?"),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "How do I delete my account?",
    ),
    "fieldMandatory": MessageLookupByLibrary.simpleMessage("Campo obligatorio"),
    "fieldName": MessageLookupByLibrary.simpleMessage("Nombre del campo"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "fieldsAdded": MessageLookupByLibrary.simpleMessage(
      "Campos añadidos al formulario",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot your password?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage("General settings"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage("Could not open system settings."),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Could not save settings. Check your connection and try again.",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Settings cannot be saved. Please sign in again.",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Settings saved successfully.",
    ),
    "giftsList": MessageLookupByLibrary.simpleMessage("Ver lista de regalos"),
    "goToHome": MessageLookupByLibrary.simpleMessage("Go to home"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Create invitation",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tap Create invitation to get started",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "No invitations created yet",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "invitationEditor": MessageLookupByLibrary.simpleMessage(
      "Editor de invitación",
    ),
    "keepSession": MessageLookupByLibrary.simpleMessage("Keep me signed in"),
    "labelBizum": MessageLookupByLibrary.simpleMessage("Bizum"),
    "labelGuests": MessageLookupByLibrary.simpleMessage("Invitados"),
    "labelIban": MessageLookupByLibrary.simpleMessage("IBAN"),
    "labelLink": MessageLookupByLibrary.simpleMessage("Enlace"),
    "labelName": MessageLookupByLibrary.simpleMessage("Nombre"),
    "labelOptional": MessageLookupByLibrary.simpleMessage("Opcional"),
    "labelOptions": MessageLookupByLibrary.simpleMessage("Opciones"),
    "labelRequired": MessageLookupByLibrary.simpleMessage("Obligatorio"),
    "labelSave": MessageLookupByLibrary.simpleMessage("Guardar"),
    "labelSize": MessageLookupByLibrary.simpleMessage("Tamaño"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Catalan"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chinese"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Dutch"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("French"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("German"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesian"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italian"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japanese"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Korean"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polish"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portuguese"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Romanian"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Russian"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Spanish"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Swedish"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turkish"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukrainian"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage("Last seen"),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("Legal notice"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "locationAddress": MessageLookupByLibrary.simpleMessage("Dirección"),
    "locationGenerator": MessageLookupByLibrary.simpleMessage(
      "Generar enlace a Google Maps",
    ),
    "locationMaps": MessageLookupByLibrary.simpleMessage("Enlace Google Maps"),
    "locationName": MessageLookupByLibrary.simpleMessage("Nombre del lugar"),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Social media",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Home"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully.",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Could not delete account.",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Account deleted successfully.",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong.",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Could not update profile.",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully.",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Delete this message?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("Message deleted"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("edited"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "You have no conversations yet.",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Could not delete the message.",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Could not edit the message.",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Could not send the message.",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "No messages yet. Say something!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Read"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Send"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Sent"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Write a message...",
    ),
    "moduleNameAgenda": MessageLookupByLibrary.simpleMessage("Agenda"),
    "moduleNameCountdown": MessageLookupByLibrary.simpleMessage("Cuenta atrás"),
    "moduleNameCover": MessageLookupByLibrary.simpleMessage("Portada"),
    "moduleNameDefault": MessageLookupByLibrary.simpleMessage("Módulo"),
    "moduleNameDressCode": MessageLookupByLibrary.simpleMessage(
      "Código de vestimenta",
    ),
    "moduleNameGallery": MessageLookupByLibrary.simpleMessage("Galería"),
    "moduleNameGifts": MessageLookupByLibrary.simpleMessage("Regalos"),
    "moduleNameLocation": MessageLookupByLibrary.simpleMessage("Localización"),
    "moduleNameMusic": MessageLookupByLibrary.simpleMessage("Música"),
    "moduleNameRsvp": MessageLookupByLibrary.simpleMessage(
      "Formulario de asistencia",
    ),
    "moduleNameText": MessageLookupByLibrary.simpleMessage("Texto"),
    "moduleNameVideo": MessageLookupByLibrary.simpleMessage("Vídeo"),
    "musicErrorPlay": MessageLookupByLibrary.simpleMessage(
      "No se pudo reproducir la música",
    ),
    "nameGift": MessageLookupByLibrary.simpleMessage("Regalo"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("No more items."),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Delete all notifications?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Mark all notifications as read?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Could not mark the notification as read.",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Notification marked as read.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "All notifications marked as read.",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Could not delete notifications.",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Notifications deleted.",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "You have no notifications.",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Device notification permissions",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Open settings",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("OFF"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("ON"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications in the browser",
    ),
    "openMaps": MessageLookupByLibrary.simpleMessage("Ver en Google Maps"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Password reset successfully.",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "At least 6 characters",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "placeholderText": MessageLookupByLibrary.simpleMessage(
      "Texto de ayuda (opcional)",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Privacy policy",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Private messages"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "User profile",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Push notifications",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Could not verify the captcha. Please try again.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Registration error"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "I agree to receive promotions and marketing communications",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "I have read and accept the",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "You must accept the terms and conditions and privacy policy",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Remove date",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Remove country",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Retry"),
    "save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "selectImage": MessageLookupByLibrary.simpleMessage("Seleccionar imagen"),
    "selectTemplateTitle": MessageLookupByLibrary.simpleMessage(
      "Elije una plantilla",
    ),
    "selectTextColor": MessageLookupByLibrary.simpleMessage(
      "Seleccionar color texto",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send code"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("Send message"),
    "sentConfirmation": MessageLookupByLibrary.simpleMessage(
      "Confirmación enviada",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Settings"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Share"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Share"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("View my profile"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Show QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "signUp": MessageLookupByLibrary.simpleMessage("Create account"),
    "sizeSubtitle": MessageLookupByLibrary.simpleMessage("Tamaño subtítulo"),
    "sizeTitle": MessageLookupByLibrary.simpleMessage("Tamaño título"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Follow us on social media.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Could not open the link.",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Could not open WhatsApp.",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Invitaty contact"),
    "templateBaptismDesc": MessageLookupByLibrary.simpleMessage(
      "Estilo suave y familiar",
    ),
    "templateBaptismName": MessageLookupByLibrary.simpleMessage(
      "Bautizo / Comunión",
    ),
    "templateBirthdayDesc": MessageLookupByLibrary.simpleMessage(
      "Colorido y divertido",
    ),
    "templateBirthdayName": MessageLookupByLibrary.simpleMessage("Cumpleaños"),
    "templateChristmasDesc": MessageLookupByLibrary.simpleMessage(
      "Ambiente festivo navideño",
    ),
    "templateChristmasName": MessageLookupByLibrary.simpleMessage(
      "Felicitación estacional",
    ),
    "templateCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Empieza desde cero",
    ),
    "templateCustomName": MessageLookupByLibrary.simpleMessage("Personalizada"),
    "templatePartyDesc": MessageLookupByLibrary.simpleMessage(
      "Perfecto para eventos sociales",
    ),
    "templatePartyName": MessageLookupByLibrary.simpleMessage("Cena / Fiesta"),
    "templateWeddingDesc": MessageLookupByLibrary.simpleMessage(
      "Diseño clásico y romántico",
    ),
    "templateWeddingName": MessageLookupByLibrary.simpleMessage(
      "Boda elegante",
    ),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Terms and conditions",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Need help? Reach us through any of our channels and we will get back to you as soon as possible.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Display name",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Date of birth",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage(
      "Country",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light mode"),
    "timeCountdown": MessageLookupByLibrary.simpleMessage("Hora"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Bio"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "We could not find this user.",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("Username or email"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Contact"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQs"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Log out"),
    "userYears": MessageLookupByLibrary.simpleMessage("years old"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "At least 4 characters",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Verification code (6 digits)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://yoursite.com"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Website / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Start of week"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect credentials",
    ),
  };
}
