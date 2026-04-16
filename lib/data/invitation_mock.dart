const Map<String, dynamic> invitationMock = {
  "version": 1,
  "id": "inv_1",
  "eventType": "birthday",
  "title": "Cumple de Laura",

  "theme": {
    "primary": "#568525",
    "secondary": "#FFFFFF",
    "font": "Poppins",
    "base": "light",
  },

  "sections": [
    {
      "id": "cover",
      "type": "cover",
      "data": {
        "title": "Cumple de Laura",
        "subtitle": "¡30 años!",
        "font": "Poppins",
        "fontSizeTitle": 28,
        "fontSizeSubtitle": 18,
        "textColor": "#FFFFFF",
        "imageUrl": "",
      },
    },
    {
      "id": "text",
      "type": "text",
      "data": {
        "title": "Te esperamos",
        "body": "Será una noche increíble",
        "font": "Poppins",
        "fontSize": 16,
      },
    },
    {
      "id": "countdown",
      "type": "countdown",
      "data": {
        "title": "Falta para el gran día",
        "eventDateTime": "2026-06-21T18:00:00",
      },
    },
    {
      "id": "music",
      "type": "music",
      "data": {
        "title": "Nuestra canción",
        "url":
            "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3",
      },
    },
    {
      "id": "location",
      "type": "location",
      "data": {
        "name": "Iglesia de San Pablo",
        "address": "Pl. de San Pablo, 4, 47011 Valladolid",
        "mapsUrl": "https://maps.google.com/?q=Iglesia+San+Pablo+Valladolid",
      },
    },
    {
      "id": "agenda",
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
      "id": "gallery",
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
      "id": "video",
      "type": "video",
      "data": {
        "videos": [
          {
            "url": "https://youtu.be/eioYulMp_5k?si=l8rKnN94tam_yj9K",
            "title": "Vídeo del evento",
          },
        ],
      },
    },

    {
      "id": "dress",
      "type": "dressCode",
      "data": {
        "title": "Código de vestimenta",
        "style": "Formal",
        "description": "Se recomienda traje y vestido elegante",
      },
    },
    {
      "id": "gifts",
      "type": "gifts",
      "data": {
        "title": "Regalos",
        "message":
            "Vuestra presencia es el mejor regalo, pero si queréis contribuir:",
        "iban": "ES12 3456 7890 1234 5678",
        "bizum": "123456789",
        "link": "https://throne.com/landing#Top",
        "items": ["Cafetera", "TV", "etc"],
      },
    },
    {
      "id": "rsvp",
      "type": "rsvp",
      "data": {
        "fields": ["name", "email", "attending", "guests", "notes"],
      },
    },
  ],
};
