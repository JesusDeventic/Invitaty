<?php
if (!defined('ABSPATH')) {
    exit;
}

//require_once __DIR__ . '/invitaty_translations.php'; // No hace falta porque estan en otro snippet

/**
 * =========================================================
 * CREAR TABLA DE NOTIFICACIONES
 * =========================================================
 * DÃ©jalo activo una vez para crear/actualizar la tabla.
 * Luego, si quieres, comentas el add_action de abajo.
 */

function invitaty_notifications_create_table() {
    global $wpdb;

    $charset_collate = $wpdb->get_charset_collate();
    $table_name = $wpdb->prefix . 'invitaty_notifications';

    require_once ABSPATH . 'wp-admin/includes/upgrade.php';

    $sql = "CREATE TABLE {$table_name} (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id BIGINT UNSIGNED NOT NULL,
        title VARCHAR(255) NOT NULL,
        message TEXT NOT NULL,
        read_status TINYINT(1) NOT NULL DEFAULT 0,
        created_at DATETIME NOT NULL,
        PRIMARY KEY (id),
        KEY user_id (user_id),
        KEY read_status (read_status),
        KEY created_at (created_at)
    ) {$charset_collate};";

    dbDelta($sql);
}
add_action('init', 'invitaty_notifications_create_table');

/**
 * =========================================================
 * ENDPOINTS
 * =========================================================
 */
add_action('rest_api_init', function () {
    register_rest_route('invitaty/v1', '/push/register-token', [
        'methods' => 'POST',
        'callback' => 'invitaty_register_push_token',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('invitaty/v1', '/push/unregister-token', [
        'methods' => 'POST',
        'callback' => 'invitaty_unregister_push_token',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('invitaty/v1', '/notifications/unread-count', [
        'methods' => 'GET',
        'callback' => 'invitaty_get_unread_notifications_count',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('invitaty/v1', '/notifications', [
        'methods' => 'GET',
        'callback' => 'invitaty_get_notifications',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('invitaty/v1', '/notifications/mark-read', [
        'methods' => 'POST',
        'callback' => 'invitaty_mark_notification_as_read',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('invitaty/v1', '/notifications', [
        'methods' => 'DELETE',
        'callback' => 'invitaty_delete_notifications',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * =========================================================
 * HELPERS GENERALES
 * =========================================================
 */
function invitaty_notifications_error($code, $message, $status = 400) {
    return new WP_Error($code, $message, ['status' => $status]);
}

function invitaty_notifications_get_json_params(WP_REST_Request $request) {
    $params = $request->get_json_params();
    return is_array($params) ? $params : [];
}

function invitaty_get_authenticated_user_id_or_error(WP_REST_Request $request) {
    if (!function_exists('invitaty_auth_validate_token')) {
        return invitaty_notifications_error('auth_not_available', 'La autenticaciÃ³n de Invitaty no estÃ¡ disponible.', 500);
    }

    return invitaty_auth_validate_token($request);
}

/**
 * =========================================================
 * TOKENS FCM EN USERMETA
 * =========================================================
 */
function invitaty_get_user_fcm_tokens($user_id) {
    $tokens = get_user_meta($user_id, 'invitaty_fcm_tokens', true);
    return is_array($tokens) ? $tokens : [];
}

function invitaty_add_user_fcm_token($user_id, $fcm_token) {
    $tokens = invitaty_get_user_fcm_tokens($user_id);

    if (!in_array($fcm_token, $tokens, true)) {
        $tokens[] = $fcm_token;
        update_user_meta($user_id, 'invitaty_fcm_tokens', $tokens);
    }

    return $tokens;
}

function invitaty_remove_user_fcm_token($user_id, $fcm_token) {
    $tokens = invitaty_get_user_fcm_tokens($user_id);

    $tokens = array_values(array_filter($tokens, function ($token) use ($fcm_token) {
        return $token !== $fcm_token;
    }));

    update_user_meta($user_id, 'invitaty_fcm_tokens', $tokens);

    return $tokens;
}

/**
 * =========================================================
 * CREAR NOTIFICACIÃ“N INTERNA
 * =========================================================
 */
function invitaty_create_notification($user_id, $title, $message) {
    global $wpdb;

    $table_name = $wpdb->prefix . 'invitaty_notifications';

    $wpdb->insert(
        $table_name,
        [
            'user_id' => $user_id,
            'title' => $title,
            'message' => $message,
            'read_status' => 0,
            'created_at' => current_time('mysql'),
        ],
        ['%d', '%s', '%s', '%d', '%s']
    );

    return (int) $wpdb->insert_id;
}

/**
 * =========================================================
 * PUSH - REGISTRAR / ELIMINAR TOKEN
 * =========================================================
 */
function invitaty_register_push_token(WP_REST_Request $request) {
    $user_id = invitaty_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = invitaty_notifications_get_json_params($request);
    $fcm_token = sanitize_text_field($params['fcm_token'] ?? '');

    if ($fcm_token === '') {
        return invitaty_notifications_error('missing_fcm_token', 'El fcm_token es obligatorio.', 400);
    }

    invitaty_add_user_fcm_token($user_id, $fcm_token);

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Token push registrado correctamente.',
    ], 200);
}

function invitaty_unregister_push_token(WP_REST_Request $request) {
    $user_id = invitaty_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = invitaty_notifications_get_json_params($request);
    $fcm_token = sanitize_text_field($params['fcm_token'] ?? '');

    if ($fcm_token === '') {
        return invitaty_notifications_error('missing_fcm_token', 'El fcm_token es obligatorio.', 400);
    }

    invitaty_remove_user_fcm_token($user_id, $fcm_token);

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Token push eliminado correctamente.',
    ], 200);
}

/**
 * =========================================================
 * NOTIFICACIONES - RECUENTO
 * =========================================================
 */
function invitaty_get_unread_notifications_count(WP_REST_Request $request) {
    global $wpdb;

    $user_id = invitaty_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $table_name = $wpdb->prefix . 'invitaty_notifications';

    $count = $wpdb->get_var(
        $wpdb->prepare(
            "SELECT COUNT(*) FROM {$table_name} WHERE user_id = %d AND read_status = 0",
            $user_id
        )
    );

    return new WP_REST_Response([
        'unread_count' => (int) $count,
    ], 200);
}

/**
 * =========================================================
 * NOTIFICACIONES - LISTADO
 * =========================================================
 */
function invitaty_get_notifications(WP_REST_Request $request) {
    global $wpdb;

    $user_id = invitaty_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $page = max(1, (int) ($request->get_param('page') ?: 1));
    $per_page = max(1, min((int) ($request->get_param('per_page') ?: 20), 100));
    $offset = ($page - 1) * $per_page;

    $table_name = $wpdb->prefix . 'invitaty_notifications';

    $total = (int) $wpdb->get_var(
        $wpdb->prepare(
            "SELECT COUNT(*) FROM {$table_name} WHERE user_id = %d",
            $user_id
        )
    );

    $notifications = $wpdb->get_results(
        $wpdb->prepare(
            "SELECT * FROM {$table_name}
             WHERE user_id = %d
             ORDER BY created_at DESC
             LIMIT %d OFFSET %d",
            $user_id,
            $per_page,
            $offset
        ),
        ARRAY_A
    );

    foreach ($notifications as &$notification) {
        $notification['id'] = (int) $notification['id'];
        $notification['user_id'] = (int) $notification['user_id'];
        $notification['read_status'] = (bool) $notification['read_status'];
    }

    return new WP_REST_Response([
        'notifications' => $notifications,
        'total' => $total,
        'page' => $page,
        'per_page' => $per_page,
        'total_pages' => (int) ceil($total / $per_page),
    ], 200);
}

/**
 * =========================================================
 * NOTIFICACIONES - MARCAR COMO LEÃDA
 * =========================================================
 */
function invitaty_mark_notification_as_read(WP_REST_Request $request) {
    global $wpdb;

    $user_id = invitaty_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = invitaty_notifications_get_json_params($request);
    $notification_id = (int) ($params['notification_id'] ?? 0);

    $table_name = $wpdb->prefix . 'invitaty_notifications';

    if ($notification_id === 0) {
        $wpdb->update(
            $table_name,
            ['read_status' => 1],
            ['user_id' => $user_id, 'read_status' => 0],
            ['%d'],
            ['%d', '%d']
        );

        return new WP_REST_Response([
            'success' => true,
            'message' => 'Todas las notificaciones marcadas como leÃ­das.',
        ], 200);
    }

    $notification = $wpdb->get_row(
        $wpdb->prepare(
            "SELECT id FROM {$table_name} WHERE id = %d AND user_id = %d LIMIT 1",
            $notification_id,
            $user_id
        )
    );

    if (!$notification) {
        return invitaty_notifications_error('notification_not_found', 'La notificaciÃ³n no existe o no pertenece al usuario.', 404);
    }

    $wpdb->update(
        $table_name,
        ['read_status' => 1],
        ['id' => $notification_id, 'user_id' => $user_id],
        ['%d'],
        ['%d', '%d']
    );

    return new WP_REST_Response([
        'success' => true,
        'message' => 'NotificaciÃ³n marcada como leÃ­da.',
    ], 200);
}

/**
 * =========================================================
 * NOTIFICACIONES - ELIMINAR
 * =========================================================
 */
function invitaty_delete_notifications(WP_REST_Request $request) {
    global $wpdb;

    $user_id = invitaty_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $notification_id = (int) ($request->get_param('notification_id') ?: 0);
    $table_name = $wpdb->prefix . 'invitaty_notifications';

    if ($notification_id === 0) {
        $wpdb->delete($table_name, ['user_id' => $user_id], ['%d']);

        return new WP_REST_Response([
            'success' => true,
            'message' => 'Todas las notificaciones eliminadas.',
        ], 200);
    }

    $deleted = $wpdb->delete(
        $table_name,
        ['id' => $notification_id, 'user_id' => $user_id],
        ['%d', '%d']
    );

    if (!$deleted) {
        return invitaty_notifications_error('notification_not_found', 'La notificaciÃ³n no existe o no pertenece al usuario.', 404);
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'NotificaciÃ³n eliminada.',
    ], 200);
}

/**
 * =========================================================
 * FIREBASE FCM HTTP v1
 * =========================================================
 * Necesitas en wp-config.php:
 *
 * define('INVITATY_FIREBASE_PROJECT_ID', 'tu-project-id');
 * define('INVITATY_FIREBASE_SERVICE_ACCOUNT_PATH', ABSPATH . 'wp-content/invitaty-firebase.json o ruta que sea');
 */

function invitaty_firebase_base64url_encode($data) {
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}

function invitaty_get_firebase_access_token() {
    if (!defined('INVITATY_FIREBASE_SERVICE_ACCOUNT_PATH')) {
        return new WP_Error('firebase_config_missing', 'INVITATY_FIREBASE_SERVICE_ACCOUNT_PATH no estÃ¡ definida.');
    }

    $path = INVITATY_FIREBASE_SERVICE_ACCOUNT_PATH;

    if (!file_exists($path)) {
        return new WP_Error('firebase_service_account_missing', 'No se encuentra el JSON de la cuenta de servicio.');
    }

    $service_account = json_decode(file_get_contents($path), true);

    if (
        empty($service_account['client_email']) ||
        empty($service_account['private_key']) ||
        empty($service_account['token_uri'])
    ) {
        return new WP_Error('firebase_service_account_invalid', 'El JSON de la cuenta de servicio no es vÃ¡lido.');
    }

    $now = time();

    $header = [
        'alg' => 'RS256',
        'typ' => 'JWT',
    ];

    $claim_set = [
        'iss' => $service_account['client_email'],
        'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
        'aud' => $service_account['token_uri'],
        'iat' => $now,
        'exp' => $now + 3600,
    ];

    $jwt_header = invitaty_firebase_base64url_encode(wp_json_encode($header));
    $jwt_claims = invitaty_firebase_base64url_encode(wp_json_encode($claim_set));
    $unsigned_jwt = $jwt_header . '.' . $jwt_claims;

    $signature = '';
    $private_key = openssl_pkey_get_private($service_account['private_key']);

    if (!$private_key) {
        return new WP_Error('firebase_private_key_invalid', 'No se pudo cargar la private key.');
    }

    $signed = openssl_sign($unsigned_jwt, $signature, $private_key, 'sha256WithRSAEncryption');
    openssl_free_key($private_key);

    if (!$signed) {
        return new WP_Error('firebase_jwt_sign_failed', 'No se pudo firmar el JWT de Google.');
    }

    $jwt = $unsigned_jwt . '.' . invitaty_firebase_base64url_encode($signature);

    $response = wp_remote_post($service_account['token_uri'], [
        'headers' => [
            'Content-Type' => 'application/x-www-form-urlencoded',
        ],
        'body' => [
            'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
            'assertion' => $jwt,
        ],
        'timeout' => 20,
    ]);

    if (is_wp_error($response)) {
        return $response;
    }

    $body = json_decode(wp_remote_retrieve_body($response), true);

    if (empty($body['access_token'])) {
        return new WP_Error('firebase_access_token_failed', 'No se pudo obtener el access token de Firebase.', [
            'response' => $body,
        ]);
    }

    return $body['access_token'];
}

function invitaty_send_push_to_token($fcm_token, $title, $message) {
    if (!defined('INVITATY_FIREBASE_PROJECT_ID')) {
        return new WP_Error('firebase_project_missing', 'INVITATY_FIREBASE_PROJECT_ID no estÃ¡ definida.');
    }

    $access_token = invitaty_get_firebase_access_token();

    if (is_wp_error($access_token)) {
        return $access_token;
    }

    $endpoint = 'https://fcm.googleapis.com/v1/projects/' . INVITATY_FIREBASE_PROJECT_ID . '/messages:send';

    $payload = [
        'message' => [
            'token' => $fcm_token,
            'notification' => [
                'title' => $title,
                'body' => $message,
            ],
        ],
    ];

    $response = wp_remote_post($endpoint, [
        'headers' => [
            'Authorization' => 'Bearer ' . $access_token,
            'Content-Type' => 'application/json; charset=UTF-8',
        ],
        'body' => wp_json_encode($payload),
        'timeout' => 20,
    ]);

    if (is_wp_error($response)) {
        return $response;
    }

    $code = wp_remote_retrieve_response_code($response);
    $body = json_decode(wp_remote_retrieve_body($response), true);

    if ($code < 200 || $code >= 300) {
        return new WP_Error('firebase_send_failed', 'Error enviando push a Firebase.', [
            'status_code' => $code,
            'response' => $body,
        ]);
    }

    return $body;
}

function invitaty_send_push_to_topic($topic, $title, $message) {
    if (!defined('INVITATY_FIREBASE_PROJECT_ID')) {
        return new WP_Error('firebase_project_missing', 'INVITATY_FIREBASE_PROJECT_ID no estÃ¡ definida.');
    }

    $access_token = invitaty_get_firebase_access_token();

    if (is_wp_error($access_token)) {
        return $access_token;
    }

    $endpoint = 'https://fcm.googleapis.com/v1/projects/' . INVITATY_FIREBASE_PROJECT_ID . '/messages:send';

    $payload = [
        'message' => [
            'topic' => $topic,
            'notification' => [
                'title' => $title,
                'body' => $message,
            ],
            'data' => [
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                'topic' => $topic,
            ],
        ],
    ];

    $response = wp_remote_post($endpoint, [
        'headers' => [
            'Authorization' => 'Bearer ' . $access_token,
            'Content-Type' => 'application/json; charset=UTF-8',
        ],
        'body' => wp_json_encode($payload),
        'timeout' => 20,
    ]);

    if (is_wp_error($response)) {
        return $response;
    }

    $code = wp_remote_retrieve_response_code($response);
    $body = json_decode(wp_remote_retrieve_body($response), true);

    if ($code < 200 || $code >= 300) {
        return new WP_Error('firebase_send_failed', 'Error enviando push a Firebase (topic).', [
            'status_code' => $code,
            'response' => $body,
        ]);
    }

    return $body;
}

function invitaty_send_push_to_user($user_id, $title, $message) {
    $tokens = invitaty_get_user_fcm_tokens($user_id);

    if (empty($tokens)) {
        return [
            'success' => true,
            'sent' => 0,
            'failed' => 0,
            'results' => [],
        ];
    }

    $sent = 0;
    $failed = 0;
    $results = [];

    foreach ($tokens as $token) {
        $result = invitaty_send_push_to_token($token, $title, $message);

        if (is_wp_error($result)) {
            $failed++;
            invitaty_remove_user_fcm_token($user_id, $token);

            $results[] = [
                'token' => $token,
                'success' => false,
                'error' => $result->get_error_message(),
            ];
        } else {
            $sent++;
            $results[] = [
                'token' => $token,
                'success' => true,
            ];
        }
    }

    return [
        'success' => true,
        'sent' => $sent,
        'failed' => $failed,
        'results' => $results,
    ];
}

/**
 * =========================================================
 * FUNCIÃ“N PRÃCTICA: CREA NOTIFICACIÃ“N + ENVÃA PUSH
 * =========================================================
 */
function invitaty_notify_user($user_id, $title, $message, $send_push = true) {
    $notification_id = invitaty_create_notification($user_id, $title, $message);
    $push_result = $send_push
        ? invitaty_send_push_to_user($user_id, $title, $message)
        : [
            'success' => true,
            'sent' => 0,
            'failed' => 0,
            'results' => [],
        ];

    return [
        'notification_id' => $notification_id,
        'push' => $push_result,
    ];
}

/**
 * EnvÃ­a notificaciÃ³n + push en el idioma del usuario (invitaty_language).
 * Usa claves de invitaty_translations.php. Ejemplo:
 *   invitaty_notify_user_translated($user_id, 'notif_new_msg_title', 'notif_new_msg_body', ['name' => 'Juan']);
 */
function invitaty_notify_user_translated($user_id, $title_key, $message_key, $replacements = [], $send_push = true) {
    $locale = function_exists('invitaty_get_user_language') ? invitaty_get_user_language($user_id) : 'en';
    $title = invitaty_t($title_key, $locale, $replacements);
    $message = invitaty_t($message_key, $locale, $replacements);
    return invitaty_notify_user($user_id, $title, $message, $send_push);
}