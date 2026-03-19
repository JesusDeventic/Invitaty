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

  /// `Filmoly`
  String get appName {
    return Intl.message('Filmoly', name: 'appName', desc: '', args: []);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
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

  /// `Keep session started`
  String get keepSession {
    return Intl.message(
      'Keep session started',
      name: 'keepSession',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
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

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
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

  /// `Code must be 6 digits`
  String get code6Digits {
    return Intl.message(
      'Code must be 6 digits',
      name: 'code6Digits',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `If the account exists, a code has been sent to the email.`
  String get codeSent {
    return Intl.message(
      'If the account exists, a code has been sent to the email.',
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

  /// `· Initial release of Filmoly.\n· Login, register and password recovery.\n· Connection with La Retroteca (WordPress).`
  String get appVersion10Description {
    return Intl.message(
      '· Initial release of Filmoly.\n· Login, register and password recovery.\n· Connection with La Retroteca (WordPress).',
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

  /// `Account and profile`
  String get accountAndProfile {
    return Intl.message(
      'Account and profile',
      name: 'accountAndProfile',
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

  /// `Exit application`
  String get dialogCloseAppTitle {
    return Intl.message(
      'Exit application',
      name: 'dialogCloseAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get buttonClose {
    return Intl.message('Close', name: 'buttonClose', desc: '', args: []);
  }

  /// `Close session?`
  String get dialogCloseSessionContent {
    return Intl.message(
      'Close session?',
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

  /// `Wrong credentials`
  String get wrongCredentials {
    return Intl.message(
      'Wrong credentials',
      name: 'wrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password. Please wait {seconds} seconds before trying again`
  String loginCountdownMessage(Object seconds) {
    return Intl.message(
      'Incorrect username or password. Please wait $seconds seconds before trying again',
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

  /// `Could not connect to the Filmoly server.`
  String get dialogErrorServerConnection {
    return Intl.message(
      'Could not connect to the Filmoly server.',
      name: 'dialogErrorServerConnection',
      desc: '',
      args: [],
    );
  }

  /// `A new version of Filmoly is available.\nPlease update the app to continue.`
  String get dialogErrorAppVersion {
    return Intl.message(
      'A new version of Filmoly is available.\nPlease update the app to continue.',
      name: 'dialogErrorAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `The application is currently in maintenance mode. Please try again later.`
  String get dialogErrorServerMaintenance {
    return Intl.message(
      'The application is currently in maintenance mode. Please try again later.',
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

  /// `Do you want to save the changes made?`
  String get dialogConfirmSave {
    return Intl.message(
      'Do you want to save the changes made?',
      name: 'dialogConfirmSave',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Email us or visit our website.`
  String get textUserSupportDescription {
    return Intl.message(
      'Need help? Email us or visit our website.',
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

  /// `Social networks`
  String get menuBarSectionSocial {
    return Intl.message(
      'Social networks',
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

  /// `Filmoly contact`
  String get subjectSupport {
    return Intl.message(
      'Filmoly contact',
      name: 'subjectSupport',
      desc: '',
      args: [],
    );
  }

  /// `What is Filmoly?`
  String get faq1Question {
    return Intl.message(
      'What is Filmoly?',
      name: 'faq1Question',
      desc: '',
      args: [],
    );
  }

  /// `It is an app with a database of films and TV series, with a set of tools that let users interact with other members, create lists, add ratings and reviews, among other features.`
  String get faq1Answer {
    return Intl.message(
      'It is an app with a database of films and TV series, with a set of tools that let users interact with other members, create lists, add ratings and reviews, among other features.',
      name: 'faq1Answer',
      desc: '',
      args: [],
    );
  }

  /// `Can I watch films and series?`
  String get faq2Question {
    return Intl.message(
      'Can I watch films and series?',
      name: 'faq2Question',
      desc: '',
      args: [],
    );
  }

  /// `No, Filmoly is not a streaming app; it only works as a database with various features around that data.`
  String get faq2Answer {
    return Intl.message(
      'No, Filmoly is not a streaming app; it only works as a database with various features around that data.',
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

  /// `You can delete your account from your account settings in the app. This removes everything related to your user. This action is irreversible.`
  String get faq3Answer {
    return Intl.message(
      'You can delete your account from your account settings in the app. This removes everything related to your user. This action is irreversible.',
      name: 'faq3Answer',
      desc: '',
      args: [],
    );
  }

  /// `Username must be 4-20 characters and can only contain letters, numbers, hyphens and underscores.`
  String get errorAuthInvalidUsername {
    return Intl.message(
      'Username must be 4-20 characters and can only contain letters, numbers, hyphens and underscores.',
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

  /// `That username already exists.`
  String get errorAuthUsernameExists {
    return Intl.message(
      'That username already exists.',
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

  /// `Could not create session. Please try again later.`
  String get errorAuthSessionFailed {
    return Intl.message(
      'Could not create session. Please try again later.',
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

  /// `You must provide username or email.`
  String get errorAuthMissingLogin {
    return Intl.message(
      'You must provide username or email.',
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

  /// `An error occurred. Please try again.`
  String get errorAuthGeneric {
    return Intl.message(
      'An error occurred. Please try again.',
      name: 'errorAuthGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete account. Please try again.`
  String get errorAuthDeleteAccountFailed {
    return Intl.message(
      'Could not delete account. Please try again.',
      name: 'errorAuthDeleteAccountFailed',
      desc: '',
      args: [],
    );
  }

  /// `Account and profile`
  String get userSectionAccount {
    return Intl.message(
      'Account and profile',
      name: 'userSectionAccount',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get userAvatar {
    return Intl.message('Avatar', name: 'userAvatar', desc: '', args: []);
  }

  /// `Description`
  String get userDescription {
    return Intl.message(
      'Description',
      name: 'userDescription',
      desc: '',
      args: [],
    );
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

  /// `years`
  String get userYears {
    return Intl.message('years', name: 'userYears', desc: '', args: []);
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

  /// `Are you sure you want to delete your account? This action is irreversible. Enter your password to confirm.`
  String get dialogDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account? This action is irreversible. Enter your password to confirm.',
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

  /// `Profile updated successfully`
  String get messageUpdateSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'messageUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get messageUpdateError {
    return Intl.message(
      'Error updating profile',
      name: 'messageUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get messageGeneralError {
    return Intl.message(
      'An error occurred',
      name: 'messageGeneralError',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get messageDeleteAccountSuccess {
    return Intl.message(
      'Account deleted successfully',
      name: 'messageDeleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting account`
  String get messageDeleteAccountError {
    return Intl.message(
      'Error deleting account',
      name: 'messageDeleteAccountError',
      desc: '',
      args: [],
    );
  }

  /// `Error processing image`
  String get errorProcessingImage {
    return Intl.message(
      'Error processing image',
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
