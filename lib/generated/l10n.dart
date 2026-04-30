// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Invitaty`
  String get appName {
    return Intl.message('Invitaty', name: 'appName', desc: '', args: []);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Create account`
  String get signUp {
    return Intl.message('Create account', name: 'signUp', desc: '', args: []);
  }

  /// `Username or email`
  String get userOrEmail {
    return Intl.message(
      'Username or email',
      name: 'userOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Keep me signed in`
  String get keepSession {
    return Intl.message(
      'Keep me signed in',
      name: 'keepSession',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Display name (optional)`
  String get displayName {
    return Intl.message(
      'Display name (optional)',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  }

  /// `Verification code (6 digits)`
  String get verificationCode {
    return Intl.message(
      'Verification code (6 digits)',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light mode`
  String get themeLight {
    return Intl.message('Light mode', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark mode`
  String get themeDark {
    return Intl.message('Dark mode', name: 'themeDark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Current version`
  String get currentAppVersionText {
    return Intl.message(
      'Current version',
      name: 'currentAppVersionText',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Could not verify the captcha. Please try again.`
  String get recaptchaError {
    return Intl.message(
      'Could not verify the captcha. Please try again.',
      name: 'recaptchaError',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'At least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `At least 4 characters`
  String get usernameMinLength {
    return Intl.message(
      'At least 4 characters',
      name: 'usernameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `I have read and accept the`
  String get registerTermsAndConditionsAccept {
    return Intl.message(
      'I have read and accept the',
      name: 'registerTermsAndConditionsAccept',
      desc: '',
      args: [],
    );
  }

  /// `I agree to receive promotions and marketing communications`
  String get registerMarketingConsentAccept {
    return Intl.message(
      'I agree to receive promotions and marketing communications',
      name: 'registerMarketingConsentAccept',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the terms and conditions and privacy policy`
  String get registerTermsAndConditionsError {
    return Intl.message(
      'You must accept the terms and conditions and privacy policy',
      name: 'registerTermsAndConditionsError',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get andLabel {
    return Intl.message('and', name: 'andLabel', desc: '', args: []);
  }

  /// `The code must be 6 digits`
  String get code6Digits {
    return Intl.message(
      'The code must be 6 digits',
      name: 'code6Digits',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message('Welcome!', name: 'welcome', desc: '', args: []);
  }

  /// `If the account exists, a code has been sent to your email.`
  String get codeSent {
    return Intl.message(
      'If the account exists, a code has been sent to your email.',
      name: 'codeSent',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully.`
  String get passwordChanged {
    return Intl.message(
      'Password reset successfully.',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Changelog`
  String get appVersionChangeLogTitle {
    return Intl.message(
      'Changelog',
      name: 'appVersionChangeLogTitle',
      desc: '',
      args: [],
    );
  }

  /// `v1.0.0`
  String get appVersion10Code {
    return Intl.message('v1.0.0', name: 'appVersion10Code', desc: '', args: []);
  }

  /// `·Initial release of Invitaty.`
  String get appVersion10Description {
    return Intl.message(
      '·Initial release of Invitaty.',
      name: 'appVersion10Description',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get languageArabic {
    return Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  }

  /// `Catalan`
  String get languageCatalan {
    return Intl.message('Catalan', name: 'languageCatalan', desc: '', args: []);
  }

  /// `Chinese`
  String get languageChinese {
    return Intl.message('Chinese', name: 'languageChinese', desc: '', args: []);
  }

  /// `Dutch`
  String get languageDutch {
    return Intl.message('Dutch', name: 'languageDutch', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `French`
  String get languageFrench {
    return Intl.message('French', name: 'languageFrench', desc: '', args: []);
  }

  /// `German`
  String get languageGerman {
    return Intl.message('German', name: 'languageGerman', desc: '', args: []);
  }

  /// `Hindi`
  String get languageHindi {
    return Intl.message('Hindi', name: 'languageHindi', desc: '', args: []);
  }

  /// `Indonesian`
  String get languageIndonesian {
    return Intl.message(
      'Indonesian',
      name: 'languageIndonesian',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get languageItalian {
    return Intl.message('Italian', name: 'languageItalian', desc: '', args: []);
  }

  /// `Japanese`
  String get languageJapanese {
    return Intl.message(
      'Japanese',
      name: 'languageJapanese',
      desc: '',
      args: [],
    );
  }

  /// `Korean`
  String get languageKorean {
    return Intl.message('Korean', name: 'languageKorean', desc: '', args: []);
  }

  /// `Polish`
  String get languagePolish {
    return Intl.message('Polish', name: 'languagePolish', desc: '', args: []);
  }

  /// `Portuguese`
  String get languagePortuguese {
    return Intl.message(
      'Portuguese',
      name: 'languagePortuguese',
      desc: '',
      args: [],
    );
  }

  /// `Romanian`
  String get languageRomanian {
    return Intl.message(
      'Romanian',
      name: 'languageRomanian',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get languageRussian {
    return Intl.message('Russian', name: 'languageRussian', desc: '', args: []);
  }

  /// `Spanish`
  String get languageSpanish {
    return Intl.message('Spanish', name: 'languageSpanish', desc: '', args: []);
  }

  /// `Swedish`
  String get languageSwedish {
    return Intl.message('Swedish', name: 'languageSwedish', desc: '', args: []);
  }

  /// `Turkish`
  String get languageTurkish {
    return Intl.message('Turkish', name: 'languageTurkish', desc: '', args: []);
  }

  /// `Ukrainian`
  String get languageUkrainian {
    return Intl.message(
      'Ukrainian',
      name: 'languageUkrainian',
      desc: '',
      args: [],
    );
  }

  /// `Private messages`
  String get privateMessages {
    return Intl.message(
      'Private messages',
      name: 'privateMessages',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsLabel {
    return Intl.message(
      'Notifications',
      name: 'notificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Push notifications`
  String get pushNotificationsLabel {
    return Intl.message(
      'Push notifications',
      name: 'pushNotificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `You have no notifications.`
  String get notificationsEmptyText {
    return Intl.message(
      'You have no notifications.',
      name: 'notificationsEmptyText',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get buttonReloadNotifications {
    return Intl.message(
      'Reload',
      name: 'buttonReloadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllAsRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Mark all notifications as read?`
  String get notificationMarkAllAsk {
    return Intl.message(
      'Mark all notifications as read?',
      name: 'notificationMarkAllAsk',
      desc: '',
      args: [],
    );
  }

  /// `Notification marked as read.`
  String get notificationMarkedRead {
    return Intl.message(
      'Notification marked as read.',
      name: 'notificationMarkedRead',
      desc: '',
      args: [],
    );
  }

  /// `All notifications marked as read.`
  String get notificationsAllMarkedRead {
    return Intl.message(
      'All notifications marked as read.',
      name: 'notificationsAllMarkedRead',
      desc: '',
      args: [],
    );
  }

  /// `Could not mark the notification as read.`
  String get notificationMarkReadError {
    return Intl.message(
      'Could not mark the notification as read.',
      name: 'notificationMarkReadError',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications`
  String get deleteAllNotifications {
    return Intl.message(
      'Delete all notifications',
      name: 'deleteAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications?`
  String get notificationDeleteAllAsk {
    return Intl.message(
      'Delete all notifications?',
      name: 'notificationDeleteAllAsk',
      desc: '',
      args: [],
    );
  }

  /// `Notifications deleted.`
  String get notificationsDeletedOk {
    return Intl.message(
      'Notifications deleted.',
      name: 'notificationsDeletedOk',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete notifications.`
  String get notificationsDeletedError {
    return Intl.message(
      'Could not delete notifications.',
      name: 'notificationsDeletedError',
      desc: '',
      args: [],
    );
  }

  /// `No more items.`
  String get noMoreRecords {
    return Intl.message(
      'No more items.',
      name: 'noMoreRecords',
      desc: '',
      args: [],
    );
  }

  /// `Device notification permissions`
  String get notificationsPermissionHint {
    return Intl.message(
      'Device notification permissions',
      name: 'notificationsPermissionHint',
      desc: '',
      args: [],
    );
  }

  /// `ON`
  String get notificationsStatusOn {
    return Intl.message(
      'ON',
      name: 'notificationsStatusOn',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get notificationsStatusOff {
    return Intl.message(
      'OFF',
      name: 'notificationsStatusOff',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get notificationsPermissionOpenSettings {
    return Intl.message(
      'Open settings',
      name: 'notificationsPermissionOpenSettings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications in the browser`
  String get notificationsWebSettingsTitle {
    return Intl.message(
      'Notifications in the browser',
      name: 'notificationsWebSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.`
  String get notificationsWebSettingsBody {
    return Intl.message(
      'For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.',
      name: 'notificationsWebSettingsBody',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsLabel {
    return Intl.message('Settings', name: 'settingsLabel', desc: '', args: []);
  }

  /// `General settings`
  String get generalSettings {
    return Intl.message(
      'General settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved successfully.`
  String get generalSettingsSaveSuccess {
    return Intl.message(
      'Settings saved successfully.',
      name: 'generalSettingsSaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not save settings. Check your connection and try again.`
  String get generalSettingsSaveErrorGeneric {
    return Intl.message(
      'Could not save settings. Check your connection and try again.',
      name: 'generalSettingsSaveErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Settings cannot be saved. Please sign in again.`
  String get generalSettingsSaveErrorSession {
    return Intl.message(
      'Settings cannot be saved. Please sign in again.',
      name: 'generalSettingsSaveErrorSession',
      desc: '',
      args: [],
    );
  }

  /// `Could not open system settings.`
  String get generalSettingsOpenSystemSettingsError {
    return Intl.message(
      'Could not open system settings.',
      name: 'generalSettingsOpenSystemSettingsError',
      desc: '',
      args: [],
    );
  }

  /// `Start of week`
  String get weekStart {
    return Intl.message('Start of week', name: 'weekStart', desc: '', args: []);
  }

  /// `Monday`
  String get weekStartMonday {
    return Intl.message('Monday', name: 'weekStartMonday', desc: '', args: []);
  }

  /// `Sunday`
  String get weekStartSunday {
    return Intl.message('Sunday', name: 'weekStartSunday', desc: '', args: []);
  }

  /// `Date format`
  String get dateFormat {
    return Intl.message('Date format', name: 'dateFormat', desc: '', args: []);
  }

  /// `View my profile`
  String get showMyProfile {
    return Intl.message(
      'View my profile',
      name: 'showMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Account settings`
  String get accountSettings {
    return Intl.message(
      'Account settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get userSectionFAQs {
    return Intl.message('FAQs', name: 'userSectionFAQs', desc: '', args: []);
  }

  /// `Contact`
  String get userSectionContact {
    return Intl.message(
      'Contact',
      name: 'userSectionContact',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get userSectionSessionClose {
    return Intl.message(
      'Log out',
      name: 'userSectionSessionClose',
      desc: '',
      args: [],
    );
  }

  /// `Exit the app`
  String get dialogCloseAppTitle {
    return Intl.message(
      'Exit the app',
      name: 'dialogCloseAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit the app?`
  String get dialogCloseAppContent {
    return Intl.message(
      'Are you sure you want to exit the app?',
      name: 'dialogCloseAppContent',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get buttonClose {
    return Intl.message('Close', name: 'buttonClose', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get dialogCloseSessionContent {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'dialogCloseSessionContent',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get actionNo {
    return Intl.message('No', name: 'actionNo', desc: '', args: []);
  }

  /// `Yes`
  String get actionYes {
    return Intl.message('Yes', name: 'actionYes', desc: '', args: []);
  }

  /// `Home`
  String get menuHome {
    return Intl.message('Home', name: 'menuHome', desc: '', args: []);
  }

  /// `No invitations created yet`
  String get homeEmptyInvitationsTitle {
    return Intl.message(
      'No invitations created yet',
      name: 'homeEmptyInvitationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap Create invitation to get started`
  String get homeEmptyInvitationsSubtitle {
    return Intl.message(
      'Tap Create invitation to get started',
      name: 'homeEmptyInvitationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create invitation`
  String get homeCreateInvitationButton {
    return Intl.message(
      'Create invitation',
      name: 'homeCreateInvitationButton',
      desc: '',
      args: [],
    );
  }

  /// `Collapse`
  String get collapseMenu {
    return Intl.message('Collapse', name: 'collapseMenu', desc: '', args: []);
  }

  /// `Expand`
  String get expandMenu {
    return Intl.message('Expand', name: 'expandMenu', desc: '', args: []);
  }

  /// `Go to home`
  String get goToHome {
    return Intl.message('Go to home', name: 'goToHome', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Incorrect credentials`
  String get wrongCredentials {
    return Intl.message(
      'Incorrect credentials',
      name: 'wrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password.\nPlease wait {seconds} seconds before trying again.`
  String loginCountdownMessage(Object seconds) {
    return Intl.message(
      'Incorrect username or password.\nPlease wait $seconds seconds before trying again.',
      name: 'loginCountdownMessage',
      desc: '',
      args: [seconds],
    );
  }

  /// `Registration error`
  String get registerError {
    return Intl.message(
      'Registration error',
      name: 'registerError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message('Error', name: 'dialogErrorTitle', desc: '', args: []);
  }

  /// `Could not connect to the Invitaty server.`
  String get dialogErrorServerConnection {
    return Intl.message(
      'Could not connect to the Invitaty server.',
      name: 'dialogErrorServerConnection',
      desc: '',
      args: [],
    );
  }

  /// `A new version of Invitaty is available.\nUpdate the app to continue.`
  String get dialogErrorAppVersion {
    return Intl.message(
      'A new version of Invitaty is available.\nUpdate the app to continue.',
      name: 'dialogErrorAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `The app is currently under maintenance. Please try again later.`
  String get dialogErrorServerMaintenance {
    return Intl.message(
      'The app is currently under maintenance. Please try again later.',
      name: 'dialogErrorServerMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Available version`
  String get currentServerVersionText {
    return Intl.message(
      'Available version',
      name: 'currentServerVersionText',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get dialogWarningTitle {
    return Intl.message(
      'Attention',
      name: 'dialogWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save your changes?`
  String get dialogConfirmSave {
    return Intl.message(
      'Save your changes?',
      name: 'dialogConfirmSave',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Reach us through any of our channels and we will get back to you as soon as possible.`
  String get textUserSupportDescription {
    return Intl.message(
      'Need help? Reach us through any of our channels and we will get back to you as soon as possible.',
      name: 'textUserSupportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the link.`
  String get socialWebError {
    return Intl.message(
      'Could not open the link.',
      name: 'socialWebError',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get socialWhatsappLabel {
    return Intl.message(
      'WhatsApp',
      name: 'socialWhatsappLabel',
      desc: '',
      args: [],
    );
  }

  /// `Could not open WhatsApp.`
  String get socialWhatsappError {
    return Intl.message(
      'Could not open WhatsApp.',
      name: 'socialWhatsappError',
      desc: '',
      args: [],
    );
  }

  /// `Social media`
  String get menuBarSectionSocial {
    return Intl.message(
      'Social media',
      name: 'menuBarSectionSocial',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on social media.`
  String get socialNetworksText {
    return Intl.message(
      'Follow us on social media.',
      name: 'socialNetworksText',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPoliciesLabel {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPoliciesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditionsLabel {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cookie policy`
  String get cookiePolicyLabel {
    return Intl.message(
      'Cookie policy',
      name: 'cookiePolicyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Legal notice`
  String get legalNoticeLabel {
    return Intl.message(
      'Legal notice',
      name: 'legalNoticeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get socialMailLabel {
    return Intl.message('Email', name: 'socialMailLabel', desc: '', args: []);
  }

  /// `Telegram`
  String get socialTelegramLabel {
    return Intl.message(
      'Telegram',
      name: 'socialTelegramLabel',
      desc: '',
      args: [],
    );
  }

  /// `Invitaty contact`
  String get subjectSupport {
    return Intl.message(
      'Invitaty contact',
      name: 'subjectSupport',
      desc: '',
      args: [],
    );
  }

  /// `What is Invitaty?`
  String get faq1Question {
    return Intl.message(
      'What is Invitaty?',
      name: 'faq1Question',
      desc: '',
      args: [],
    );
  }

  /// `It's an app to create invitations for all kinds of events. It lets you choose templates and personalize the invitation, share it on social media, receive confirmation notifications, and track attendance.`
  String get faq1Answer {
    return Intl.message(
      'It\'s an app to create invitations for all kinds of events. It lets you choose templates and personalize the invitation, share it on social media, receive confirmation notifications, and track attendance.',
      name: 'faq1Answer',
      desc: '',
      args: [],
    );
  }

  /// `Is it free?`
  String get faq2Question {
    return Intl.message(
      'Is it free?',
      name: 'faq2Question',
      desc: '',
      args: [],
    );
  }

  /// `No, you can use Invitaty to design your invitations, but to publish them you need to make a payment for each one.`
  String get faq2Answer {
    return Intl.message(
      'No, you can use Invitaty to design your invitations, but to publish them you need to make a payment for each one.',
      name: 'faq2Answer',
      desc: '',
      args: [],
    );
  }

  /// `How do I delete my account?`
  String get faq3Question {
    return Intl.message(
      'How do I delete my account?',
      name: 'faq3Question',
      desc: '',
      args: [],
    );
  }

  /// `You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.`
  String get faq3Answer {
    return Intl.message(
      'You can delete your user from account settings in the app. This removes everything related to your user. This action cannot be undone.',
      name: 'faq3Answer',
      desc: '',
      args: [],
    );
  }

  /// `Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.`
  String get errorAuthInvalidUsername {
    return Intl.message(
      'Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.',
      name: 'errorAuthInvalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `The email is not valid.`
  String get errorAuthInvalidEmail {
    return Intl.message(
      'The email is not valid.',
      name: 'errorAuthInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get errorAuthInvalidPassword {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'errorAuthInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `That username is already taken.`
  String get errorAuthUsernameExists {
    return Intl.message(
      'That username is already taken.',
      name: 'errorAuthUsernameExists',
      desc: '',
      args: [],
    );
  }

  /// `That email is already registered.`
  String get errorAuthEmailExists {
    return Intl.message(
      'That email is already registered.',
      name: 'errorAuthEmailExists',
      desc: '',
      args: [],
    );
  }

  /// `Registration could not be completed. Please try again.`
  String get errorAuthRegisterFailed {
    return Intl.message(
      'Registration could not be completed. Please try again.',
      name: 'errorAuthRegisterFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not create a session. Please try again later.`
  String get errorAuthSessionFailed {
    return Intl.message(
      'Could not create a session. Please try again later.',
      name: 'errorAuthSessionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get errorAuthTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'errorAuthTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Required fields are missing.`
  String get errorAuthMissingFields {
    return Intl.message(
      'Required fields are missing.',
      name: 'errorAuthMissingFields',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password.`
  String get errorAuthInvalidCredentials {
    return Intl.message(
      'Incorrect username or password.',
      name: 'errorAuthInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `You must enter a username or email.`
  String get errorAuthMissingLogin {
    return Intl.message(
      'You must enter a username or email.',
      name: 'errorAuthMissingLogin',
      desc: '',
      args: [],
    );
  }

  /// `The code is not valid.`
  String get errorAuthInvalidCode {
    return Intl.message(
      'The code is not valid.',
      name: 'errorAuthInvalidCode',
      desc: '',
      args: [],
    );
  }

  /// `You have exceeded the maximum number of attempts.`
  String get errorAuthTooManyAttempts {
    return Intl.message(
      'You have exceeded the maximum number of attempts.',
      name: 'errorAuthTooManyAttempts',
      desc: '',
      args: [],
    );
  }

  /// `The code has expired.`
  String get errorAuthExpiredCode {
    return Intl.message(
      'The code has expired.',
      name: 'errorAuthExpiredCode',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get errorAuthGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'errorAuthGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password.`
  String get errorAuthWrongPassword {
    return Intl.message(
      'Incorrect password.',
      name: 'errorAuthWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete the account. Please try again.`
  String get errorAuthDeleteAccountFailed {
    return Intl.message(
      'Could not delete the account. Please try again.',
      name: 'errorAuthDeleteAccountFailed',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get userAvatar {
    return Intl.message('Avatar', name: 'userAvatar', desc: '', args: []);
  }

  /// `Remove avatar`
  String get buttonDeleteAvatar {
    return Intl.message(
      'Remove avatar',
      name: 'buttonDeleteAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get userDescription {
    return Intl.message('Bio', name: 'userDescription', desc: '', args: []);
  }

  /// `Email`
  String get userEmail {
    return Intl.message('Email', name: 'userEmail', desc: '', args: []);
  }

  /// `Country`
  String get textfieldUserCountryLabel {
    return Intl.message(
      'Country',
      name: 'textfieldUserCountryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get textfieldUserBirthdayLabel {
    return Intl.message(
      'Date of birth',
      name: 'textfieldUserBirthdayLabel',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get textfieldDisplayNameLabel {
    return Intl.message(
      'Display name',
      name: 'textfieldDisplayNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get textfieldMailEmpty {
    return Intl.message(
      'Email is required',
      name: 'textfieldMailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get textfieldMailError {
    return Intl.message(
      'Invalid email',
      name: 'textfieldMailError',
      desc: '',
      args: [],
    );
  }

  /// `years old`
  String get userYears {
    return Intl.message('years old', name: 'userYears', desc: '', args: []);
  }

  /// `Delete account`
  String get buttonDeleteAccount {
    return Intl.message(
      'Delete account',
      name: 'buttonDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.`
  String get dialogDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.',
      name: 'dialogDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get dialogDeleteAccountPassword {
    return Intl.message(
      'Password',
      name: 'dialogDeleteAccountPassword',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully.`
  String get messageUpdateSuccess {
    return Intl.message(
      'Profile updated successfully.',
      name: 'messageUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not update profile.`
  String get messageUpdateError {
    return Intl.message(
      'Could not update profile.',
      name: 'messageUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get messageGeneralError {
    return Intl.message(
      'Something went wrong.',
      name: 'messageGeneralError',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get messageDeleteAccountSuccess {
    return Intl.message(
      'Account deleted successfully.',
      name: 'messageDeleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete account.`
  String get messageDeleteAccountError {
    return Intl.message(
      'Could not delete account.',
      name: 'messageDeleteAccountError',
      desc: '',
      args: [],
    );
  }

  /// `Could not process the image.`
  String get errorProcessingImage {
    return Intl.message(
      'Could not process the image.',
      name: 'errorProcessingImage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get buttonConfirm {
    return Intl.message('Confirm', name: 'buttonConfirm', desc: '', args: []);
  }

  /// `Cancel`
  String get buttonCancel {
    return Intl.message('Cancel', name: 'buttonCancel', desc: '', args: []);
  }

  /// `You have no conversations yet.`
  String get messagesEmpty {
    return Intl.message(
      'You have no conversations yet.',
      name: 'messagesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet. Say something!`
  String get messagesNoMessages {
    return Intl.message(
      'No messages yet. Say something!',
      name: 'messagesNoMessages',
      desc: '',
      args: [],
    );
  }

  /// `Message deleted`
  String get messagesDeleted {
    return Intl.message(
      'Message deleted',
      name: 'messagesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `edited`
  String get messagesEdited {
    return Intl.message('edited', name: 'messagesEdited', desc: '', args: []);
  }

  /// `Write a message...`
  String get messagesTypeHint {
    return Intl.message(
      'Write a message...',
      name: 'messagesTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get messagesSend {
    return Intl.message('Send', name: 'messagesSend', desc: '', args: []);
  }

  /// `Edit`
  String get messagesEdit {
    return Intl.message('Edit', name: 'messagesEdit', desc: '', args: []);
  }

  /// `Delete`
  String get messagesDelete {
    return Intl.message('Delete', name: 'messagesDelete', desc: '', args: []);
  }

  /// `Delete this message?`
  String get messagesDeleteConfirm {
    return Intl.message(
      'Delete this message?',
      name: 'messagesDeleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get messagesRead {
    return Intl.message('Read', name: 'messagesRead', desc: '', args: []);
  }

  /// `Sent`
  String get messagesSent {
    return Intl.message('Sent', name: 'messagesSent', desc: '', args: []);
  }

  /// `Could not send the message.`
  String get messagesErrorSend {
    return Intl.message(
      'Could not send the message.',
      name: 'messagesErrorSend',
      desc: '',
      args: [],
    );
  }

  /// `Could not edit the message.`
  String get messagesErrorEdit {
    return Intl.message(
      'Could not edit the message.',
      name: 'messagesErrorEdit',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete the message.`
  String get messagesErrorDelete {
    return Intl.message(
      'Could not delete the message.',
      name: 'messagesErrorDelete',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get buttonChangePassword {
    return Intl.message(
      'Change password',
      name: 'buttonChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully.`
  String get messageChangePasswordSuccess {
    return Intl.message(
      'Password changed successfully.',
      name: 'messageChangePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `User profile`
  String get publicProfileAppBarTitle {
    return Intl.message(
      'User profile',
      name: 'publicProfileAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `We could not find this user.`
  String get userNotFoundPublicProfileText {
    return Intl.message(
      'We could not find this user.',
      name: 'userNotFoundPublicProfileText',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryPublicProfile {
    return Intl.message(
      'Retry',
      name: 'retryPublicProfile',
      desc: '',
      args: [],
    );
  }

  /// `Send message`
  String get sendMessageTooltip {
    return Intl.message(
      'Send message',
      name: 'sendMessageTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get shareTooltip {
    return Intl.message('Share', name: 'shareTooltip', desc: '', args: []);
  }

  /// `Copy link`
  String get copyProfileLink {
    return Intl.message(
      'Copy link',
      name: 'copyProfileLink',
      desc: '',
      args: [],
    );
  }

  /// `Link copied`
  String get copiedProfileLinkSnackbar {
    return Intl.message(
      'Link copied',
      name: 'copiedProfileLinkSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Show QR`
  String get showQrOption {
    return Intl.message('Show QR', name: 'showQrOption', desc: '', args: []);
  }

  /// `Share`
  String get shareOption {
    return Intl.message('Share', name: 'shareOption', desc: '', args: []);
  }

  /// `QR for @{username}`
  String qrTitle(Object username) {
    return Intl.message(
      'QR for @$username',
      name: 'qrTitle',
      desc: '',
      args: [username],
    );
  }

  /// `Profile of @{username} on Invitaty`
  String profileShareSubject(Object username) {
    return Intl.message(
      'Profile of @$username on Invitaty',
      name: 'profileShareSubject',
      desc: '',
      args: [username],
    );
  }

  /// `Last seen`
  String get lastAccessChipPrefix {
    return Intl.message(
      'Last seen',
      name: 'lastAccessChipPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusLabel {
    return Intl.message('Status', name: 'statusLabel', desc: '', args: []);
  }

  /// `Bio`
  String get bioLabel {
    return Intl.message('Bio', name: 'bioLabel', desc: '', args: []);
  }

  /// `Website / blog`
  String get webBlogLabel {
    return Intl.message(
      'Website / blog',
      name: 'webBlogLabel',
      desc: '',
      args: [],
    );
  }

  /// `https://yoursite.com`
  String get webBlogHint {
    return Intl.message(
      'https://yoursite.com',
      name: 'webBlogHint',
      desc: '',
      args: [],
    );
  }

  /// `Remove country`
  String get removeCountryTooltip {
    return Intl.message(
      'Remove country',
      name: 'removeCountryTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Remove date`
  String get removeBirthdateTooltip {
    return Intl.message(
      'Remove date',
      name: 'removeBirthdateTooltip',
      desc: '',
      args: [],
    );
  }

  /// `This feature requires you to sign in`
  String get authRequiredFunctionMessage {
    return Intl.message(
      'This feature requires you to sign in',
      name: 'authRequiredFunctionMessage',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get authRequiredFunctionAction {
    return Intl.message(
      'GO',
      name: 'authRequiredFunctionAction',
      desc: '',
      args: [],
    );
  }

  /// `Enter without user`
  String get enterWithoutUser {
    return Intl.message(
      'Enter without user',
      name: 'enterWithoutUser',
      desc: '',
      args: [],
    );
  }

  /// `Elije una plantilla`
  String get selectTemplateTitle {
    return Intl.message(
      'Elije una plantilla',
      name: 'selectTemplateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Boda elegante`
  String get templateWeddingName {
    return Intl.message(
      'Boda elegante',
      name: 'templateWeddingName',
      desc: '',
      args: [],
    );
  }

  /// `Diseño elegante y romántico`
  String get templateWeddingDesc {
    return Intl.message(
      'Diseño elegante y romántico',
      name: 'templateWeddingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Cumpleaños`
  String get templateBirthdayName {
    return Intl.message(
      'Cumpleaños',
      name: 'templateBirthdayName',
      desc: '',
      args: [],
    );
  }

  /// `Colorido y divertido`
  String get templateBirthdayDesc {
    return Intl.message(
      'Colorido y divertido',
      name: 'templateBirthdayDesc',
      desc: '',
      args: [],
    );
  }

  /// `Bautizo / Comunión`
  String get templateBaptismName {
    return Intl.message(
      'Bautizo / Comunión',
      name: 'templateBaptismName',
      desc: '',
      args: [],
    );
  }

  /// `Estilo suave y familiar`
  String get templateBaptismDesc {
    return Intl.message(
      'Estilo suave y familiar',
      name: 'templateBaptismDesc',
      desc: '',
      args: [],
    );
  }

  /// `Cena / Fiesta`
  String get templatePartyName {
    return Intl.message(
      'Cena / Fiesta',
      name: 'templatePartyName',
      desc: '',
      args: [],
    );
  }

  /// `Estilo minimalista, perfecto para eventos sociales`
  String get templatePartyDesc {
    return Intl.message(
      'Estilo minimalista, perfecto para eventos sociales',
      name: 'templatePartyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Felicitación estacional`
  String get templateChristmasName {
    return Intl.message(
      'Felicitación estacional',
      name: 'templateChristmasName',
      desc: '',
      args: [],
    );
  }

  /// `Ambiente festivo navideño`
  String get templateChristmasDesc {
    return Intl.message(
      'Ambiente festivo navideño',
      name: 'templateChristmasDesc',
      desc: '',
      args: [],
    );
  }

  /// `Personalizada`
  String get templateCustomName {
    return Intl.message(
      'Personalizada',
      name: 'templateCustomName',
      desc: '',
      args: [],
    );
  }

  /// `Empieza desde cero`
  String get templateCustomDesc {
    return Intl.message(
      'Empieza desde cero',
      name: 'templateCustomDesc',
      desc: '',
      args: [],
    );
  }

  /// `Editor de invitación`
  String get invitationEditor {
    return Intl.message(
      'Editor de invitación',
      name: 'invitationEditor',
      desc: '',
      args: [],
    );
  }

  /// `Texto`
  String get moduleNameText {
    return Intl.message('Texto', name: 'moduleNameText', desc: '', args: []);
  }

  /// `Portada`
  String get moduleNameCover {
    return Intl.message('Portada', name: 'moduleNameCover', desc: '', args: []);
  }

  /// `Cuenta atrás`
  String get moduleNameCountdown {
    return Intl.message(
      'Cuenta atrás',
      name: 'moduleNameCountdown',
      desc: '',
      args: [],
    );
  }

  /// `Localización y fecha`
  String get moduleNameLocation {
    return Intl.message(
      'Localización y fecha',
      name: 'moduleNameLocation',
      desc: '',
      args: [],
    );
  }

  /// `Formulario de asistencia`
  String get moduleNameRsvp {
    return Intl.message(
      'Formulario de asistencia',
      name: 'moduleNameRsvp',
      desc: '',
      args: [],
    );
  }

  /// `Galería`
  String get moduleNameGallery {
    return Intl.message(
      'Galería',
      name: 'moduleNameGallery',
      desc: '',
      args: [],
    );
  }

  /// `Vídeo`
  String get moduleNameVideo {
    return Intl.message('Vídeo', name: 'moduleNameVideo', desc: '', args: []);
  }

  /// `Agenda`
  String get moduleNameAgenda {
    return Intl.message('Agenda', name: 'moduleNameAgenda', desc: '', args: []);
  }

  /// `Código de vestimenta`
  String get moduleNameDressCode {
    return Intl.message(
      'Código de vestimenta',
      name: 'moduleNameDressCode',
      desc: '',
      args: [],
    );
  }

  /// `Regalos`
  String get moduleNameGifts {
    return Intl.message('Regalos', name: 'moduleNameGifts', desc: '', args: []);
  }

  /// `Música`
  String get moduleNameMusic {
    return Intl.message('Música', name: 'moduleNameMusic', desc: '', args: []);
  }

  /// `Módulo`
  String get moduleNameDefault {
    return Intl.message(
      'Módulo',
      name: 'moduleNameDefault',
      desc: '',
      args: [],
    );
  }

  /// `¿Estás seguro de que quieres eliminar este módulo? Esta acción no se puede deshacer`
  String get deleteModuleConfirmation {
    return Intl.message(
      '¿Estás seguro de que quieres eliminar este módulo? Esta acción no se puede deshacer',
      name: 'deleteModuleConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Añadir evento`
  String get addEventAgenda {
    return Intl.message(
      'Añadir evento',
      name: 'addEventAgenda',
      desc: '',
      args: [],
    );
  }

  /// `Editar agenda`
  String get editAgenda {
    return Intl.message(
      'Editar agenda',
      name: 'editAgenda',
      desc: '',
      args: [],
    );
  }

  /// `Descripción`
  String get editDescription {
    return Intl.message(
      'Descripción',
      name: 'editDescription',
      desc: '',
      args: [],
    );
  }

  /// `Título`
  String get editTitle {
    return Intl.message('Título', name: 'editTitle', desc: '', args: []);
  }

  /// `Hora (ej: 18:00)`
  String get editTime {
    return Intl.message(
      'Hora (ej: 18:00)',
      name: 'editTime',
      desc: '',
      args: [],
    );
  }

  /// `Evento {number}`
  String agendaEventNumber(Object number) {
    return Intl.message(
      'Evento $number',
      name: 'agendaEventNumber',
      desc: '',
      args: [number],
    );
  }

  /// `Eliminar agenda`
  String get deleteAgenda {
    return Intl.message(
      'Eliminar agenda',
      name: 'deleteAgenda',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar cuenta atrás`
  String get deleteCountdown {
    return Intl.message(
      'Eliminar cuenta atrás',
      name: 'deleteCountdown',
      desc: '',
      args: [],
    );
  }

  /// `Editar cuenta atrás`
  String get editCountdown {
    return Intl.message(
      'Editar cuenta atrás',
      name: 'editCountdown',
      desc: '',
      args: [],
    );
  }

  /// `Fecha`
  String get dateCountdown {
    return Intl.message('Fecha', name: 'dateCountdown', desc: '', args: []);
  }

  /// `Hora`
  String get timeCountdown {
    return Intl.message('Hora', name: 'timeCountdown', desc: '', args: []);
  }

  /// `Vista previa`
  String get actionPreview {
    return Intl.message(
      'Vista previa',
      name: 'actionPreview',
      desc: '',
      args: [],
    );
  }

  /// `El evento ya ha comenzado`
  String get eventAlreadyStarted {
    return Intl.message(
      'El evento ya ha comenzado',
      name: 'eventAlreadyStarted',
      desc: '',
      args: [],
    );
  }

  /// `{days} días · {hours} horas · {minutes} minutos`
  String countdownFull(Object days, Object hours, Object minutes) {
    return Intl.message(
      '$days días · $hours horas · $minutes minutos',
      name: 'countdownFull',
      desc: '',
      args: [days, hours, minutes],
    );
  }

  /// `Seleccionar color texto`
  String get selectTextColor {
    return Intl.message(
      'Seleccionar color texto',
      name: 'selectTextColor',
      desc: '',
      args: [],
    );
  }

  /// `Editar portada`
  String get editCover {
    return Intl.message(
      'Editar portada',
      name: 'editCover',
      desc: '',
      args: [],
    );
  }

  /// `Subtítulo`
  String get editSubtitle {
    return Intl.message('Subtítulo', name: 'editSubtitle', desc: '', args: []);
  }

  /// `Fuente`
  String get editFont {
    return Intl.message('Fuente', name: 'editFont', desc: '', args: []);
  }

  /// `Tamaño título`
  String get sizeTitle {
    return Intl.message('Tamaño título', name: 'sizeTitle', desc: '', args: []);
  }

  /// `Tamaño subtítulo`
  String get sizeSubtitle {
    return Intl.message(
      'Tamaño subtítulo',
      name: 'sizeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get editColor {
    return Intl.message('Color', name: 'editColor', desc: '', args: []);
  }

  /// `Seleccionar imagen`
  String get selectImage {
    return Intl.message(
      'Seleccionar imagen',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar código de vestimenta`
  String get deleteDresscode {
    return Intl.message(
      'Eliminar código de vestimenta',
      name: 'deleteDresscode',
      desc: '',
      args: [],
    );
  }

  /// `Editar código de vestimenta`
  String get editDresscode {
    return Intl.message(
      'Editar código de vestimenta',
      name: 'editDresscode',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de vestimenta`
  String get editDressType {
    return Intl.message(
      'Tipo de vestimenta',
      name: 'editDressType',
      desc: '',
      args: [],
    );
  }

  /// `Formal`
  String get dressCodeFormal {
    return Intl.message('Formal', name: 'dressCodeFormal', desc: '', args: []);
  }

  /// `Casual`
  String get dressCodeCasual {
    return Intl.message('Casual', name: 'dressCodeCasual', desc: '', args: []);
  }

  /// `Elegante`
  String get dressCodeElegant {
    return Intl.message(
      'Elegante',
      name: 'dressCodeElegant',
      desc: '',
      args: [],
    );
  }

  /// `Temático`
  String get dressCodeThematic {
    return Intl.message(
      'Temático',
      name: 'dressCodeThematic',
      desc: '',
      args: [],
    );
  }

  /// `Disfraces`
  String get dressCodeCostume {
    return Intl.message(
      'Disfraces',
      name: 'dressCodeCostume',
      desc: '',
      args: [],
    );
  }

  /// `Traje de baño`
  String get dressCodeSwimwear {
    return Intl.message(
      'Traje de baño',
      name: 'dressCodeSwimwear',
      desc: '',
      args: [],
    );
  }

  /// `Libre`
  String get dressCodeFree {
    return Intl.message('Libre', name: 'dressCodeFree', desc: '', args: []);
  }

  /// `Añadir módulo`
  String get addModule {
    return Intl.message('Añadir módulo', name: 'addModule', desc: '', args: []);
  }

  /// `Eliminar galería`
  String get deleteGallery {
    return Intl.message(
      'Eliminar galería',
      name: 'deleteGallery',
      desc: '',
      args: [],
    );
  }

  /// `Editar galería`
  String get editGallery {
    return Intl.message(
      'Editar galería',
      name: 'editGallery',
      desc: '',
      args: [],
    );
  }

  /// `Imágenes (mantén pulsado para arrastrar y mover)`
  String get editGalleryInstructions {
    return Intl.message(
      'Imágenes (mantén pulsado para arrastrar y mover)',
      name: 'editGalleryInstructions',
      desc: '',
      args: [],
    );
  }

  /// `No hay imágenes`
  String get editGalleryNoImages {
    return Intl.message(
      'No hay imágenes',
      name: 'editGalleryNoImages',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar regalos`
  String get deleteGifts {
    return Intl.message(
      'Eliminar regalos',
      name: 'deleteGifts',
      desc: '',
      args: [],
    );
  }

  /// `Regalo`
  String get nameGift {
    return Intl.message('Regalo', name: 'nameGift', desc: '', args: []);
  }

  /// `Editar regalos`
  String get editGifts {
    return Intl.message(
      'Editar regalos',
      name: 'editGifts',
      desc: '',
      args: [],
    );
  }

  /// `Opciones`
  String get labelOptions {
    return Intl.message('Opciones', name: 'labelOptions', desc: '', args: []);
  }

  /// `IBAN`
  String get labelIban {
    return Intl.message('IBAN', name: 'labelIban', desc: '', args: []);
  }

  /// `Bizum`
  String get labelBizum {
    return Intl.message('Bizum', name: 'labelBizum', desc: '', args: []);
  }

  /// `Enlace`
  String get labelLink {
    return Intl.message('Enlace', name: 'labelLink', desc: '', args: []);
  }

  /// `Ideas de regalos`
  String get editGiftIdeas {
    return Intl.message(
      'Ideas de regalos',
      name: 'editGiftIdeas',
      desc: '',
      args: [],
    );
  }

  /// `Añadir regalo`
  String get editAddGift {
    return Intl.message(
      'Añadir regalo',
      name: 'editAddGift',
      desc: '',
      args: [],
    );
  }

  /// `Ver lista de regalos`
  String get giftsList {
    return Intl.message(
      'Ver lista de regalos',
      name: 'giftsList',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar localización y fecha`
  String get deleteLocation {
    return Intl.message(
      'Eliminar localización y fecha',
      name: 'deleteLocation',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo abrir el enlace`
  String get errorOpenLink {
    return Intl.message(
      'No se pudo abrir el enlace',
      name: 'errorOpenLink',
      desc: '',
      args: [],
    );
  }

  /// `Editar ubicación y fecha`
  String get editLocation {
    return Intl.message(
      'Editar ubicación y fecha',
      name: 'editLocation',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del lugar`
  String get locationName {
    return Intl.message(
      'Nombre del lugar',
      name: 'locationName',
      desc: '',
      args: [],
    );
  }

  /// `Dirección`
  String get locationAddress {
    return Intl.message(
      'Dirección',
      name: 'locationAddress',
      desc: '',
      args: [],
    );
  }

  /// `Generar enlace a Google Maps`
  String get locationGenerator {
    return Intl.message(
      'Generar enlace a Google Maps',
      name: 'locationGenerator',
      desc: '',
      args: [],
    );
  }

  /// `Enlace Google Maps`
  String get locationMaps {
    return Intl.message(
      'Enlace Google Maps',
      name: 'locationMaps',
      desc: '',
      args: [],
    );
  }

  /// `Ver en Google Maps`
  String get openMaps {
    return Intl.message(
      'Ver en Google Maps',
      name: 'openMaps',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar música`
  String get deleteMusic {
    return Intl.message(
      'Eliminar música',
      name: 'deleteMusic',
      desc: '',
      args: [],
    );
  }

  /// `Editar música`
  String get editMusic {
    return Intl.message('Editar música', name: 'editMusic', desc: '', args: []);
  }

  /// `Pausar`
  String get actionPause {
    return Intl.message('Pausar', name: 'actionPause', desc: '', args: []);
  }

  /// `Reproducir`
  String get actionPlay {
    return Intl.message('Reproducir', name: 'actionPlay', desc: '', args: []);
  }

  /// `No se pudo reproducir la música`
  String get musicErrorPlay {
    return Intl.message(
      'No se pudo reproducir la música',
      name: 'musicErrorPlay',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar texto`
  String get deleteText {
    return Intl.message(
      'Eliminar texto',
      name: 'deleteText',
      desc: '',
      args: [],
    );
  }

  /// `Editar texto`
  String get editText {
    return Intl.message('Editar texto', name: 'editText', desc: '', args: []);
  }

  /// `Contenido`
  String get editContent {
    return Intl.message('Contenido', name: 'editContent', desc: '', args: []);
  }

  /// `Tamaño`
  String get labelSize {
    return Intl.message('Tamaño', name: 'labelSize', desc: '', args: []);
  }

  /// `Eliminar vídeos`
  String get deleteVideo {
    return Intl.message(
      'Eliminar vídeos',
      name: 'deleteVideo',
      desc: '',
      args: [],
    );
  }

  /// `Editar vídeos`
  String get editVideo {
    return Intl.message('Editar vídeos', name: 'editVideo', desc: '', args: []);
  }

  /// `Añadir vídeo`
  String get addVideo {
    return Intl.message('Añadir vídeo', name: 'addVideo', desc: '', args: []);
  }

  /// `Ver vídeo`
  String get actionPlayVideo {
    return Intl.message(
      'Ver vídeo',
      name: 'actionPlayVideo',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo reproducir el vídeo`
  String get errorVideoPlay {
    return Intl.message(
      'No se pudo reproducir el vídeo',
      name: 'errorVideoPlay',
      desc: '',
      args: [],
    );
  }

  /// `Fecha no definida`
  String get dateNotSet {
    return Intl.message(
      'Fecha no definida',
      name: 'dateNotSet',
      desc: '',
      args: [],
    );
  }

  /// `Campo obligatorio`
  String get fieldMandatory {
    return Intl.message(
      'Campo obligatorio',
      name: 'fieldMandatory',
      desc: '',
      args: [],
    );
  }

  /// `Confirmación enviada`
  String get sentConfirmation {
    return Intl.message(
      'Confirmación enviada',
      name: 'sentConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Confirmación de asistencia`
  String get attendanceConfirmation {
    return Intl.message(
      'Confirmación de asistencia',
      name: 'attendanceConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar asistencia`
  String get agreeAttendance {
    return Intl.message(
      'Confirmar asistencia',
      name: 'agreeAttendance',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar formulario de asistencia`
  String get deleteRsvp {
    return Intl.message(
      'Eliminar formulario de asistencia',
      name: 'deleteRsvp',
      desc: '',
      args: [],
    );
  }

  /// `Editar formulario de asistencia`
  String get editRsvp {
    return Intl.message(
      'Editar formulario de asistencia',
      name: 'editRsvp',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get labelName {
    return Intl.message('Nombre', name: 'labelName', desc: '', args: []);
  }

  /// `Invitados`
  String get labelGuests {
    return Intl.message('Invitados', name: 'labelGuests', desc: '', args: []);
  }

  /// `Notas adicionales`
  String get additionalNotes {
    return Intl.message(
      'Notas adicionales',
      name: 'additionalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Editar campo`
  String get editField {
    return Intl.message('Editar campo', name: 'editField', desc: '', args: []);
  }

  /// `Nombre del campo`
  String get fieldName {
    return Intl.message(
      'Nombre del campo',
      name: 'fieldName',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get save {
    return Intl.message('Guardar', name: 'save', desc: '', args: []);
  }

  /// `Obligatorio`
  String get labelRequired {
    return Intl.message(
      'Obligatorio',
      name: 'labelRequired',
      desc: '',
      args: [],
    );
  }

  /// `Opcional`
  String get labelOptional {
    return Intl.message('Opcional', name: 'labelOptional', desc: '', args: []);
  }

  /// `Añade los campos que quieras que aparezcan en el formulario`
  String get addFieldsRsvp {
    return Intl.message(
      'Añade los campos que quieras que aparezcan en el formulario',
      name: 'addFieldsRsvp',
      desc: '',
      args: [],
    );
  }

  /// `Campos añadidos al formulario`
  String get fieldsAdded {
    return Intl.message(
      'Campos añadidos al formulario',
      name: 'fieldsAdded',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get labelSave {
    return Intl.message('Guardar', name: 'labelSave', desc: '', args: []);
  }

  /// `Texto de ayuda (opcional)`
  String get placeholderText {
    return Intl.message(
      'Texto de ayuda (opcional)',
      name: 'placeholderText',
      desc: '',
      args: [],
    );
  }

  /// `Fecha del evento`
  String get eventDate {
    return Intl.message(
      'Fecha del evento',
      name: 'eventDate',
      desc: '',
      args: [],
    );
  }

  /// `Hora del evento`
  String get eventTime {
    return Intl.message(
      'Hora del evento',
      name: 'eventTime',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar tema`
  String get themeSelect {
    return Intl.message(
      'Seleccionar tema',
      name: 'themeSelect',
      desc: '',
      args: [],
    );
  }

  /// `Elegante`
  String get themeElegant {
    return Intl.message('Elegante', name: 'themeElegant', desc: '', args: []);
  }

  /// `Clásico`
  String get themeClassic {
    return Intl.message('Clásico', name: 'themeClassic', desc: '', args: []);
  }

  /// `Navideño`
  String get themeChristmas {
    return Intl.message('Navideño', name: 'themeChristmas', desc: '', args: []);
  }

  /// `Divertido/Infantil`
  String get themeFun {
    return Intl.message(
      'Divertido/Infantil',
      name: 'themeFun',
      desc: '',
      args: [],
    );
  }

  /// `Minimalista`
  String get themeMinimal {
    return Intl.message(
      'Minimalista',
      name: 'themeMinimal',
      desc: '',
      args: [],
    );
  }

  /// `Neutro`
  String get themeDefault {
    return Intl.message('Neutro', name: 'themeDefault', desc: '', args: []);
  }

  /// `Aplicar cambios`
  String get applyChanges {
    return Intl.message(
      'Aplicar cambios',
      name: 'applyChanges',
      desc: '',
      args: [],
    );
  }

  /// `Texto de prueba`
  String get sampleText {
    return Intl.message(
      'Texto de prueba',
      name: 'sampleText',
      desc: '',
      args: [],
    );
  }

  /// `Personalizar tema`
  String get customizeTheme {
    return Intl.message(
      'Personalizar tema',
      name: 'customizeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Color de fondo`
  String get colorBackground {
    return Intl.message(
      'Color de fondo',
      name: 'colorBackground',
      desc: '',
      args: [],
    );
  }

  /// `Color texto primario`
  String get colorPrimary {
    return Intl.message(
      'Color texto primario',
      name: 'colorPrimary',
      desc: '',
      args: [],
    );
  }

  /// `Fuente del tema`
  String get themeFont {
    return Intl.message(
      'Fuente del tema',
      name: 'themeFont',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar color`
  String get colorSelect {
    return Intl.message(
      'Seleccionar color',
      name: 'colorSelect',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar fuente`
  String get fontSelect {
    return Intl.message(
      'Seleccionar fuente',
      name: 'fontSelect',
      desc: '',
      args: [],
    );
  }

  /// `Color botones`
  String get buttonColorAccent {
    return Intl.message(
      'Color botones',
      name: 'buttonColorAccent',
      desc: '',
      args: [],
    );
  }

  /// `Color texto secundario`
  String get colorSecondary {
    return Intl.message(
      'Color texto secundario',
      name: 'colorSecondary',
      desc: '',
      args: [],
    );
  }

  /// `Tamaño texto principal`
  String get themeTitleSize {
    return Intl.message(
      'Tamaño texto principal',
      name: 'themeTitleSize',
      desc: '',
      args: [],
    );
  }

  /// `Tamaño texto secundario`
  String get themeBodySize {
    return Intl.message(
      'Tamaño texto secundario',
      name: 'themeBodySize',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
