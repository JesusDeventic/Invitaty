// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(seconds) =>
      "ユーザー名またはパスワードが正しくありません。\n${seconds} 秒待ってから再試行してください";

  static String m1(username) => "Invitaty の @${username} のプロフィール";

  static String m2(username) => "@${username} の QR";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("アカウント設定"),
    "actionNo": MessageLookupByLibrary.simpleMessage("いいえ"),
    "actionYes": MessageLookupByLibrary.simpleMessage("はい"),
    "andLabel": MessageLookupByLibrary.simpleMessage("および"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "・Invitaty の初版。",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage("変更履歴"),
    "back": MessageLookupByLibrary.simpleMessage("戻る"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("自己紹介"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage("パスワードを変更"),
    "buttonClose": MessageLookupByLibrary.simpleMessage("閉じる"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("確認"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("アカウントを削除"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("アバターを削除"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage("更新"),
    "close": MessageLookupByLibrary.simpleMessage("閉じる"),
    "code6Digits": MessageLookupByLibrary.simpleMessage("コードは6桁である必要があります"),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "アカウントが存在する場合、メールにコードを送信しました",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("折りたたむ"),
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("パスワード確認"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("Cookie ポリシー"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "リンクをコピーしました",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage("現在のバージョン"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("現在のパスワード"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "利用可能なバージョン",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("日付形式"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage("すべての通知を削除"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "アプリを終了しますか？",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("アプリを終了"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "ログアウトしますか？",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage("変更を保存しますか？"),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "本当にアカウントを削除しますか？取り消せません。\n確認のためパスワードを入力してください。",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "パスワード",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Invitaty の新しいバージョンがあります。\n続行するにはアプリを更新してください",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Invitaty サーバーに接続できません",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "アプリはメンテナンス中です。後でもう一度お試しください",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("エラー"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("注意"),
    "displayName": MessageLookupByLibrary.simpleMessage("表示名（任意）"),
    "email": MessageLookupByLibrary.simpleMessage("メール"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "アカウントを削除できませんでした。再試行してください",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "このメールは既に登録されています",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "コードの有効期限が切れています",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "エラーが発生しました。再試行してください",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage("コードが無効です"),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "ユーザー名またはパスワードが正しくありません",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage("メールが無効です"),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "パスワードは6文字以上である必要があります",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "ユーザー名は4〜20文字で、英数字・ハイフン・アンダースコアのみ使用できます。",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "必須項目が不足しています",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "ユーザー名またはメールを入力してください",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "登録を完了できませんでした。再試行してください",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "セッションを作成できませんでした。後でもう一度お試しください",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "最大試行回数を超えました",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "試行回数が多すぎます。後でもう一度お試しください",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "このユーザー名は既に使用されています",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "パスワードが正しくありません",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "画像を処理できませんでした",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("展開"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "これは、あらゆる種類のイベントの招待状を作成するためのアプリです。テンプレートを選んで招待状をカスタマイズし、SNSで共有し、確認通知を受け取り、参加状況を追跡できます。",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Invitaty とは？"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "いいえ。Invitatyを使って招待状をデザインできますが、公開するには1件ごとにお支払いが必要です。",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage("無料ですか？"),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "アプリ内のアカウント設定から削除できます。関連データはすべて削除されます。取り消せません。",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage("どうやってアカウントを削除しますか？"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("この項目は必須です"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("パスワードをお忘れですか？"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("一般設定"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage("システム設定を開けませんでした"),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "設定を保存できませんでした。接続を確認して再試行してください",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "設定を保存できません。再度ログインしてください",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "設定を保存しました",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("ホームへ"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Create invitation",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tap Create invitation to get started.",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "No invitations created yet.",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("メールが無効です"),
    "keepSession": MessageLookupByLibrary.simpleMessage("ログイン状態を保持"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("アラビア語"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("カタルーニャ語"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("中国語"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("オランダ語"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("英語"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("フランス語"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("ドイツ語"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("ヒンディー語"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("インドネシア語"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("イタリア語"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("日本語"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("韓国語"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("ポーランド語"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("ポルトガル語"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("ルーマニア語"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("ロシア語"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("スペイン語"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("スウェーデン語"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("トルコ語"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("ウクライナ語"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage("最終オンライン"),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("法的表示"),
    "loading": MessageLookupByLibrary.simpleMessage("読み込み中…"),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage("すべて既読にする"),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("ソーシャル"),
    "menuHome": MessageLookupByLibrary.simpleMessage("ホーム"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "パスワードを変更しました",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "アカウントを削除できませんでした",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "アカウントを削除しました",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage("エラーが発生しました"),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "プロフィールを更新できませんでした",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "プロフィールを更新しました",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("削除"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "このメッセージを削除しますか？",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("メッセージを削除しました"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("編集"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("編集済み"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage("まだ会話がありません"),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "メッセージを削除できませんでした",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "メッセージを編集できませんでした",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "メッセージを送信できませんでした",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "まだメッセージがありません。何か書いてみましょう！",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("既読"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("送信"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("送信済み"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage("メッセージを入力…"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新しいパスワード"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("これ以上のレコードはありません"),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "すべての通知を削除しますか？",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "すべての通知を既読にしますか？",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "通知を既読にできませんでした",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "通知を既読にしました。",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "すべての通知を既読にしました",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "通知を削除できませんでした",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage("通知を削除しました"),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage("通知はありません"),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("通知"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "デバイスの通知権限",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "設定を開く",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("オフ"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("オン"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "セキュリティ上、ブラウザの設定を開けません。アドレス横の鍵アイコン → サイトの設定 → 通知で、このサイトの通知を許可またはブロックできます。",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "ブラウザの通知",
    ),
    "password": MessageLookupByLibrary.simpleMessage("パスワード"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("パスワードをリセットしました"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage("6文字以上"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage("パスワードが一致しません"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage("プライバシーポリシー"),
    "privateMessages": MessageLookupByLibrary.simpleMessage("プライベートメッセージ"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "ユーザープロフィール",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage("プッシュ通知"),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Captchaを確認できませんでした。もう一度お試しください。",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("登録エラー"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "プロモーション・商用メールの受信に同意します",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "以下を読み、同意します：",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "利用規約とプライバシーポリシーに同意する必要があります",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage("日付を削除"),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage("国を削除"),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("再試行"),
    "sendCode": MessageLookupByLibrary.simpleMessage("コードを送信"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("メッセージを送る"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("設定"),
    "shareOption": MessageLookupByLibrary.simpleMessage("共有"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("共有"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("マイプロフィールを表示"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("QR を表示"),
    "signIn": MessageLookupByLibrary.simpleMessage("ログイン"),
    "signUp": MessageLookupByLibrary.simpleMessage("アカウント作成"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("メール"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "ソーシャルメディアでフォローしてください。",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage("リンクを開けませんでした"),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "WhatsApp を開けませんでした",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("ステータス"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Invitaty お問い合わせ"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage("利用規約"),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "お困りですか？各チャネルからお問い合わせください。できるだけ早く返信します。",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage("表示名"),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage("メールは必須です"),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage("メールが無効です"),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage("生年月日"),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("国"),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "themeDark": MessageLookupByLibrary.simpleMessage("ダークモード"),
    "themeLight": MessageLookupByLibrary.simpleMessage("ライトモード"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("アバター"),
    "userDescription": MessageLookupByLibrary.simpleMessage("自己紹介"),
    "userEmail": MessageLookupByLibrary.simpleMessage("メール"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "このユーザーが見つかりません",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("ユーザー名またはメール"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("よくある質問"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "userYears": MessageLookupByLibrary.simpleMessage("歳"),
    "username": MessageLookupByLibrary.simpleMessage("ユーザー名"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage("4文字以上"),
    "verificationCode": MessageLookupByLibrary.simpleMessage("確認コード（6桁）"),
    "version": MessageLookupByLibrary.simpleMessage("バージョン"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://example.jp"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("ウェブサイト / ブログ"),
    "weekStart": MessageLookupByLibrary.simpleMessage("週の始まり"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("月曜日"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("日曜日"),
    "welcome": MessageLookupByLibrary.simpleMessage("ようこそ！"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("認証情報が正しくありません"),
  };
}
