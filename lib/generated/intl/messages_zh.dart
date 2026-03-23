// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(seconds) => "用户名或密码错误。\n请等待 ${seconds} 秒后再试";

  static String m1(username) => "Invitaty 上 @${username} 的资料";

  static String m2(username) => "@${username} 的二维码";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("账户设置"),
    "actionNo": MessageLookupByLibrary.simpleMessage("否"),
    "actionYes": MessageLookupByLibrary.simpleMessage("是"),
    "andLabel": MessageLookupByLibrary.simpleMessage("和"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Invitaty 初始版本。",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage("更新日志"),
    "back": MessageLookupByLibrary.simpleMessage("返回"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("简介"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("取消"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage("更改密码"),
    "buttonClose": MessageLookupByLibrary.simpleMessage("关闭"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("确认"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("删除账户"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("删除头像"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage("刷新"),
    "close": MessageLookupByLibrary.simpleMessage("关闭"),
    "code6Digits": MessageLookupByLibrary.simpleMessage("验证码必须为 6 位数字"),
    "codeSent": MessageLookupByLibrary.simpleMessage("若账户存在，验证码已发送至您的邮箱"),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("收起"),
    "confirm": MessageLookupByLibrary.simpleMessage("确认"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("确认密码"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("Cookie 政策"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage("链接已复制"),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("复制链接"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage("当前版本"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("当前密码"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage("可用版本"),
    "dateFormat": MessageLookupByLibrary.simpleMessage("日期格式"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage("删除所有通知"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage("确定要退出应用吗？"),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("退出应用"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "确定要退出登录吗？",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage("要保存更改吗？"),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "确定要删除账户吗？此操作无法撤销。\n请输入密码以确认。",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage("密码"),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Invitaty 有新版本可用。\n请更新应用以继续",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "无法连接到 Invitaty 服务器",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "应用正在维护中，请稍后再试",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("错误"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("注意"),
    "displayName": MessageLookupByLibrary.simpleMessage("显示名称（可选）"),
    "email": MessageLookupByLibrary.simpleMessage("电子邮箱"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "无法删除账户，请重试",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage("该邮箱已注册"),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage("验证码已过期"),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage("发生错误，请重试"),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage("验证码无效"),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "用户名或密码错误",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage("电子邮箱无效"),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "密码至少需 6 个字符",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "用户名长度须为 4–20 个字符，且只能包含字母、数字、连字符和下划线。",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage("缺少必填字段"),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "请输入用户名或电子邮箱",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "无法完成注册，请重试",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "无法创建会话，请稍后再试",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "已超过最大尝试次数",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "尝试次数过多，请稍后再试",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage("该用户名已被占用"),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage("密码错误"),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage("无法处理图片"),
    "expandMenu": MessageLookupByLibrary.simpleMessage("展开"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "这是一款包含电影、剧集及其他视听内容数据库的应用，提供与其他会员互动、列表、评分与评论等功能。",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Invitaty 是什么？"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "不可以，Invitaty 不是流媒体应用；它仅作为围绕内容的数据库并提供多种功能。",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage("可以观看电影和剧集吗？"),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "您可在应用内的账户设置中删除账户，这将删除与账户相关的所有数据。此操作无法撤销。",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage("如何删除我的账户？"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("此字段为必填项"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("忘记密码？"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("常规设置"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage("无法打开系统设置"),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "无法保存设置。请检查网络后重试",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "无法保存设置。请重新登录",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage("设置已保存"),
    "goToHome": MessageLookupByLibrary.simpleMessage("前往首页"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("电子邮箱无效"),
    "keepSession": MessageLookupByLibrary.simpleMessage("保持登录"),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("阿拉伯语"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("加泰罗尼亚语"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("中文"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("荷兰语"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("英语"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("法语"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("德语"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("印地语"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("印尼语"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("意大利语"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("日语"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("韩语"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("波兰语"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("葡萄牙语"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("罗马尼亚语"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("俄语"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("西班牙语"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("瑞典语"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("土耳其语"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("乌克兰语"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage("上次在线"),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("法律声明"),
    "loading": MessageLookupByLibrary.simpleMessage("加载中…"),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("退出登录"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage("全部标为已读"),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("社交媒体"),
    "menuHome": MessageLookupByLibrary.simpleMessage("首页"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "密码已更改",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage("无法删除账户"),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "账户已删除",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage("发生错误"),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage("无法更新资料"),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage("资料已更新"),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("删除"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage("要删除此消息吗？"),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("消息已删除"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("编辑"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("已编辑"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage("您还没有会话"),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage("无法删除消息"),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage("无法编辑消息"),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage("无法发送消息"),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage("暂无消息，写点什么吧！"),
    "messagesRead": MessageLookupByLibrary.simpleMessage("已读"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("发送"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("已发送"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage("输入消息…"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新密码"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("没有更多记录"),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "要删除所有通知吗？",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "要将所有通知标为已读吗？",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "无法将通知标为已读",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage("通知已标为已读。"),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "所有通知已标为已读",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage("无法删除通知"),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage("通知已删除"),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage("暂无通知"),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("通知"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "设备通知权限",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "打开设置",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("关"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("开"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "出于安全原因，我们无法打开浏览器设置。若要允许或阻止本网站通知，请点击地址栏旁的锁图标 → 网站设置 → 通知。",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "浏览器中的通知",
    ),
    "password": MessageLookupByLibrary.simpleMessage("密码"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("密码已成功重置"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage("至少 6 个字符"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage("两次输入的密码不一致"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "privateMessages": MessageLookupByLibrary.simpleMessage("私信"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage("用户资料"),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage("推送通知"),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage("无法验证验证码，请重试。"),
    "registerError": MessageLookupByLibrary.simpleMessage("注册错误"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "我同意接收促销与商业信息",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "我已阅读并接受",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "您必须接受服务条款与隐私政策",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage("移除日期"),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage("移除国家/地区"),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("重试"),
    "sendCode": MessageLookupByLibrary.simpleMessage("发送验证码"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("发送消息"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("设置"),
    "shareOption": MessageLookupByLibrary.simpleMessage("分享"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("分享"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("查看我的资料"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("显示二维码"),
    "signIn": MessageLookupByLibrary.simpleMessage("登录"),
    "signUp": MessageLookupByLibrary.simpleMessage("创建账户"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("电子邮箱"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage("在社交媒体上关注我们。"),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage("无法打开链接"),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "无法打开 WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("状态"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Invitaty 联系"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage("服务条款"),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "需要帮助？请通过任一渠道联系我们，我们会尽快回复。",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage("显示名称"),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage("电子邮箱为必填项"),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage("电子邮箱无效"),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage("出生日期"),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("国家/地区"),
    "theme": MessageLookupByLibrary.simpleMessage("主题"),
    "themeDark": MessageLookupByLibrary.simpleMessage("深色模式"),
    "themeLight": MessageLookupByLibrary.simpleMessage("浅色模式"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("头像"),
    "userDescription": MessageLookupByLibrary.simpleMessage("简介"),
    "userEmail": MessageLookupByLibrary.simpleMessage("电子邮箱"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "未找到该用户",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("用户名或电子邮箱"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("联系我们"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("常见问题"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("退出登录"),
    "userYears": MessageLookupByLibrary.simpleMessage("岁"),
    "username": MessageLookupByLibrary.simpleMessage("用户名"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage("至少 4 个字符"),
    "verificationCode": MessageLookupByLibrary.simpleMessage("验证码（6 位数字）"),
    "version": MessageLookupByLibrary.simpleMessage("版本"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://你的网站.com"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("网站 / 博客"),
    "weekStart": MessageLookupByLibrary.simpleMessage("每周起始日"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("星期一"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("星期日"),
    "welcome": MessageLookupByLibrary.simpleMessage("欢迎！"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("凭据错误"),
  };
}
