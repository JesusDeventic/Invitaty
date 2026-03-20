<?php
/**
 * Filmaniak - Traducciones para emails y notificaciones push.
 * Usa el idioma guardado en filmaniak_language (usermeta).
 *
 * Idiomas soportados: ar, ca, de, en, es, fr, hi, it, ja, ko, nl, pl, pt, ro, ru, sv, tr, uk, zh
 */

if (!defined('ABSPATH')) {
    exit;
}

/**
 * Devuelve las cadenas traducidas para un idioma.
 * Fallback: es -> en -> primera disponible.
 */
function filmaniak_get_translations($locale) {
    $locale = strtolower(substr((string) $locale, 0, 2));
    $all = filmaniak_translations_all();

    if (isset($all[$locale])) {
        return $all[$locale];
    }
    if (isset($all['en'])) {
        return $all['en'];
    }
    return reset($all);
}

/**
 * Devuelve una cadena traducida con sustituciones.
 * Ej: filmaniak_t('reset_email_hello', 'es', ['name' => 'Juan']) -> "Hola Juan,"
 * Si la clave no existe en el idioma, intenta en -> es.
 */
function filmaniak_t($key, $locale, $replacements = []) {
    $all = filmaniak_translations_all();
    $str = null;
    foreach ([$locale, 'en', 'es'] as $try) {
        if (isset($all[$try][$key])) {
            $str = $all[$try][$key];
            break;
        }
    }
    $str = $str ?? $key;

    foreach ($replacements as $k => $v) {
        $str = str_replace('{' . $k . '}', (string) $v, $str);
    }
    return $str;
}

/**
 * Obtiene el idioma del usuario desde usermeta. Fallback: en.
 */
function filmaniak_get_user_language($user_id) {
    $lang = get_user_meta($user_id, 'filmaniak_language', true);
    return ($lang && is_string($lang)) ? strtolower(substr($lang, 0, 2)) : 'en';
}

/**
 * Todas las traducciones por idioma.
 */
function filmaniak_translations_all() {
    return [
        'es' => [
            'reset_email_subject' => 'Filmaniak - Código para restablecer tu contraseña',
            'reset_email_body' => "Hola {name},\n\nHemos recibido una solicitud para restablecer tu contraseña en Filmaniak.\n\nTu código de verificación es: {code}\n\nEste código caduca en 15 minutos.\nSi no has solicitado este cambio, puedes ignorar este correo.\n\nEquipo de Filmaniak",
            'new_private_message_title' => "Nuevo mensaje de '{name}'",
        ],
        'en' => [
            'reset_email_subject' => 'Filmaniak - Password reset code',
            'reset_email_body' => "Hello {name},\n\nWe have received a request to reset your password on Filmaniak.\n\nYour verification code is: {code}\n\nThis code expires in 15 minutes.\nIf you did not request this change, you can ignore this email.\n\nFilmaniak Team",
            'new_private_message_title' => "New message from '{name}'",
        ],
        'ca' => [
            'reset_email_subject' => 'Filmaniak - Codi per restablir la contrasenya',
            'reset_email_body' => "Hola {name},\n\nHem rebut una sol·licitud per restablir la teva contrasenya a Filmaniak.\n\nEl teu codi de verificació és: {code}\n\nAquest codi caduca en 15 minuts.\nSi no has sol·licitat aquest canvi, pots ignorar aquest correu.\n\nEquip de Filmaniak",
            'new_private_message_title' => "Nou missatge de '{name}'",
        ],
        'de' => [
            'reset_email_subject' => 'Filmaniak - Code zum Zurücksetzen des Passworts',
            'reset_email_body' => "Hallo {name},\n\nWir haben eine Anfrage zum Zurücksetzen Ihres Passworts bei Filmaniak erhalten.\n\nIhr Bestätigungscode lautet: {code}\n\nDieser Code läuft in 15 Minuten ab.\nWenn Sie diese Änderung nicht angefordert haben, können Sie diese E-Mail ignorieren.\n\nFilmaniak Team",
            'new_private_message_title' => "Neue Nachricht von '{name}'",
        ],
        'fr' => [
            'reset_email_subject' => 'Filmaniak - Code pour réinitialiser votre mot de passe',
            'reset_email_body' => "Bonjour {name},\n\nNous avons reçu une demande de réinitialisation de votre mot de passe sur Filmaniak.\n\nVotre code de vérification est : {code}\n\nCe code expire dans 15 minutes.\nSi vous n'avez pas demandé ce changement, vous pouvez ignorer cet e-mail.\n\nÉquipe Filmaniak",
            'new_private_message_title' => "Nouveau message de '{name}'",
        ],
        'it' => [
            'reset_email_subject' => 'Filmaniak - Codice per reimpostare la password',
            'reset_email_body' => "Ciao {name},\n\nAbbiamo ricevuto una richiesta per reimpostare la tua password su Filmaniak.\n\nIl tuo codice di verifica è: {code}\n\nQuesto codice scade tra 15 minuti.\nSe non hai richiesto questa modifica, puoi ignorare questa email.\n\nTeam Filmaniak",
            'new_private_message_title' => "Nuovo messaggio da '{name}'",
        ],
        'pt' => [
            'reset_email_subject' => 'Filmaniak - Código para redefinir a senha',
            'reset_email_body' => "Olá {name},\n\nRecebemos um pedido para redefinir a sua senha no Filmaniak.\n\nO seu código de verificação é: {code}\n\nEste código expira em 15 minutos.\nSe não solicitou esta alteração, pode ignorar este email.\n\nEquipa Filmaniak",
            'new_private_message_title' => "Nova mensagem de '{name}'",
        ],
        'nl' => [
            'reset_email_subject' => 'Filmaniak - Code om uw wachtwoord te resetten',
            'reset_email_body' => "Hallo {name},\n\nWe hebben een verzoek ontvangen om uw wachtwoord op Filmaniak te resetten.\n\nUw verificatiecode is: {code}\n\nDeze code verloopt over 15 minuten.\nAls u deze wijziging niet heeft aangevraagd, kunt u deze e-mail negeren.\n\nFilmaniak Team",
            'new_private_message_title' => "Nieuw bericht van '{name}'",
        ],
        'pl' => [
            'reset_email_subject' => 'Filmaniak - Kod do resetowania hasła',
            'reset_email_body' => "Cześć {name},\n\nOtrzymaliśmy prośbę o zresetowanie hasła w Filmaniak.\n\nTwój kod weryfikacyjny to: {code}\n\nTen kod wygasa za 15 minut.\nJeśli nie prosiłeś o tę zmianę, możesz zignorować ten e-mail.\n\nZespół Filmaniak",
            'new_private_message_title' => "Nowa wiadomość od '{name}'",
        ],
        'ru' => [
            'reset_email_subject' => 'Filmaniak - Код для сброса пароля',
            'reset_email_body' => "Здравствуйте, {name}!\n\nМы получили запрос на сброс пароля в Filmaniak.\n\nВаш код подтверждения: {code}\n\nСрок действия кода истекает через 15 минут.\nЕсли вы не запрашивали это изменение, можете проигнорировать это письмо.\n\nКоманда Filmaniak",
            'new_private_message_title' => "Новое сообщение от '{name}'",
        ],
        'ar' => [
            'reset_email_subject' => 'Filmaniak - رمز إعادة تعيين كلمة المرور',
            'reset_email_body' => "مرحباً {name}،\n\nلقد تلقينا طلباً لإعادة تعيين كلمة المرور الخاصة بك على Filmaniak.\n\nرمز التحقق الخاص بك هو: {code}\n\nينتهي صلاحية هذا الرمز خلال 15 دقيقة.\nإذا لم تطلب هذا التغيير، يمكنك تجاهل هذا البريد الإلكتروني.\n\nفريق Filmaniak",
            'new_private_message_title' => "رسالة جديدة من '{name}'",
        ],
        'zh' => [
            'reset_email_subject' => 'Filmaniak - 重置密码验证码',
            'reset_email_body' => "你好 {name}，\n\n我们收到了您在 Filmaniak 上重置密码的请求。\n\n您的验证码是：{code}\n\n此验证码有效期为 15 分钟。\n如果您没有请求此更改，可以忽略此邮件。\n\nFilmaniak 团队",
            'new_private_message_title' => "来自 '{name}' 的新消息",
        ],
        'ja' => [
            'reset_email_subject' => 'Filmaniak - パスワードリセット用コード',
            'reset_email_body' => "{name} 様、\n\nFilmaniakでパスワードのリセットリクエストを受け付けました。\n\n認証コードは次のとおりです：{code}\n\nこのコードは15分で期限切れになります。\nこの変更をリクエストしていない場合は、このメールを無視してください。\n\nFilmaniakチーム",
            'new_private_message_title' => "{name} からの新しいメッセージ",
        ],
        'ko' => [
            'reset_email_subject' => 'Filmaniak - 비밀번호 재설정 코드',
            'reset_email_body' => "{name}님, 안녕하세요.\n\nFilmaniak에서 비밀번호 재설정 요청을 받았습니다.\n\n인증 코드: {code}\n\n이 코드는 15분 후에 만료됩니다.\n이 변경을 요청하지 않으셨다면 이 이메일을 무시하셔도 됩니다.\n\nFilmaniak 팀",
            'new_private_message_title' => "{name} 님의 새 메시지",
        ],
        'hi' => [
            'reset_email_subject' => 'Filmaniak - पासवर्ड रीसेट कोड',
            'reset_email_body' => "नमस्ते {name},\n\nहमें Filmaniak पर आपके पासवर्ड को रीसेट करने का अनुरोध प्राप्त हुआ है।\n\nआपका सत्यापन कोड है: {code}\n\nयह कोड 15 मिनट में समाप्त हो जाएगा।\nयदि आपने यह परिवर्तन नहीं मांगा है, तो आप इस ईमेल को अनदेखा कर सकते हैं।\n\nFilmaniak टीम",
            'new_private_message_title' => "{name} से नया संदेश",
        ],
        'ro' => [
            'reset_email_subject' => 'Filmaniak - Cod pentru resetarea parolei',
            'reset_email_body' => "Bună {name},\n\nAm primit o solicitare de resetare a parolei pe Filmaniak.\n\nCodul dvs. de verificare este: {code}\n\nAcest cod expiră în 15 minute.\nDacă nu ați solicitat această modificare, puteți ignora acest e-mail.\n\nEchipa Filmaniak",
            'new_private_message_title' => "Mesaj nou de la '{name}'",
        ],
        'sv' => [
            'reset_email_subject' => 'Filmaniak - Kod för återställning av lösenord',
            'reset_email_body' => "Hej {name},\n\nVi har fått en begäran om att återställa ditt lösenord på Filmaniak.\n\nDin verifieringskod är: {code}\n\nDenna kod upphör om 15 minuter.\nOm du inte begärde denna ändring kan du ignorera detta e-postmeddelande.\n\nFilmaniak-teamet",
            'new_private_message_title' => "Nytt meddelande från '{name}'",
        ],
        'tr' => [
            'reset_email_subject' => 'Filmaniak - Şifre sıfırlama kodu',
            'reset_email_body' => "Merhaba {name},\n\nFilmaniak'da şifrenizi sıfırlama talebi aldık.\n\nDoğrulama kodunuz: {code}\n\nBu kod 15 dakika içinde sona erer.\nBu değişikliği talep etmediyseniz bu e-postayı yok sayabilirsiniz.\n\nFilmaniak Ekibi",
            'new_private_message_title' => "'{name}' tarafından yeni mesaj",
        ],
        'uk' => [
            'reset_email_subject' => 'Filmaniak - Код для скидання пароля',
            'reset_email_body' => "Вітаємо, {name}!\n\nМи отримали запит на скидання пароля в Filmaniak.\n\nВаш код підтвердження: {code}\n\nТермін дії коду закінчується через 15 хвилин.\nЯкщо ви не запитували цю зміну, можете проігнорувати цей лист.\n\nКоманда Filmaniak",
            'new_private_message_title' => "Нове повідомлення від '{name}'",
        ],
    ];
}
