<?php
/**
 * Invitaty Auth API
 * Registro, login, logout, me, forgot password y reset password
 * usando token Bearer propio + cÃ³digo de recuperaciÃ³n por email.
 */

if (!defined('ABSPATH')) {
    exit;
}

/**
 * =========================================================
 * AVATAR HELPERS (fallback a Gravatar si no hay avatar propio)
 * =========================================================
 */
if (!function_exists('invitaty_avatar_path')) {
    function invitaty_avatar_path($user_id) {
        $upload_dir = wp_upload_dir();
        return $upload_dir['basedir'] . '/app_avatars/' . (int) $user_id . '.webp';
    }
}

if (!function_exists('invitaty_avatar_url')) {
    function invitaty_avatar_url($user_id) {
        $upload_dir = wp_upload_dir();
        return $upload_dir['baseurl'] . '/app_avatars/' . (int) $user_id . '.webp';
    }
}

if (!function_exists('invitaty_get_user_avatar_url')) {
    function invitaty_get_user_avatar_url($user_id) {
        $path = invitaty_avatar_path($user_id);
        if (file_exists($path)) {
            return add_query_arg('v', (string) filemtime($path), invitaty_avatar_url($user_id));
        }
        return get_avatar_url($user_id);
    }
}

// require_once __DIR__ . '/invitaty_translations.php'; // No hace falta porque estan en otro snippet

/**
 * =========================================================
 * CONFIG
 * =========================================================
 */
define('INVITATY_AUTH_NAMESPACE', 'invitaty/v1');
define('INVITATY_AUTH_TOKEN_TTL', 365 * DAY_IN_SECONDS); // 1 aÃ±o
define('INVITATY_RESET_CODE_TTL', 15 * MINUTE_IN_SECONDS); // 15 min
define('INVITATY_RESET_CODE_MAX_ATTEMPTS', 5);

/**
 * =========================================================
 * TABLAS
 * =========================================================
 */
function invitaty_auth_create_tables() {
    global $wpdb;

    $charset_collate = $wpdb->get_charset_collate();

    $sessions_table = $wpdb->prefix . 'invitaty_sessions';
    $resets_table   = $wpdb->prefix . 'invitaty_password_resets';

    require_once ABSPATH . 'wp-admin/includes/upgrade.php';

    $sql_sessions = "CREATE TABLE {$sessions_table} (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id BIGINT UNSIGNED NOT NULL,
        token_hash CHAR(64) NOT NULL,
        created_at DATETIME NOT NULL,
        expires_at DATETIME NOT NULL,
        last_used_at DATETIME NULL,
        revoked_at DATETIME NULL,
        user_agent VARCHAR(255) NULL,
        ip_address VARCHAR(100) NULL,
        PRIMARY KEY (id),
        UNIQUE KEY token_hash (token_hash),
        KEY user_id (user_id),
        KEY expires_at (expires_at),
        KEY revoked_at (revoked_at)
    ) {$charset_collate};";

    $sql_resets = "CREATE TABLE {$resets_table} (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id BIGINT UNSIGNED NOT NULL,
        code_hash CHAR(64) NOT NULL,
        created_at DATETIME NOT NULL,
        expires_at DATETIME NOT NULL,
        used_at DATETIME NULL,
        attempts INT UNSIGNED NOT NULL DEFAULT 0,
        ip_address VARCHAR(100) NULL,
        PRIMARY KEY (id),
        KEY user_id (user_id),
        KEY expires_at (expires_at),
        KEY used_at (used_at)
    ) {$charset_collate};";

    dbDelta($sql_sessions);
    dbDelta($sql_resets);
}
add_action('init', 'invitaty_auth_create_tables');

/**
 * =========================================================
 * HELPERS
 * =========================================================
 */
function invitaty_auth_error($code, $message, $status = 400) {
    return new WP_Error($code, $message, ['status' => $status]);
}

function invitaty_auth_get_json_params(WP_REST_Request $request) {
    $params = $request->get_json_params();
    return is_array($params) ? $params : [];
}

/**
 * Limpieza previa al borrado de usuario.
 * Se usa para acciones que pueden requerir datos aÃºn existentes.
 */
function invitaty_cleanup_user_before_delete($user_id) {
    $user_id = (int) $user_id;
    if ($user_id <= 0) {
        return;
    }

    if (function_exists('invitaty_delete_old_avatar_if_exists')) {
        invitaty_delete_old_avatar_if_exists($user_id);
    }
}
add_action('delete_user', 'invitaty_cleanup_user_before_delete');

/**
 * Limpieza posterior al borrado de usuario.
 * Aplica tanto a borrado desde endpoint como desde wp-admin.
 */
function invitaty_cleanup_deleted_user_data($user_id) {
    global $wpdb;

    $user_id = (int) $user_id;
    if ($user_id <= 0) {
        return;
    }

    $sessions_table = $wpdb->prefix . 'invitaty_sessions';
    $wpdb->delete(
        $sessions_table,
        ['user_id' => $user_id],
        ['%d']
    );

    $resets_table = $wpdb->prefix . 'invitaty_password_resets';
    $wpdb->delete(
        $resets_table,
        ['user_id' => $user_id],
        ['%d']
    );

    $private_messages_table = $wpdb->prefix . 'invitaty_private_messages';
    $wpdb->query($wpdb->prepare(
        "DELETE FROM {$private_messages_table} WHERE sender_id = %d OR recipient_id = %d",
        $user_id,
        $user_id
    ));

    $notifications_table = $wpdb->prefix . 'invitaty_notifications';
    $wpdb->delete(
        $notifications_table,
        ['user_id' => $user_id],
        ['%d']
    );

    $comments = get_comments([
        'user_id' => $user_id,
        'status' => 'all',
        'number' => 0,
        'fields' => 'ids',
    ]);

    if (!empty($comments)) {
        foreach ($comments as $comment_id) {
            wp_delete_comment($comment_id, true);
        }
    }
}
add_action('deleted_user', 'invitaty_cleanup_deleted_user_data');

function invitaty_auth_get_bearer_token(WP_REST_Request $request) {
    $auth_header = $request->get_header('authorization');

    if (!$auth_header) {
        return false;
    }

    if (preg_match('/Bearer\s+(.*)$/i', $auth_header, $matches)) {
        $token = trim($matches[1]);
        return $token !== '' ? $token : false;
    }

    return false;
}

function invitaty_auth_generate_token() {
    return bin2hex(random_bytes(32)); // 64 chars hex
}

function invitaty_auth_hash_token($token) {
    return hash('sha256', $token);
}

function invitaty_auth_generate_reset_code() {
    return (string) random_int(100000, 999999); // 6 dÃ­gitos
}

function invitaty_auth_hash_reset_code($code) {
    return hash('sha256', $code);
}

function invitaty_auth_get_request_ip() {
    return isset($_SERVER['REMOTE_ADDR'])
        ? sanitize_text_field(wp_unslash($_SERVER['REMOTE_ADDR']))
        : 'unknown';
}

function invitaty_auth_get_request_user_agent() {
    return isset($_SERVER['HTTP_USER_AGENT'])
        ? substr(sanitize_text_field(wp_unslash($_SERVER['HTTP_USER_AGENT'])), 0, 255)
        : null;
}

function invitaty_auth_find_user_by_login_or_email($login) {
    if ($login === '') {
        return false;
    }

    if (is_email($login)) {
        return get_user_by('email', $login);
    }

    return get_user_by('login', $login);
}

function invitaty_auth_create_session($user_id) {
    global $wpdb;

    $table_name = $wpdb->prefix . 'invitaty_sessions';
    $token = invitaty_auth_generate_token();
    $token_hash = invitaty_auth_hash_token($token);

    $now = current_time('mysql');
    $expires_at = date('Y-m-d H:i:s', current_time('timestamp') + INVITATY_AUTH_TOKEN_TTL);

    $inserted = $wpdb->insert(
        $table_name,
        [
            'user_id'      => $user_id,
            'token_hash'   => $token_hash,
            'created_at'   => $now,
            'expires_at'   => $expires_at,
            'last_used_at' => $now,
            'revoked_at'   => null,
            'user_agent'   => invitaty_auth_get_request_user_agent(),
            'ip_address'   => invitaty_auth_get_request_ip(),
        ],
        [
            '%d',
            '%s',
            '%s',
            '%s',
            '%s',
            '%s',
            '%s',
        ]
    );

    if (!$inserted) {
        return false;
    }

    return [
        'token' => $token,
        'expires_at' => $expires_at,
    ];
}

function invitaty_auth_validate_token(WP_REST_Request $request) {
    global $wpdb;

    $token = invitaty_auth_get_bearer_token($request);

    if (!$token) {
        return invitaty_auth_error('missing_token', 'Token no proporcionado.', 401);
    }

    $token_hash = invitaty_auth_hash_token($token);
    $table_name = $wpdb->prefix . 'invitaty_sessions';

    $session = $wpdb->get_row(
        $wpdb->prepare(
            "SELECT * FROM {$table_name}
             WHERE token_hash = %s
               AND revoked_at IS NULL
             LIMIT 1",
            $token_hash
        )
    );

    if (!$session) {
        return invitaty_auth_error('invalid_token', 'SesiÃ³n no vÃ¡lida.', 401);
    }

    if (strtotime($session->expires_at) < current_time('timestamp')) {
        return invitaty_auth_error('expired_token', 'La sesiÃ³n ha expirado.', 401);
    }

    $user = get_user_by('id', (int) $session->user_id);
    if (!$user) {
        return invitaty_auth_error('invalid_user', 'Usuario no vÃ¡lido.', 401);
    }

    $wpdb->update(
        $table_name,
        ['last_used_at' => current_time('mysql')],
        ['id' => (int) $session->id],
        ['%s'],
        ['%d']
    );

    return (int) $user->ID;
}

function invitaty_auth_get_user_data($user_id) {
    $user = get_userdata($user_id);

    if (!$user) {
        return null;
    }

    return [
        'id' => (int) $user->ID,
        'username' => $user->user_login,
        'email' => $user->user_email,
        'display_name' => $user->display_name,
        'avatar_url' => function_exists('invitaty_get_user_avatar_url') ? invitaty_get_user_avatar_url($user->ID) : get_avatar_url($user->ID),
    ];
}

/**
 * Devuelve los datos del usuario para login/me/register.
 * Si estÃ¡ cargado usuario.php y existe invitaty_get_full_user_data(), devuelve el usuario completo
 * (language, start_day_week, date_format, country, birthdate, etc.); si no, solo los bÃ¡sicos.
 */
function invitaty_auth_get_user_data_for_response($user_id) {
    if (function_exists('invitaty_get_full_user_data')) {
        $full = invitaty_get_full_user_data($user_id);
        return $full !== null ? $full : invitaty_auth_get_user_data($user_id);
    }
    return invitaty_auth_get_user_data($user_id);
}

function invitaty_auth_revoke_current_token(WP_REST_Request $request) {
    global $wpdb;

    $token = invitaty_auth_get_bearer_token($request);
    if (!$token) {
        return false;
    }

    $token_hash = invitaty_auth_hash_token($token);
    $table_name = $wpdb->prefix . 'invitaty_sessions';

    $wpdb->update(
        $table_name,
        ['revoked_at' => current_time('mysql')],
        ['token_hash' => $token_hash],
        ['%s'],
        ['%s']
    );

    return true;
}

function invitaty_auth_delete_existing_reset_codes($user_id) {
    global $wpdb;

    $table_name = $wpdb->prefix . 'invitaty_password_resets';

    $wpdb->query(
        $wpdb->prepare(
            "DELETE FROM {$table_name} WHERE user_id = %d",
            $user_id
        )
    );
}

function invitaty_auth_create_reset_code($user_id) {
    global $wpdb;

    $table_name = $wpdb->prefix . 'invitaty_password_resets';
    $code = invitaty_auth_generate_reset_code();
    $code_hash = invitaty_auth_hash_reset_code($code);

    $now = current_time('mysql');
    $expires_at = date('Y-m-d H:i:s', current_time('timestamp') + INVITATY_RESET_CODE_TTL);

    invitaty_auth_delete_existing_reset_codes($user_id);

    $inserted = $wpdb->insert(
        $table_name,
        [
            'user_id'    => $user_id,
            'code_hash'  => $code_hash,
            'created_at' => $now,
            'expires_at' => $expires_at,
            'used_at'    => null,
            'attempts'   => 0,
            'ip_address' => invitaty_auth_get_request_ip(),
        ],
        [
            '%d',
            '%s',
            '%s',
            '%s',
            '%s',
            '%d',
            '%s',
        ]
    );

    if (!$inserted) {
        return false;
    }

    return [
        'code' => $code,
        'expires_at' => $expires_at,
    ];
}

function invitaty_auth_send_reset_email($user, $code) {
    $to = $user->user_email;
    $locale = function_exists('invitaty_get_user_language') ? invitaty_get_user_language($user->ID) : 'en';
    $name = $user->display_name ? $user->display_name : $user->user_login;

    $subject = invitaty_t('reset_email_subject', $locale);
    $message = invitaty_t('reset_email_body', $locale, ['name' => $name, 'code' => $code]);

    $headers = ['Content-Type: text/plain; charset=UTF-8'];

    return wp_mail($to, $subject, $message, $headers);
}

/**
 * =========================================================
 * RATE LIMIT BÃSICO
 * =========================================================
 */
function invitaty_auth_rate_limit($key, $max_attempts = 10, $window_seconds = 900) {
    $transient_key = 'invitaty_rl_' . md5($key);
    $data = get_transient($transient_key);

    if (!is_array($data)) {
        $data = [
            'count' => 0,
            'start' => time(),
        ];
    }

    if ((time() - $data['start']) > $window_seconds) {
        $data = [
            'count' => 0,
            'start' => time(),
        ];
    }

    $data['count']++;

    set_transient($transient_key, $data, $window_seconds);

    return $data['count'] <= $max_attempts;
}

/**
 * =========================================================
 * ENDPOINTS
 * =========================================================
 */
add_action('rest_api_init', function () {
    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/register', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_register',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/login', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_login',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/me', [
        'methods' => 'GET',
        'callback' => 'invitaty_auth_me',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/logout', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_logout',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/forgot-password', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_forgot_password',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/reset-password', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_reset_password',
        'permission_callback' => '__return_true',
    ]);
    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/delete-account', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_delete_account',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route(INVITATY_AUTH_NAMESPACE, '/auth/change-password', [
        'methods' => 'POST',
        'callback' => 'invitaty_auth_change_password',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * =========================================================
 * CALLBACKS
 * =========================================================
 */
function invitaty_auth_register(WP_REST_Request $request) {
    $params = invitaty_auth_get_json_params($request);

    $username = isset($params['username']) ? sanitize_user($params['username']) : '';
    $email = isset($params['email']) ? sanitize_email($params['email']) : '';
    $password = isset($params['password']) ? (string) $params['password'] : '';
    $display_name = isset($params['display_name']) ? sanitize_text_field($params['display_name']) : '';
    $marketing_consent = isset($params['marketing_consent']) ? filter_var($params['marketing_consent'], FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) : false;
    $language = isset($params['language']) ? sanitize_text_field($params['language']) : '';

    // Username: 4-20 caracteres, solo [a-zA-Z0-9_-]
    if ($username === '' || strlen($username) < 4) {
        return invitaty_auth_error('invalid_username', 'El nombre de usuario debe tener al menos 4 caracteres.', 400);
    }
    if (strlen($username) > 20) {
        return invitaty_auth_error('invalid_username', 'El nombre de usuario no puede superar 20 caracteres.', 400);
    }
    if (!preg_match('/^[a-zA-Z0-9_-]+$/', $username)) {
        return invitaty_auth_error('invalid_username', 'El nombre de usuario solo puede contener letras, nÃºmeros, guiones y guiones bajos.', 400);
    }

    if (!is_email($email)) {
        return invitaty_auth_error('invalid_email', 'El email es invÃ¡lido.', 400);
    }

    if (strlen($password) < 6) {
        return invitaty_auth_error('invalid_password', 'La contraseÃ±a debe tener al menos 6 caracteres.', 400);
    }

    if (username_exists($username)) {
        return invitaty_auth_error('username_exists', 'Ese nombre de usuario ya existe.', 409);
    }

    if (email_exists($email)) {
        return invitaty_auth_error('email_exists', 'Ese email ya estÃ¡ registrado.', 409);
    }

    $user_id = wp_insert_user([
        'user_login'   => $username,
        'user_email'   => $email,
        'user_pass'    => $password,
        'display_name' => $display_name !== '' ? $display_name : $username,
        'role'         => 'subscriber',
    ]);

    if (is_wp_error($user_id)) {
        return invitaty_auth_error('register_failed', $user_id->get_error_message(), 400);
    }

    // Guardar consentimiento de marketing en usermeta
    update_user_meta($user_id, 'invitaty_marketing_consent', $marketing_consent ? 1 : 0);

    // Guardar idioma si se envÃ­a (ej: es, en, etc.)
    if ($language !== '' && preg_match('/^[a-z]{2,3}$/', $language)) {
        update_user_meta($user_id, 'invitaty_language', $language);
    }

    $session = invitaty_auth_create_session($user_id);

    if (!$session) {
        return invitaty_auth_error('session_failed', 'No se pudo crear la sesiÃ³n.', 500);
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Registro completado correctamente.',
        'token' => $session['token'],
        'expires_at' => $session['expires_at'],
        'user' => invitaty_auth_get_user_data_for_response($user_id),
    ], 201);
}

function invitaty_auth_login(WP_REST_Request $request) {
    $params = invitaty_auth_get_json_params($request);

    $login = isset($params['login']) ? sanitize_text_field($params['login']) : '';
    $password = isset($params['password']) ? (string) $params['password'] : '';

    $ip = invitaty_auth_get_request_ip();
    if (!invitaty_auth_rate_limit('login_' . $ip, 20, 900)) {
        return invitaty_auth_error('too_many_requests', 'Demasiados intentos. IntÃ©ntalo mÃ¡s tarde.', 429);
    }

    if ($login === '' || $password === '') {
        return invitaty_auth_error('missing_fields', 'Faltan campos obligatorios.', 400);
    }

    $user = wp_authenticate($login, $password);

    if (is_wp_error($user)) {
        return invitaty_auth_error('invalid_credentials', 'Credenciales incorrectas.', 401);
    }

    $session = invitaty_auth_create_session($user->ID);

    if (!$session) {
        return invitaty_auth_error('session_failed', 'No se pudo crear la sesiÃ³n.', 500);
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Login correcto.',
        'token' => $session['token'],
        'expires_at' => $session['expires_at'],
        'user' => invitaty_auth_get_user_data_for_response($user->ID),
    ], 200);
}

function invitaty_auth_me(WP_REST_Request $request) {
    $user_id = invitaty_auth_validate_token($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    return new WP_REST_Response([
        'success' => true,
        'user' => invitaty_auth_get_user_data_for_response($user_id),
    ], 200);
}

function invitaty_auth_logout(WP_REST_Request $request) {
    $user_id = invitaty_auth_validate_token($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    invitaty_auth_revoke_current_token($request);

    return new WP_REST_Response([
        'success' => true,
        'message' => 'SesiÃ³n cerrada correctamente.',
    ], 200);
}

function invitaty_auth_forgot_password(WP_REST_Request $request) {
    $params = invitaty_auth_get_json_params($request);

    $login = isset($params['login']) ? sanitize_text_field($params['login']) : '';

    $ip = invitaty_auth_get_request_ip();
    if (!invitaty_auth_rate_limit('forgot_' . $ip, 10, 900)) {
        return invitaty_auth_error('too_many_requests', 'Demasiados intentos. IntÃ©ntalo mÃ¡s tarde.', 429);
    }

    if ($login === '') {
        return invitaty_auth_error('missing_login', 'Debes indicar username o email.', 400);
    }

    $user = invitaty_auth_find_user_by_login_or_email($login);

    if ($user) {
        $reset = invitaty_auth_create_reset_code($user->ID);

        if ($reset) {
            invitaty_auth_send_reset_email($user, $reset['code']);
        }
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Si la cuenta existe, se ha enviado un cÃ³digo de verificaciÃ³n.',
    ], 200);
}

function invitaty_auth_reset_password(WP_REST_Request $request) {
    global $wpdb;

    $params = invitaty_auth_get_json_params($request);

    $login = isset($params['login']) ? sanitize_text_field($params['login']) : '';
    $code = isset($params['code']) ? preg_replace('/\D+/', '', (string) $params['code']) : '';
    $new_password = isset($params['new_password']) ? (string) $params['new_password'] : '';

    if ($login === '' || $code === '' || $new_password === '') {
        return invitaty_auth_error('missing_fields', 'Faltan campos obligatorios.', 400);
    }

    if (strlen($code) !== 6) {
        return invitaty_auth_error('invalid_code', 'El cÃ³digo no es vÃ¡lido.', 400);
    }

    if (strlen($new_password) < 6) {
        return invitaty_auth_error('invalid_password', 'La nueva contraseÃ±a debe tener al menos 6 caracteres.', 400);
    }

    $user = invitaty_auth_find_user_by_login_or_email($login);

    if (!$user) {
        return invitaty_auth_error('invalid_code', 'CÃ³digo o usuario no vÃ¡lidos.', 400);
    }

    $table_name = $wpdb->prefix . 'invitaty_password_resets';

    $reset_row = $wpdb->get_row(
        $wpdb->prepare(
            "SELECT * FROM {$table_name}
             WHERE user_id = %d
               AND used_at IS NULL
             ORDER BY id DESC
             LIMIT 1",
            $user->ID
        )
    );

    if (!$reset_row) {
        return invitaty_auth_error('invalid_code', 'CÃ³digo o usuario no vÃ¡lidos.', 400);
    }

    if ((int) $reset_row->attempts >= INVITATY_RESET_CODE_MAX_ATTEMPTS) {
        return invitaty_auth_error('too_many_attempts', 'Has superado el nÃºmero mÃ¡ximo de intentos.', 429);
    }

    if (strtotime($reset_row->expires_at) < current_time('timestamp')) {
        return invitaty_auth_error('expired_code', 'El cÃ³digo ha expirado.', 400);
    }

    $code_hash = invitaty_auth_hash_reset_code($code);

    if (!hash_equals($reset_row->code_hash, $code_hash)) {
        $wpdb->update(
            $table_name,
            ['attempts' => ((int) $reset_row->attempts) + 1],
            ['id' => (int) $reset_row->id],
            ['%d'],
            ['%d']
        );

        return invitaty_auth_error('invalid_code', 'CÃ³digo o usuario no vÃ¡lidos.', 400);
    }

    wp_set_password($new_password, $user->ID);

    $wpdb->update(
        $table_name,
        [
            'used_at' => current_time('mysql'),
            'attempts' => ((int) $reset_row->attempts) + 1,
        ],
        ['id' => (int) $reset_row->id],
        ['%s', '%d'],
        ['%d']
    );

    // Revocar todas las sesiones activas del usuario tras cambiar contraseÃ±a
    $sessions_table = $wpdb->prefix . 'invitaty_sessions';
    $wpdb->query(
        $wpdb->prepare(
            "UPDATE {$sessions_table}
             SET revoked_at = %s
             WHERE user_id = %d
               AND revoked_at IS NULL",
            current_time('mysql'),
            $user->ID
        )
    );

    return new WP_REST_Response([
        'success' => true,
        'message' => 'ContraseÃ±a restablecida correctamente.',
    ], 200);
}

function invitaty_auth_delete_account(WP_REST_Request $request) {
    global $wpdb;

    $user_id = invitaty_auth_validate_token($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = invitaty_auth_get_json_params($request);
    $password = isset($params['password']) ? (string) $params['password'] : '';

    if ($password === '') {
        return invitaty_auth_error('missing_password', 'Debes indicar tu contraseÃ±a actual.', 400);
    }

    $user = get_user_by('id', $user_id);

    if (!$user) {
        return invitaty_auth_error('invalid_user', 'Usuario no vÃ¡lido.', 404);
    }

    // Seguridad: no permitir borrar cuentas admin
    if (in_array('administrator', (array) $user->roles, true)) {
        return invitaty_auth_error('forbidden', 'Esta cuenta no se puede eliminar.', 403);
    }

    // Confirmar contraseÃ±a actual
    if (!wp_check_password($password, $user->user_pass, $user->ID)) {
        return invitaty_auth_error('wrong_password', 'La contraseÃ±a actual no es correcta.', 401);
    }

    // Cargar funciÃ³n de borrado de usuarios
    if (!function_exists('wp_delete_user')) {
        require_once ABSPATH . 'wp-admin/includes/user.php';
    }

    $deleted = wp_delete_user($user->ID);

    if (!$deleted) {
        return invitaty_auth_error('delete_failed', 'No se pudo eliminar la cuenta.', 500);
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'La cuenta ha sido eliminada correctamente.',
    ], 200);
}

function invitaty_auth_change_password(WP_REST_Request $request) {
    $user_id = invitaty_auth_validate_token($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = invitaty_auth_get_json_params($request);
    $current_password = isset($params['current_password']) ? (string) $params['current_password'] : '';
    $new_password     = isset($params['new_password'])     ? (string) $params['new_password']     : '';

    if ($current_password === '' || $new_password === '') {
        return invitaty_auth_error('missing_fields', 'Faltan campos obligatorios.', 400);
    }

    if (strlen($new_password) < 6) {
        return invitaty_auth_error('invalid_password', 'La contraseÃ±a debe tener al menos 6 caracteres.', 400);
    }

    $user = get_user_by('id', $user_id);

    if (!$user) {
        return invitaty_auth_error('invalid_user', 'Usuario no vÃ¡lido.', 404);
    }

    if (!wp_check_password($current_password, $user->user_pass, $user->ID)) {
        return invitaty_auth_error('wrong_password', 'La contraseÃ±a actual no es correcta.', 401);
    }

    wp_set_password($new_password, $user->ID);

    return new WP_REST_Response([
        'success' => true,
        'message' => 'ContraseÃ±a cambiada correctamente.',
    ], 200);
}