<?php
// ************************** ENDPOINT PARA CONTROLAR LA VERSION Y ESTADO DE FILMANIAK *******************************
// Se llama al iniciar la app y es importantísimo.
// Si queremos desactivar el funcionamiento de la app basta con poner $status = 0;

if (!defined('ABSPATH')) {
    exit;
}

add_action('rest_api_init', 'filmaniak_rest_api_status');

function filmaniak_rest_api_status() {
    register_rest_route('filmaniak/v1', '/status', array(
        'methods'             => 'GET',
        'callback'            => 'filmaniak_get_status',
        'permission_callback' => '__return_true',
    ));
}

function filmaniak_get_status($request) {
    // VARIABLES MODIFICABLES
    $status = 1; // MANTENIMIENTO: 1 activado / 0 desactivado
    $version = "1.0.0"; // Si no coincide la versión de la app con esta, en Flutter decides si obligas a actualizar

    $response = array(
        'version' => $version,
        'status'  => $status,
    );

    return rest_ensure_response($response);
}