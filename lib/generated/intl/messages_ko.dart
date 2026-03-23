// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(seconds) =>
      "사용자 이름 또는 비밀번호가 올바르지 않습니다.\n${seconds}초 후 다시 시도하세요";

  static String m1(username) => "Invitaty의 @${username} 프로필";

  static String m2(username) => "@${username}의 QR";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("계정 설정"),
    "actionNo": MessageLookupByLibrary.simpleMessage("아니요"),
    "actionYes": MessageLookupByLibrary.simpleMessage("예"),
    "andLabel": MessageLookupByLibrary.simpleMessage("및"),
    "appName": MessageLookupByLibrary.simpleMessage("Invitaty"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Invitaty 최초 버전.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage("변경 로그"),
    "back": MessageLookupByLibrary.simpleMessage("뒤로"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("소개"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("취소"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage("비밀번호 변경"),
    "buttonClose": MessageLookupByLibrary.simpleMessage("닫기"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("확인"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("계정 삭제"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("아바타 삭제"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage("새로고침"),
    "close": MessageLookupByLibrary.simpleMessage("닫기"),
    "code6Digits": MessageLookupByLibrary.simpleMessage("코드는 6자리여야 합니다"),
    "codeSent": MessageLookupByLibrary.simpleMessage("계정이 있으면 이메일로 코드를 보냈습니다"),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("접기"),
    "confirm": MessageLookupByLibrary.simpleMessage("확인"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("쿠키 정책"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "링크가 복사되었습니다",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("링크 복사"),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage("현재 버전"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("현재 비밀번호"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "사용 가능한 버전",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("날짜 형식"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage("모든 알림 삭제"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "앱을 종료하시겠습니까?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("앱 종료"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "로그아웃하시겠습니까?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage("변경 사항을 저장할까요?"),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "정말 계정을 삭제하시겠습니까? 되돌릴 수 없습니다.\n확인을 위해 비밀번호를 입력하세요.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage("비밀번호"),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Invitaty의 새 버전이 있습니다.\n계속하려면 앱을 업데이트하세요",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Invitaty 서버에 연결할 수 없습니다",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "앱이 점검 중입니다. 나중에 다시 시도하세요",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("오류"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("주의"),
    "displayName": MessageLookupByLibrary.simpleMessage("표시 이름(선택)"),
    "email": MessageLookupByLibrary.simpleMessage("이메일"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "계정을 삭제할 수 없습니다. 다시 시도하세요",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "이 이메일은 이미 등록되어 있습니다",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage("코드가 만료되었습니다"),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "오류가 발생했습니다. 다시 시도하세요",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "코드가 유효하지 않습니다",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "사용자 이름 또는 비밀번호가 올바르지 않습니다",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "이메일이 유효하지 않습니다",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "비밀번호는 최소 6자여야 합니다",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "사용자 이름은 4~20자이며 문자, 숫자, 하이픈, 밑줄만 사용할 수 있습니다.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "필수 항목이 누락되었습니다",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "사용자 이름 또는 이메일을 입력하세요",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "가입을 완료할 수 없습니다. 다시 시도하세요",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "세션을 만들 수 없습니다. 나중에 다시 시도하세요",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "최대 시도 횟수를 초과했습니다",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "시도 횟수가 너무 많습니다. 나중에 다시 시도하세요",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "이 사용자 이름은 이미 사용 중입니다",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "비밀번호가 올바르지 않습니다",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "이미지를 처리할 수 없습니다",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("펼치기"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "다양한 종류의 이벤트를 위한 초대장을 만드는 앱입니다. 템플릿을 선택하고 초대장을 개인화한 뒤, 소셜 미디어에 공유하고 확인 알림을 받으며 참석 현황을 추적할 수 있습니다.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Invitaty이란?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "아니요. Invitaty로 초대장을 디자인할 수는 있지만, 공개하려면 초대장마다 결제를 해야 합니다.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage("무료인가요?"),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "앱의 계정 설정에서 삭제할 수 있습니다. 관련 데이터가 모두 삭제되며 되돌릴 수 없습니다.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage("어떻게 계정을 삭제하나요?"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("필수 항목입니다"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("비밀번호를 잊으셨나요?"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("일반 설정"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage("시스템 설정을 열 수 없습니다"),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "설정을 저장할 수 없습니다. 연결을 확인하고 다시 시도하세요",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "설정을 저장할 수 없습니다. 다시 로그인하세요",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "설정이 저장되었습니다",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("홈으로"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Create invitation",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tap Create invitation to get started.",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "No invitations created yet.",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("유효하지 않은 이메일"),
    "keepSession": MessageLookupByLibrary.simpleMessage("로그인 상태 유지"),
    "language": MessageLookupByLibrary.simpleMessage("언어"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("아랍어"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("카탈루냐어"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("중국어"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("네덜란드어"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("영어"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("프랑스어"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("독일어"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("힌디어"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("인도네시아어"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("이탈리아어"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("일본어"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("한국어"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("폴란드어"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("포르투갈어"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("루마니아어"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("러시아어"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("스페인어"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("스웨덴어"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("터키어"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("우크라이나어"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage("마지막 접속"),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("법적 고지"),
    "loading": MessageLookupByLibrary.simpleMessage("로딩 중…"),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage("모두 읽음으로 표시"),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("소셜 미디어"),
    "menuHome": MessageLookupByLibrary.simpleMessage("홈"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "비밀번호가 변경되었습니다",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "계정을 삭제할 수 없습니다",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "계정이 삭제되었습니다",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage("오류가 발생했습니다"),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "프로필을 업데이트할 수 없습니다",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "프로필이 업데이트되었습니다",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("삭제"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "이 메시지를 삭제할까요?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("메시지가 삭제되었습니다"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("편집"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("편집됨"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage("아직 대화가 없습니다"),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "메시지를 삭제할 수 없습니다",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "메시지를 편집할 수 없습니다",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage("메시지를 보낼 수 없습니다"),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "아직 메시지가 없습니다. 무엇인가 써 보세요!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("읽음"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("보내기"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("보냄"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage("메시지 입력…"),
    "newPassword": MessageLookupByLibrary.simpleMessage("새 비밀번호"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("더 이상 기록이 없습니다"),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "모든 알림을 삭제할까요?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "모든 알림을 읽음으로 표시할까요?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "알림을 읽음으로 표시할 수 없습니다",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "알림을 읽음으로 표시했습니다.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "모든 알림을 읽음으로 표시했습니다",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "알림을 삭제할 수 없습니다",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "알림이 삭제되었습니다",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage("알림이 없습니다"),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("알림"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "기기 알림 권한",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "설정 열기",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("꺼짐"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("켜짐"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "보안상 브라우저 설정을 열 수 없습니다. 주소 옆 자물쇠 → 사이트 설정 → 알림에서 이 사이트 알림을 허용하거나 차단하세요.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "브라우저 알림",
    ),
    "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("비밀번호가 재설정되었습니다"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage("최소 6자"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage("비밀번호가 일치하지 않습니다"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage("개인정보 처리방침"),
    "privateMessages": MessageLookupByLibrary.simpleMessage("비공개 메시지"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage("사용자 프로필"),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage("푸시 알림"),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "캡차를 확인할 수 없습니다. 다시 시도하세요.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("가입 오류"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "프로모션 및 상업적 소식 수신에 동의합니다",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "다음을 읽고 동의합니다:",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "이용약관 및 개인정보 처리방침에 동의해야 합니다",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage("날짜 제거"),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage("국가 제거"),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("다시 시도"),
    "sendCode": MessageLookupByLibrary.simpleMessage("코드 보내기"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("메시지 보내기"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("설정"),
    "shareOption": MessageLookupByLibrary.simpleMessage("공유"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("공유"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("내 프로필 보기"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("QR 표시"),
    "signIn": MessageLookupByLibrary.simpleMessage("로그인"),
    "signUp": MessageLookupByLibrary.simpleMessage("계정 만들기"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("이메일"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "소셜 미디어에서 팔로우하세요.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage("링크를 열 수 없습니다"),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "WhatsApp을 열 수 없습니다",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("상태"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage("Invitaty 문의"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage("이용약관"),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "도움이 필요하신가요? 채널로 연락 주시면 최대한 빨리 답변드리겠습니다.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage("표시 이름"),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage("이메일은 필수입니다"),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "이메일이 유효하지 않습니다",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage("생년월일"),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("국가"),
    "theme": MessageLookupByLibrary.simpleMessage("테마"),
    "themeDark": MessageLookupByLibrary.simpleMessage("다크 모드"),
    "themeLight": MessageLookupByLibrary.simpleMessage("라이트 모드"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("아바타"),
    "userDescription": MessageLookupByLibrary.simpleMessage("소개"),
    "userEmail": MessageLookupByLibrary.simpleMessage("이메일"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "이 사용자를 찾을 수 없습니다",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage("사용자 이름 또는 이메일"),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("문의"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("자주 묻는 질문"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "userYears": MessageLookupByLibrary.simpleMessage("세"),
    "username": MessageLookupByLibrary.simpleMessage("사용자 이름"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage("최소 4자"),
    "verificationCode": MessageLookupByLibrary.simpleMessage("인증 코드(6자리)"),
    "version": MessageLookupByLibrary.simpleMessage("버전"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://example.kr"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("웹사이트 / 블로그"),
    "weekStart": MessageLookupByLibrary.simpleMessage("한 주의 첫 날"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("월요일"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("일요일"),
    "welcome": MessageLookupByLibrary.simpleMessage("환영합니다!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("잘못된 자격 증명"),
  };
}
