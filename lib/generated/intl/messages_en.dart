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

  static String m0(seconds) =>
      "Incorrect username or password.\nPlease wait ${seconds} seconds before trying again.";

  static String m1(username) => "Profile of @${username} on Invitaty";

  static String m2(username) => "QR for @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("Account settings"),
    "actionNo": MessageLookupByLibrary.simpleMessage("No"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Yes"),
    "andLabel": MessageLookupByLibrary.simpleMessage("and"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Initial release of Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Changelog",
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
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Current version",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current password"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Available version",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Date format"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Delete all notifications",
    ),
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
    "email": MessageLookupByLibrary.simpleMessage("Email"),
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
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Could not process the image.",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Expand"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "It is an app with a database of films, series and other audiovisual content, with tools that let users interact with other members, create lists, add ratings and reviews, and more.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("What is Invitaty?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "No, Invitaty is not a streaming app; it only works as a database with various features around that content.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Can I watch films and series?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "How do I delete my account?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
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
    "goToHome": MessageLookupByLibrary.simpleMessage("Go to home"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Keep me signed in"),
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
    "sendCode": MessageLookupByLibrary.simpleMessage("Send code"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("Send message"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Settings"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Share"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Share"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("View my profile"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Show QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "signUp": MessageLookupByLibrary.simpleMessage("Create account"),
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
