<?php
/**
 * Filmaniak Private Messages API
 * Mensajería privada entre usuarios.
 */

if (!defined('ABSPATH')) {
    exit;
}

/**
 * =========================================================
 * INSTALACIÓN DE TABLA
 * =========================================================
 */
function filmaniak_messages_install_table() {
    global $wpdb;
    $table = $wpdb->prefix . 'filmaniak_private_messages';
    $charset_collate = $wpdb->get_charset_collate();

    $sql = "CREATE TABLE IF NOT EXISTS {$table} (
        id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        sender_id    BIGINT UNSIGNED NOT NULL,
        recipient_id BIGINT UNSIGNED NOT NULL,
        message      TEXT NOT NULL,
        is_read      TINYINT(1) NOT NULL DEFAULT 0,
        created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        edited_at    DATETIME NULL DEFAULT NULL,
        deleted_at   DATETIME NULL DEFAULT NULL,
        PRIMARY KEY (id),
        INDEX idx_sender (sender_id),
        INDEX idx_recipient (recipient_id),
        INDEX idx_created (created_at)
    ) {$charset_collate};";

    require_once ABSPATH . 'wp-admin/includes/upgrade.php';
    dbDelta($sql);
}
add_action('init', 'filmaniak_messages_install_table');

/**
 * =========================================================
 * ENDPOINTS
 * =========================================================
 */
add_action('rest_api_init', function () {
    register_rest_route('filmaniak/v1', '/messages/conversations', [
        'methods'             => 'GET',
        'callback'            => 'filmaniak_msg_get_conversations',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('filmaniak/v1', '/messages', [
        'methods'             => 'GET',
        'callback'            => 'filmaniak_msg_get_messages',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('filmaniak/v1', '/messages/unread-count', [
        'methods'             => 'GET',
        'callback'            => 'filmaniak_msg_unread_count',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('filmaniak/v1', '/messages/read-status', [
        'methods'             => 'GET',
        'callback'            => 'filmaniak_msg_read_status',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('filmaniak/v1', '/messages/send', [
        'methods'             => 'POST',
        'callback'            => 'filmaniak_msg_send',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('filmaniak/v1', '/messages/edit', [
        'methods'             => 'POST',
        'callback'            => 'filmaniak_msg_edit',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('filmaniak/v1', '/messages/delete', [
        'methods'             => 'POST',
        'callback'            => 'filmaniak_msg_delete',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * =========================================================
 * HELPERS
 * =========================================================
 */
function filmaniak_msg_validate(WP_REST_Request $request) {
    return filmaniak_auth_validate_token($request);
}

function filmaniak_msg_user_data(int $user_id): array {
    $user = get_userdata($user_id);
    if (!$user) return ['id' => $user_id, 'username' => '', 'avatar_url' => ''];
    return [
        'id'         => $user_id,
        'username'   => $user->user_login,
        'avatar_url' => function_exists('filmaniak_get_user_avatar_url')
            ? filmaniak_get_user_avatar_url($user_id)
            : get_avatar_url($user_id),
    ];
}

/**
 * =========================================================
 * GET /messages/conversations
 * Lista de conversaciones con el último mensaje de cada una.
 * =========================================================
 */
function filmaniak_msg_get_conversations(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $limit  = max(1, min(50, (int) ($request->get_param('limit')  ?? 20)));
    $offset = max(0, (int) ($request->get_param('offset') ?? 0));

    $table = $wpdb->prefix . 'filmaniak_private_messages';

    // Obtener el último mensaje por conversación
    $rows = $wpdb->get_results($wpdb->prepare("
        SELECT m.*
        FROM {$table} m
        INNER JOIN (
            SELECT MAX(id) AS max_id
            FROM {$table}
            WHERE (sender_id = %d OR recipient_id = %d)
            GROUP BY LEAST(sender_id, recipient_id), GREATEST(sender_id, recipient_id)
        ) latest ON m.id = latest.max_id
        ORDER BY m.created_at DESC
        LIMIT %d OFFSET %d
    ", $user_id, $user_id, $limit, $offset), ARRAY_A);

    $conversations = [];
    foreach ($rows as $row) {
        $other_id = (int) $row['sender_id'] === $user_id
            ? (int) $row['recipient_id']
            : (int) $row['sender_id'];

        // ¿hay mensajes no leídos del otro usuario?
        $has_unread = (bool) $wpdb->get_var($wpdb->prepare("
            SELECT COUNT(*) FROM {$table}
            WHERE sender_id = %d AND recipient_id = %d AND is_read = 0 AND deleted_at IS NULL
        ", $other_id, $user_id));

        $conversations[] = [
            'other_user'   => filmaniak_msg_user_data($other_id),
            'last_message' => [
                'id'         => (int) $row['id'],
                'sender_id'  => (int) $row['sender_id'],
                'content'    => $row['deleted_at'] ? null : $row['message'],
                'is_read'    => (bool) $row['is_read'],
                'created_at' => $row['created_at'],
                'edited_at'  => $row['edited_at'],
                'deleted_at' => $row['deleted_at'],
            ],
            'has_unread' => $has_unread,
        ];
    }

    return new WP_REST_Response(['success' => true, 'conversations' => $conversations], 200);
}

/**
 * =========================================================
 * GET /messages?other_user_id=X[&before_id=Y|after_created=Z]
 * Mensajes de una conversación. Marca como leídos los del otro.
 * =========================================================
 */
function filmaniak_msg_get_messages(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $other_id = (int) ($request->get_param('other_user_id') ?? 0);
    if (!$other_id) return new WP_Error('missing_param', 'Falta other_user_id.', ['status' => 400]);

    $before_id     = $request->get_param('before_id');
    $after_created = $request->get_param('after_created');

    $table = $wpdb->prefix . 'filmaniak_private_messages';

    $where = $wpdb->prepare(
        "((sender_id = %d AND recipient_id = %d) OR (sender_id = %d AND recipient_id = %d))",
        $user_id, $other_id, $other_id, $user_id
    );

    if ($before_id !== null) {
        $where .= $wpdb->prepare(" AND id < %d", (int) $before_id);
    } elseif ($after_created !== null) {
        $ts = sanitize_text_field($after_created);
        $where .= $wpdb->prepare(
            " AND (created_at > %s OR edited_at > %s OR deleted_at > %s)",
            $ts, $ts, $ts
        );
    }

    $rows = $wpdb->get_results(
        "SELECT * FROM {$table} WHERE {$where} ORDER BY created_at DESC LIMIT 50",
        ARRAY_A
    );

    // Marcar como leídos los mensajes del otro dirigidos al usuario actual
    $wpdb->query($wpdb->prepare(
        "UPDATE {$table} SET is_read = 1
         WHERE sender_id = %d AND recipient_id = %d AND is_read = 0",
        $other_id, $user_id
    ));

    $messages = array_map(function ($row) {
        return [
            'id'           => (int) $row['id'],
            'sender_id'    => (int) $row['sender_id'],
            'recipient_id' => (int) $row['recipient_id'],
            'message'      => $row['deleted_at'] ? null : $row['message'],
            'is_read'      => (bool) $row['is_read'],
            'created_at'   => $row['created_at'],
            'edited_at'    => $row['edited_at'],
            'deleted_at'   => $row['deleted_at'],
        ];
    }, $rows);

    return new WP_REST_Response(['success' => true, 'messages' => $messages], 200);
}

/**
 * =========================================================
 * GET /messages/unread-count
 * =========================================================
 */
function filmaniak_msg_unread_count(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $table = $wpdb->prefix . 'filmaniak_private_messages';
    $count = (int) $wpdb->get_var($wpdb->prepare(
        "SELECT COUNT(*) FROM {$table} WHERE recipient_id = %d AND is_read = 0 AND deleted_at IS NULL",
        $user_id
    ));

    return new WP_REST_Response(['success' => true, 'unread_count' => $count], 200);
}

/**
 * =========================================================
 * GET /messages/read-status?other_user_id=X
 * ¿Fue leído mi último mensaje por el otro usuario?
 * =========================================================
 */
function filmaniak_msg_read_status(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $other_id = (int) ($request->get_param('other_user_id') ?? 0);
    if (!$other_id) return new WP_Error('missing_param', 'Falta other_user_id.', ['status' => 400]);

    $table = $wpdb->prefix . 'filmaniak_private_messages';
    $last = $wpdb->get_row($wpdb->prepare(
        "SELECT is_read FROM {$table}
         WHERE sender_id = %d AND recipient_id = %d
         ORDER BY id DESC LIMIT 1",
        $user_id, $other_id
    ));

    return new WP_REST_Response([
        'success' => true,
        'is_read' => $last ? (bool) $last->is_read : null,
    ], 200);
}

/**
 * =========================================================
 * POST /messages/send
 * Body: { recipient_id, message }
 * =========================================================
 */
function filmaniak_msg_send(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $params       = $request->get_json_params() ?? [];
    $recipient_id = (int) ($params['recipient_id'] ?? 0);
    $message      = isset($params['message']) ? trim((string) $params['message']) : '';

    if (!$recipient_id || $message === '') {
        return new WP_Error('missing_fields', 'Faltan campos obligatorios.', ['status' => 400]);
    }
    if ($recipient_id === $user_id) {
        return new WP_Error('invalid_recipient', 'No puedes enviarte mensajes a ti mismo.', ['status' => 400]);
    }
    if (!get_userdata($recipient_id)) {
        return new WP_Error('invalid_recipient', 'Usuario destinatario no existe.', ['status' => 404]);
    }
    if (mb_strlen($message) > 2000) {
        return new WP_Error('message_too_long', 'El mensaje no puede superar 2000 caracteres.', ['status' => 400]);
    }

    $table = $wpdb->prefix . 'filmaniak_private_messages';
    $wpdb->insert($table, [
        'sender_id'    => $user_id,
        'recipient_id' => $recipient_id,
        'message'      => $message,
        'is_read'      => 0,
        'created_at'   => current_time('mysql'),
    ], ['%d', '%d', '%s', '%d', '%s']);

    $inserted_id = (int) $wpdb->insert_id;

    // Push notification al destinatario
    filmaniak_msg_send_push($recipient_id, $user_id, $message);

    return new WP_REST_Response([
        'success' => true,
        'message' => [
            'id'           => $inserted_id,
            'sender_id'    => $user_id,
            'recipient_id' => $recipient_id,
            'message'      => $message,
            'is_read'      => false,
            'created_at'   => current_time('mysql'),
            'edited_at'    => null,
            'deleted_at'   => null,
        ],
    ], 200);
}

/**
 * =========================================================
 * POST /messages/edit
 * Body: { id, message }
 * =========================================================
 */
function filmaniak_msg_edit(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $params  = $request->get_json_params() ?? [];
    $msg_id  = (int) ($params['id'] ?? 0);
    $message = isset($params['message']) ? trim((string) $params['message']) : '';

    if (!$msg_id || $message === '') {
        return new WP_Error('missing_fields', 'Faltan campos obligatorios.', ['status' => 400]);
    }

    $table = $wpdb->prefix . 'filmaniak_private_messages';
    $row   = $wpdb->get_row($wpdb->prepare("SELECT * FROM {$table} WHERE id = %d", $msg_id), ARRAY_A);

    if (!$row) return new WP_Error('not_found', 'Mensaje no encontrado.', ['status' => 404]);
    if ((int) $row['sender_id'] !== $user_id) return new WP_Error('forbidden', 'No puedes editar este mensaje.', ['status' => 403]);
    if ($row['deleted_at']) return new WP_Error('already_deleted', 'El mensaje ya fue eliminado.', ['status' => 400]);

    $wpdb->update($table,
        ['message' => $message, 'edited_at' => current_time('mysql')],
        ['id' => $msg_id],
        ['%s', '%s'], ['%d']
    );

    return new WP_REST_Response(['success' => true], 200);
}

/**
 * =========================================================
 * POST /messages/delete
 * Body: { id }   — soft delete
 * =========================================================
 */
function filmaniak_msg_delete(WP_REST_Request $request) {
    global $wpdb;

    $user_id = filmaniak_msg_validate($request);
    if (is_wp_error($user_id)) return $user_id;

    $params = $request->get_json_params() ?? [];
    $msg_id = (int) ($params['id'] ?? 0);

    if (!$msg_id) return new WP_Error('missing_fields', 'Falta el id del mensaje.', ['status' => 400]);

    $table = $wpdb->prefix . 'filmaniak_private_messages';
    $row   = $wpdb->get_row($wpdb->prepare("SELECT * FROM {$table} WHERE id = %d", $msg_id), ARRAY_A);

    if (!$row) return new WP_Error('not_found', 'Mensaje no encontrado.', ['status' => 404]);
    if ((int) $row['sender_id'] !== $user_id) return new WP_Error('forbidden', 'No puedes eliminar este mensaje.', ['status' => 403]);

    $wpdb->update($table,
        ['deleted_at' => current_time('mysql')],
        ['id' => $msg_id],
        ['%s'], ['%d']
    );

    return new WP_REST_Response(['success' => true], 200);
}

/**
 * =========================================================
 * PUSH NOTIFICATION AL DESTINATARIO
 * =========================================================
 */
function filmaniak_msg_send_push(int $recipient_id, int $sender_id, string $message_text) {
    $sender = get_userdata($sender_id);
    if (!$sender) return;

    $tokens_meta = get_user_meta($recipient_id, 'filmaniak_fcm_tokens', true);
    // Nota: el envío PUSH real está implementado en `notificaciones.php`.
    // Para mensajes privados NO queremos crear registro DB por cada mensaje:
    // solo el push (tipo Fitcron).

    $locale = function_exists('filmaniak_get_user_language') ? filmaniak_get_user_language($recipient_id) : 'en';
    $senderName = (string) $sender->user_login;

    $bodyText = mb_strlen($message_text) > 100
        ? mb_substr($message_text, 0, 97) . '...'
        : $message_text;

    // Título traducido según idioma del destinatario.
    $title = function_exists('filmaniak_t')
        ? filmaniak_t('new_private_message_title', $locale, ['name' => $senderName])
        : "Nuevo mensaje de " . $senderName;

    // Body por sistema de traducciones (aunque sea "{message}").
    $body = $bodyText;

    if (function_exists('filmaniak_send_push_to_user')) {
        filmaniak_send_push_to_user($recipient_id, $title, $body);
        return;
    }

    // Fallback: si por orden de carga no existe lo anterior, intentamos usar
    // la función de token (también definida en `notificaciones.php`).
    if (function_exists('filmaniak_send_push_to_token')) {
        if (is_array($tokens_meta)) {
            foreach ($tokens_meta as $token_data) {
                $fcm_token = is_array($token_data) ? ($token_data['token'] ?? '') : (string) $token_data;
                if (empty($fcm_token)) continue;
                filmaniak_send_push_to_token($fcm_token, $title, $body);
            }
        }
    }
}
