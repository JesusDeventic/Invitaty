<?php
/**
 * Invitaty Update User Endpoint
 */

if (!defined('ABSPATH')) {
    exit;
}

// Necesario para wp_handle_upload y wp_get_image_editor
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/image.php';

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
            // Cache-buster automÃ¡tico usando la fecha de modificaciÃ³n del archivo
            return add_query_arg('v', (string) filemtime($path), invitaty_avatar_url($user_id));
        }
        return get_avatar_url($user_id);
    }
}

if (!function_exists('invitaty_delete_old_avatar_if_exists')) {
    function invitaty_delete_old_avatar_if_exists($user_id) {
        $path = invitaty_avatar_path($user_id);
        if (file_exists($path)) {
            @unlink($path);
        }
    }
}

function invitaty_upload_dir_app_avatars($dirs) {
    // Directorio plano sin subcarpetas por aÃ±o/mes
    $dirs['subdir'] = '/app_avatars';
    $dirs['path']   = $dirs['basedir'] . '/app_avatars';
    $dirs['url']    = $dirs['baseurl'] . '/app_avatars';
    return $dirs;
}

/**
 * =========================================================
 * ENDPOINT
 * =========================================================
 */
add_action('rest_api_init', function () {
    register_rest_route('invitaty/v1', '/user/update', [
        'methods' => 'POST',
        'callback' => 'invitaty_update_user',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('invitaty/v1', '/user/public/(?P<username>[A-Za-z0-9._-]+)', [
        'methods' => 'GET',
        'callback' => 'invitaty_get_public_user_by_username',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * =========================================================
 * HELPERS
 * =========================================================
 */
function invitaty_get_full_user_data($user_id) {
    global $wpdb;

    $user = get_userdata($user_id);

    if (!$user) {
        return null;
    }

    $retroteca_vip = get_user_meta($user->ID, 'invitaty_retroteca_vip', false);
    $retroteca_vip = ($retroteca_vip === '') ? 1 : $retroteca_vip;

    // Ãšltimo login desde wp_invitaty_sessions (MAX created_at)
    $sessions_table = $wpdb->prefix . 'invitaty_sessions';
    $last_login = $wpdb->get_var($wpdb->prepare(
        "SELECT MAX(created_at) FROM {$sessions_table} WHERE user_id = %d",
        $user->ID
    ));

    return [
        'id' => (int) $user->ID,
        'username' => $user->user_login,
        'user_email' => $user->user_email,
        'user_url' => $user->user_url ?: '',
        'display_name' => $user->display_name,
        'first_name' => get_user_meta($user->ID, 'first_name', true) ?: '',
        'last_name' => get_user_meta($user->ID, 'last_name', true) ?: '',
        'user_registered' => $user->user_registered,
        'description' => $user->description ?: '',
        'avatar_url' => function_exists('invitaty_get_user_avatar_url')
            ? invitaty_get_user_avatar_url($user->ID)
            : get_avatar_url($user->ID),
        'language' => get_user_meta($user->ID, 'invitaty_language', true) ?: 'es',
        'start_day_week' => get_user_meta($user->ID, 'invitaty_start_day_week', true) ?: 'monday',
        'date_format' => get_user_meta($user->ID, 'invitaty_date_format', true) ?: 'dd/MM/yyyy',
        'country' => get_user_meta($user->ID, 'invitaty_country', true) ?: '',
        'birthdate' => get_user_meta($user->ID, 'invitaty_birthdate', true) ?: '',
        'invitaty_retroteca_vip' => (bool) $retroteca_vip,
        'marketing_consent' => (bool) get_user_meta($user->ID, 'invitaty_marketing_consent', true),
        'account_status' => get_user_meta($user->ID, 'invitaty_account_status', true) ?: 'active',
        'invitaty_last_login' => $last_login ?: '',
        'invitaty_review_status' => get_user_meta($user->ID, 'invitaty_review_status', true) ?: 'none',
        'invitaty_review_prompted_at' => get_user_meta($user->ID, 'invitaty_review_prompted_at', true) ?: '',
    ];
}

function invitaty_sanitize_profile_url($raw_url) {
    $raw_url = trim((string) $raw_url);
    if ($raw_url === '') {
        return '';
    }

    if (!preg_match('#^https?://#i', $raw_url)) {
        $raw_url = 'https://' . $raw_url;
    }

    $url = esc_url_raw($raw_url, ['http', 'https']);
    if (empty($url)) {
        return false;
    }

    return $url;
}

function invitaty_get_public_user_by_username(WP_REST_Request $request) {
    $raw_username = (string) $request->get_param('username');
    $username = sanitize_user(wp_unslash($raw_username), true);

    if ($username === '') {
        return new WP_Error('invalid_username', 'Nombre de usuario no vÃ¡lido.', ['status' => 400]);
    }

    $user = get_user_by('login', $username);
    if (!$user) {
        return new WP_Error('user_not_found', 'Usuario no encontrado.', ['status' => 404]);
    }

    $account_status = get_user_meta($user->ID, 'invitaty_account_status', true) ?: 'active';
    if ($account_status !== 'active') {
        return new WP_Error('user_not_available', 'Perfil no disponible.', ['status' => 404]);
    }

    $data = invitaty_get_full_user_data($user->ID);
    if (!$data) {
        return new WP_Error('user_not_found', 'Usuario no encontrado.', ['status' => 404]);
    }

    return new WP_REST_Response([
        'success' => true,
        'user' => $data,
    ], 200);
}

function invitaty_normalize_birthdate($raw_date) {
    $raw_date = trim((string) $raw_date);

    if ($raw_date === '') {
        return '';
    }

    $date_obj = DateTime::createFromFormat('Y-m-d', $raw_date);
    if ($date_obj && $date_obj->format('Y-m-d') === $raw_date) {
        return $date_obj->format('Y-m-d');
    }

    $date_obj = DateTime::createFromFormat('d-m-Y', $raw_date);
    if ($date_obj) {
        return $date_obj->format('Y-m-d');
    }

    $date_obj = DateTime::createFromFormat('d/m/Y', $raw_date);
    if ($date_obj) {
        return $date_obj->format('Y-m-d');
    }

    return false;
}

/**
 * =========================================================
 * CALLBACK
 * =========================================================
 */
function invitaty_update_user(WP_REST_Request $request) {
    if (!function_exists('invitaty_auth_validate_token')) {
        return new WP_Error('auth_not_available', 'La autenticaciÃ³n de Invitaty no estÃ¡ disponible.', ['status' => 500]);
    }

    $user_id = invitaty_auth_validate_token($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $user = get_userdata($user_id);

    if (!$user) {
        return new WP_Error('invalid_user', 'Usuario no vÃ¡lido.', ['status' => 404]);
    }

    $account_status = get_user_meta($user_id, 'invitaty_account_status', true) ?: 'active';
    if ($account_status !== 'active') {
        return new WP_Error('account_not_active', 'La cuenta no estÃ¡ activa.', ['status' => 403]);
    }

    $updated_user_data = [
        'ID' => $user_id,
    ];

    /**
     * =========================================================
     * CAMPOS WP CORE
     * =========================================================
     */

    if (isset($_POST['user_email'])) {
        $user_email = sanitize_email(wp_unslash($_POST['user_email']));

        if (!is_email($user_email)) {
            return new WP_Error('invalid_email', 'El email no es vÃ¡lido.', ['status' => 400]);
        }

        $existing_user = get_user_by('email', $user_email);
        if ($existing_user && (int) $existing_user->ID !== (int) $user_id) {
            return new WP_Error('email_exists', 'Ese email ya estÃ¡ en uso por otro usuario.', ['status' => 409]);
        }

        $updated_user_data['user_email'] = $user_email;
    }

    if (isset($_POST['display_name'])) {
        $updated_user_data['display_name'] = sanitize_text_field(wp_unslash($_POST['display_name']));
    }

    if (isset($_POST['first_name'])) {
        $updated_user_data['first_name'] = sanitize_text_field(wp_unslash($_POST['first_name']));
    }

    if (isset($_POST['last_name'])) {
        $updated_user_data['last_name'] = sanitize_text_field(wp_unslash($_POST['last_name']));
    }

    if (isset($_POST['user_url'])) {
        $user_url = invitaty_sanitize_profile_url(wp_unslash($_POST['user_url']));
        if ($user_url === false) {
            return new WP_Error('invalid_url', 'La URL de la web/blog no es vÃ¡lida.', ['status' => 400]);
        }
        $updated_user_data['user_url'] = $user_url;
    }

    if (isset($_POST['description'])) {
        $updated_user_data['description'] = wp_kses_post(wp_unslash($_POST['description']));
    }

    if (count($updated_user_data) > 1) {
        $updated = wp_update_user($updated_user_data);

        if (is_wp_error($updated)) {
            return new WP_Error('update_failed', $updated->get_error_message(), ['status' => 500]);
        }
    }

    /**
     * =========================================================
     * USERMETA INVITATY (prefijo invitaty_* en BD por compatibilidad)
     * =========================================================
     */

    if (isset($_POST['language'])) {
        update_user_meta($user_id, 'invitaty_language', sanitize_text_field(wp_unslash($_POST['language'])));
    }

    if (isset($_POST['start_day_week'])) {
        $start_day_week = sanitize_text_field(wp_unslash($_POST['start_day_week']));

        if (in_array($start_day_week, ['monday', 'sunday'], true)) {
            update_user_meta($user_id, 'invitaty_start_day_week', $start_day_week);
        }
    }

    if (isset($_POST['date_format'])) {
        update_user_meta($user_id, 'invitaty_date_format', sanitize_text_field(wp_unslash($_POST['date_format'])));
    }

    if (isset($_POST['country'])) {
        update_user_meta($user_id, 'invitaty_country', strtoupper(sanitize_text_field(wp_unslash($_POST['country']))));
    }

    if (isset($_POST['birthdate'])) {
        $normalized_birthdate = invitaty_normalize_birthdate(wp_unslash($_POST['birthdate']));

        if ($normalized_birthdate === false) {
            return new WP_Error('invalid_birthdate', 'La fecha de nacimiento no tiene un formato vÃ¡lido.', ['status' => 400]);
        }

        update_user_meta($user_id, 'invitaty_birthdate', $normalized_birthdate);
    }

    if (isset($_POST['marketing_consent'])) {
        $marketing_consent = filter_var(wp_unslash($_POST['marketing_consent']), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);

        if ($marketing_consent !== null) {
            update_user_meta($user_id, 'invitaty_marketing_consent', $marketing_consent ? 1 : 0);
        }
    }

    /**
     * =========================================================
     * AVATAR
     * =========================================================
     */

    $delete_avatar = false;

    if (isset($_POST['delete_avatar'])) {
        $delete_avatar = filter_var(wp_unslash($_POST['delete_avatar']), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) === true;
    }

    if ($delete_avatar) {
        invitaty_delete_old_avatar_if_exists($user_id);
    }

    if (!empty($_FILES['avatar']) && !empty($_FILES['avatar']['tmp_name'])) {
        $file = $_FILES['avatar'];

        if (!empty($file['error'])) {
            return new WP_Error('upload_error', 'Error al subir el avatar.', ['status' => 400]);
        }

        $allowed_mimes = [
            'jpg|jpeg|jpe' => 'image/jpeg',
            'png'          => 'image/png',
            'webp'         => 'image/webp',
        ];

        $overrides = [
            'test_form' => false,
            'mimes' => $allowed_mimes,
        ];

        // Asegurarse de que wp-content/uploads/app_avatars/ existe
        $upload_dir = wp_upload_dir();
        wp_mkdir_p($upload_dir['basedir'] . '/app_avatars');

        add_filter('upload_dir', 'invitaty_upload_dir_app_avatars');
        $uploaded = wp_handle_upload($file, $overrides);
        remove_filter('upload_dir', 'invitaty_upload_dir_app_avatars');

        if (isset($uploaded['error'])) {
            return new WP_Error('upload_failed', $uploaded['error'], ['status' => 400]);
        }

        $final_path = invitaty_avatar_path($user_id);

        // Convertir a WebP si viene png/jpg; si falla se usa el archivo original
        $src_file = $uploaded['file'];
        $src_type = $uploaded['type'];
        if (in_array($src_type, ['image/png', 'image/jpeg'], true)) {
            $editor = wp_get_image_editor($src_file);
            if (!is_wp_error($editor)) {
                $saved = $editor->save($src_file . '_tmp.webp', 'image/webp');
                if (!is_wp_error($saved) && isset($saved['path'])) {
                    @unlink($src_file);
                    $src_file = $saved['path'];
                }
            }
        }

        // Renombrar al nombre definitivo: {user_id}.webp (sobreescribe el avatar anterior si existe)
        rename($src_file, $final_path);
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Usuario actualizado correctamente.',
        'user' => invitaty_get_full_user_data($user_id),
    ], 200);
}