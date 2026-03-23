// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(seconds) =>
      "Nom d\'utilisateur ou mot de passe incorrect.\nVeuillez attendre ${seconds} secondes avant de réessayer";

  static String m1(username) => "Profil de @${username} sur Invitaty";

  static String m2(username) => "QR de @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Paramètres du compte",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("Non"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Oui"),
    "andLabel": MessageLookupByLibrary.simpleMessage("et"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Version initiale de Invitaty.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Journal des modifications",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Retour"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Changer le mot de passe",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Fermer"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirmer"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Supprimer le compte",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Supprimer l\'avatar",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Actualiser",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Fermer"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Le code doit comporter 6 chiffres",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Si le compte existe, un code a été envoyé à votre e-mail",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Réduire"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmer"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Politique relative aux cookies",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Lien copié",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Copier le lien"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Version actuelle",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe actuel",
    ),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Version disponible",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Format de date"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Supprimer toutes les notifications",
    ),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment quitter l\'application ?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Quitter l\'application",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment vous déconnecter ?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Enregistrer les modifications ?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous vraiment supprimer votre compte ? Cette action est irréversible.\nSaisissez votre mot de passe pour confirmer.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Une nouvelle version de Invitaty est disponible.\nMettez à jour l\'application pour continuer",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Impossible de se connecter au serveur Invitaty",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "L\'application est en maintenance pour le moment. Réessayez plus tard",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Erreur"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Attention"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Nom d\'affichage (facultatif)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de supprimer le compte. Réessayez",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Cet e-mail est déjà enregistré",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Le code a expiré",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Une erreur s\'est produite. Réessayez",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Le code n\'est pas valide",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Nom d\'utilisateur ou mot de passe incorrect",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "L\'e-mail n\'est pas valide",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe doit comporter au moins 6 caractères",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Le nom d\'utilisateur doit comporter entre 4 et 20 caractères et ne peut contenir que des lettres, des chiffres, des tirets et des underscores.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Des champs obligatoires sont manquants",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Indiquez un nom d\'utilisateur ou un e-mail",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de finaliser l\'inscription. Réessayez",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de créer la session. Réessayez plus tard",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Nombre maximum de tentatives dépassé",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Trop de tentatives. Réessayez plus tard",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Ce nom d\'utilisateur est déjà pris",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe incorrect",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Impossible de traiter l\'image",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Développer"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "C\'est une application avec une base de données de films, séries et autres contenus audiovisuels, avec des outils pour interagir avec d\'autres membres, créer des listes, noter et laisser des avis, entre autres.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage(
      "Qu\'est-ce que Invitaty ?",
    ),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Non, Invitaty n\'est pas une application de streaming ; il s\'agit uniquement d\'une base de données avec diverses fonctionnalités autour du contenu.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Peut-on regarder des films et des séries ?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Vous pouvez supprimer votre compte dans les paramètres du compte dans l\'application. Cela supprime tout ce qui est lié à votre compte. Cette action est irréversible.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Comment supprimer mon compte ?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Ce champ est obligatoire",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié ?",
    ),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Paramètres généraux",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Impossible d\'ouvrir les paramètres système",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'enregistrer les paramètres. Vérifiez votre connexion et réessayez",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'enregistrer les paramètres. Reconnectez-vous",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Paramètres enregistrés avec succès",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Aller à l\'accueil"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("E-mail invalide"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Rester connecté"),
    "language": MessageLookupByLibrary.simpleMessage("Langue"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabe"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Catalan"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chinois"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Néerlandais"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Anglais"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Allemand"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonésien"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italien"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japonais"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Coréen"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polonais"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portugais"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Roumain"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Russe"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Espagnol"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Suédois"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turc"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukrainien"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Dernière connexion",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage(
      "Mentions légales",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Chargement..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Déconnexion"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Tout marquer comme lu",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Réseaux sociaux",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Accueil"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Mot de passe modifié avec succès",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Impossible de supprimer le compte",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Compte supprimé avec succès",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Une erreur s\'est produite",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Impossible de mettre à jour le profil",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profil mis à jour avec succès",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce message ?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("Message supprimé"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Modifier"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("modifié"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas encore de conversations",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Impossible de supprimer le message",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Impossible de modifier le message",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'envoyer le message",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Pas encore de messages. Écrivez quelque chose !",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Lu"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Envoyer"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Envoyé"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Écrire un message...",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "Plus aucun enregistrement",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Supprimer toutes les notifications ?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Marquer toutes les notifications comme lues ?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Impossible de marquer la notification comme lue",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Notification marquée comme lue.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Toutes les notifications ont été marquées comme lues",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Impossible de supprimer les notifications",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Notifications supprimées",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez aucune notification",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Autorisations de notification de l\'appareil",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Ouvrir les paramètres",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("OFF"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("ON"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Pour des raisons de sécurité, nous ne pouvons pas ouvrir les paramètres du navigateur. Pour autoriser ou bloquer les notifications de ce site, appuyez sur le cadenas à côté de l\'adresse → Paramètres du site → Notifications.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications dans le navigateur",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Mot de passe réinitialisé avec succès",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Au moins 6 caractères",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas",
    ),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Politique de confidentialité",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("Messages privés"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Profil utilisateur",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notifications push",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Impossible de valider le captcha. Réessayez.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage(
      "Erreur d\'inscription",
    ),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "J\'accepte de recevoir des promotions et des communications commerciales",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "J\'ai lu et j\'accepte les",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Vous devez accepter les conditions générales et la politique de confidentialité",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Retirer la date",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Retirer le pays",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Envoyer le code"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Envoyer un message",
    ),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Partager"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Partager"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Voir mon profil"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Afficher le QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Connexion"),
    "signUp": MessageLookupByLibrary.simpleMessage("Créer un compte"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Suivez-nous sur les réseaux sociaux.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'ouvrir le lien",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'ouvrir WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Statut"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Contact Invitaty"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Conditions générales",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Besoin d\'aide ? Contactez-nous par l\'un de nos canaux et nous vous répondrons dès que possible.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nom d\'affichage",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "L\'e-mail est obligatoire",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "L\'e-mail n\'est pas valide",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Date de naissance",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Pays"),
    "theme": MessageLookupByLibrary.simpleMessage("Thème"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Mode sombre"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Mode clair"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "userEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Nous n\'avons pas trouvé cet utilisateur",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Nom d\'utilisateur ou e-mail",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Contact"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQ"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage(
      "Déconnexion",
    ),
    "userYears": MessageLookupByLibrary.simpleMessage("ans"),
    "username": MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Au moins 4 caractères",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Code de vérification (6 chiffres)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://votresite.fr"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Site web / blog"),
    "weekStart": MessageLookupByLibrary.simpleMessage(
      "Premier jour de la semaine",
    ),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Lundi"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Dimanche"),
    "welcome": MessageLookupByLibrary.simpleMessage("Bienvenue !"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Identifiants incorrects",
    ),
  };
}
