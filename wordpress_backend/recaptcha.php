<?php
if (!defined('ABSPATH')) {
    exit;
}

add_action('rest_api_init', function () {
    register_rest_route('filmaniak/v1', '/verify-recaptcha', array(
        'methods'             => 'POST',
        'callback'            => 'filmaniak_verify_recaptcha',
        'permission_callback' => '__return_true',
    ));
});

function filmaniak_verify_recaptcha(WP_REST_Request $request) {
    $token = $request->get_param('token');

    if (empty($token)) {
        return new WP_Error(
            'missing_token',
            'Token is required',
            array('status' => 400)
        );
    }

    // Rellena en `wp-config.php`:
    // define('FILMANIAK_RECAPTCHA_SECRET_KEY', 'tu_secret_key');
    $secret_key = defined('FILMANIAK_RECAPTCHA_SECRET_KEY')
        ? (string) FILMANIAK_RECAPTCHA_SECRET_KEY
        : '';

    if ($secret_key === '') {
        return new WP_Error(
            'recaptcha_secret_missing',
            'Falta FILMANIAK_RECAPTCHA_SECRET_KEY en wp-config.php',
            array('status' => 500)
        );
    }

    $verify_url = 'https://www.google.com/recaptcha/api/siteverify';

    $response = wp_remote_post($verify_url, array(
        'body' => array(
            'secret'   => $secret_key,
            'response' => $token,
        ),
    ));

    if (is_wp_error($response)) {
        return new WP_Error(
            'verification_failed',
            'Failed to verify reCAPTCHA',
            array('status' => 500)
        );
    }

    $body = json_decode(wp_remote_retrieve_body($response), true);

    return rest_ensure_response($body);
}