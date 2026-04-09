<?php
// Verificar que el usuario esté logueado y sea administrador
if (!is_user_logged_in() || !current_user_can('administrator')) {
    echo '<p style="color:red; padding:20px; border:1px solid #fcc; background:#fee; border-radius:4px; max-width:600px; margin:30px auto;">Acceso restringido. Debes iniciar sesión como administrador para ver esta página.</p>';
    return;
}

$message_output = '';
$title = '';
$body = '';
$username = '';
$topic = '';
$debug_tokens = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = sanitize_text_field($_POST['fcm_title'] ?? '');
    $body = sanitize_text_field($_POST['fcm_body'] ?? '');
    $username = sanitize_user($_POST['fcm_user'] ?? '');
    $topic = sanitize_text_field($_POST['fcm_topic'] ?? '');

    if (!$title || !$body) {
        $message_output = '<p style="color:red;">❗ Debes rellenar título y contenido.</p>';
    } elseif (empty($topic) && empty($username)) {
        $message_output = '<p style="color:red;">❗ Debes rellenar "topic" o "username".</p>';
    } else {
        if (!empty($topic)) {
            // Enviar a topic (HTTP v1)
            $result = invitaty_send_push_to_topic($topic, $title, $body);
            if (is_wp_error($result)) {
                $message_output = '<p style="color:red;">❌ Error enviando a topic <code>' . esc_html($topic) . '</code>: ' . esc_html($result->get_error_message()) . '</p>';
            } else {
                $message_output = '<p style="color:green;">✅ Notificación enviada al topic <code>' . esc_html($topic) . '</code>.</p>';
            }
        } else {
            // Buscar usuario por username y enviar individual
            $user = get_user_by('login', $username);
            if (!$user) {
                $message_output = '<p style="color:red;">❌ Usuario no encontrado: ' . esc_html($username) . '</p>';
            } else {
                // Admin tool: siempre crea notificación + manda push.
                $result = invitaty_notify_user((int)$user->ID, $title, $body, true);

                $push = $result['push'] ?? [];
                $sent = (int)($push['sent'] ?? 0);
                $failed = (int)($push['failed'] ?? 0);

                $message_output = '<p style="color:green;">✅ Notificación creada y enviada. Enviadas: ' . esc_html((string)$sent) . ' — Fallidas: ' . esc_html((string)$failed) . '</p>';

                if (!empty($push['results']) && is_array($push['results'])) {
                    $message_output .= '<p><strong>Detalle:</strong><br>';
                    foreach ($push['results'] as $row) {
                        $token_short = isset($row['token']) ? substr($row['token'], 0, 20) . '…' : '';
                        if (!empty($row['success'])) {
                            $message_output .= '<span style="color:green;">✔</span> ' . esc_html($token_short) . '<br>';
                        } else {
                            $err = isset($row['error']) ? (string)$row['error'] : 'Error desconocido';
                            $message_output .= '<span style="color:red;">✖</span> ' . esc_html($token_short) . ' — ' . esc_html($err) . '<br>';
                        }
                    }
                    $message_output .= '</p>';
                }
            }
        }
    }
}
?>

    <style>
        * {
            box-sizing: border-box;
        }
        .invitaty-push-wrapper {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            max-width: 600px;
            margin: 30px auto;
        }
        .invitaty-push-container {
            /* sin fondo ni sombra para integrarse con el theme */
        }
        h3 {
            margin: 0 0 16px 0;
            color: #000000;
            font-size: 20px;
            font-weight: 600;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #000000;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
        }
        textarea {
            height: 80px;
            resize: vertical;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
        code {
            display: block;
            margin: 5px 0;
            padding: 5px;
            background-color: rgba(0,0,0,0.05);
            border-radius: 3px;
            font-family: monospace;
            font-size: 12px;
            word-break: break-all;
        }
        .api-config {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #000000;
            border-radius: 4px;
            border: 1px solid #000000;
        }
        .api-config label {
            display: inline-block;
            width: 120px;
        }
        .api-config input {
            width: calc(100% - 130px);
            margin-bottom: 10px;
        }
        .warning {
            background-color: #000000;
            border: 1px solid #ffc107;
            color: #856404;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>

    <div class="invitaty-push-wrapper">
        <div class="invitaty-push-container">
            <h3>Enviar Notificación Push (Invitaty, HTTP v1)</h3>

            <form method="post" id="notificationForm">
                <label for="fcm_topic">Topic (por ejemplo: es / en) - vacío para enviar a un usuario:</label>
                <input type="text" name="fcm_topic" id="fcm_topic" value="<?php echo esc_attr($topic); ?>">

                <label for="fcm_title">Título:</label>
                <input type="text" name="fcm_title" id="fcm_title" value="<?php echo esc_attr($title); ?>" required>

                <label for="fcm_body">Contenido:</label>
                <textarea name="fcm_body" id="fcm_body" required><?php echo esc_textarea($body); ?></textarea>

                <label for="fcm_user" id="fcm_user_label">Username (usuario destino, si no usas topic):</label>
                <input type="text" name="fcm_user" id="fcm_user" value="<?php echo esc_attr($username); ?>">

                <button type="submit">Enviar</button>
            </form>

            <?php
            if ($debug_tokens) {
                echo $debug_tokens;
            }
            if ($message_output) {
                echo '<div style="margin-top:20px;">' . $message_output . '</div>';
            }
            ?>
        </div>
    </div>

    <script>
        // Ocultar/mostrar campo username según si hay topic
        (function() {
            const topicInput = document.getElementById('fcm_topic');
            const userInput = document.getElementById('fcm_user');
            const userLabel = document.getElementById('fcm_user_label');

            function toggleUserField() {
                const isTopic = topicInput.value.trim() !== '';
                userInput.style.display = isTopic ? 'none' : 'block';
                userLabel.style.display = isTopic ? 'none' : 'block';
            }

            topicInput.addEventListener('input', toggleUserField);
            toggleUserField();
        })();
    </script>