// Service Worker para notificaciones push de Invitaty

console.log('Invitaty Service Worker cargado');

self.addEventListener('install', (event) => {
  console.log('Service Worker instalado');
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  console.log('Service Worker activado');
  event.waitUntil(clients.claim());
});

self.addEventListener('push', function (event) {
  console.log('Push recibido:', event);

  try {
    const data = event.data.json();
    console.log('Datos de la notificación:', data);

    const options = {
      body: (data.notification && data.notification.body) || 'Nueva notificación',
      icon: '/icons/Icon-192.png',
      badge: '/icons/Icon-192.png',
      vibrate: [200, 100, 200],
      requireInteraction: true,
      silent: false,
      tag: data.fcmMessageId || 'invitaty-default-tag',
      renotify: true,
      actions: [
        {
          action: 'open',
          title: 'Abrir',
        },
      ],
    };

    event.waitUntil(
      self.registration
        .showNotification(
          (data.notification && data.notification.title) || 'Invitaty',
          options,
        )
        .then(() => {
          console.log('Notificación mostrada correctamente');
        })
        .catch((error) => {
          console.error('Error mostrando notificación:', error);
        }),
    );
  } catch (error) {
    console.error('Error procesando notificación push:', error);
  }
});

self.addEventListener('notificationclick', function (event) {
  console.log('Notificación clickeada:', event);

  event.notification.close();

  event.waitUntil(
    clients.matchAll({ type: 'window' }).then(function (clientList) {
      for (let i = 0; i < clientList.length; i++) {
        let client = clientList[i];
        if (client.url.includes('/') && 'focus' in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        return clients.openWindow('/');
      }
    }),
  );
});

