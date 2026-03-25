const Map<String, dynamic> invitationMock = {
  "version": 1,
  "id": "inv_1",
  "eventType": "birthday",
  "title": "Cumple de Laura",

  "theme": {
    "primary": "#568525",
    "secondary": "FFFFFF",
    "font": "Poppins",
    "base": "light",
  },

  "sections": [
    {
      "id": "cover_1",
      "type": "cover",
      "data": {"title": "Cumple de Laura", "subtitle": "¡30 años!"},
    },
    {
      "id": "text_1",
      "type": "text",
      "data": {"title": "Te esperamos", "body": "Será una noche increíble"},
    },
    {
      "id": "countdown_1",
      "type": "countdown",
      "data": {
        "title": "Falta para el gran día",
        "eventDateTime": "2026-06-21T18:00:00",
      },
    },
    {
      "id": "music_1",
      "type": "music",
      "data": {
        "title": "Nuestra canción",
        "url":
            "https://www.soundjay.com/free-music_c2026/sounds/heart-of-the-sea-01.mp3",
      },
    },
    {
      "id": "location_1",
      "type": "location",
      "data": {
        "name": "Restaurante X",
        "address": "Calle Falsa 123, Madrid",
        "mapsUrl": "https://maps.google.com/?q=Restaurante+X",
      },
    },
    {
      "id": "agenda_1",
      "type": "agenda",
      "data": {
        "title": "Agenda del evento",
        "items": [
          {
            "time": "18:00",
            "title": "Ceremonia",
            "description": "Inicio de la ceremonia",
          },
          {
            "time": "19:30",
            "title": "Cóctel",
            "description": "Aperitivos y bebidas",
          },
          {
            "time": "21:00",
            "title": "Cena",
            "description": "Banquete principal",
          },
        ],
      },
    },

    {
      "id": "gallery_1",
      "type": "gallery",
      "data": {
        "images": [
          "https://picsum.photos/300/200",
          "https://picsum.photos/301/200",
          "https://picsum.photos/302/200",
          "https://picsum.photos/303/200",
        ],
      },
    },
    {
      "id": "video_1",
      "type": "video",
      "data": {
        "videos": [
          {
            "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            "title": "Vídeo del evento",
          },
        ],
      },
    },

    {
      "id": "dress_1",
      "type": "dressCode",
      "data": {
        "title": "Código de vestimenta",
        "style": "Formal",
        "description": "Se recomienda traje y vestido elegante",
      },
    },
    {
      "id": "gifts_1",
      "type": "gifts",
      "data": {
        "title": "Regalos",
        "message":
            "Vuestra presencia es el mejor regalo, pero si queréis contribuir:",
        "iban": "ES12 3456 7890 1234 5678",
        "bizum": "123456789",
        "link": "https://throne.com/landing#Top",
      },
    },
    {
      "id": "rsvp_1",
      "type": "rsvp",
      "data": {
        "fields": ["name", "email", "attending", "guests", "notes"],
      },
    },
  ],
};
