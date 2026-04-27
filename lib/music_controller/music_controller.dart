import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// 🎧 CONTROLADOR GLOBAL DE AUDIO
///
/// ✔ Singleton global
/// ✔ Controla reproducción única
/// ✔ Preparado para backend (streams / mp3 / signed URLs)
/// ✔ UI reactiva con ValueNotifier (MEJORA CLAVE)
class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;

  MusicController._internal() {
    /// 🔁 Escucha estado del player
    _player.onPlayerStateChanged.listen((state) {
      _isPlaying.value = state == PlayerState.playing;
    });
  }

  /// 🎵 Reproductor base
  final AudioPlayer _player = AudioPlayer();

  /// ⚡ MEJORA IMPORTANTE:
  /// UI reactiva sin setState manual
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);

  /// 📡 Exponer estado reactivo
  ValueListenable<bool> get isPlayingListenable => _isPlaying;

  /// 🟡 getter legacy (compatibilidad)
  bool get isPlaying => _isPlaying.value;

  /// ▶️ PLAY AUDIO
  Future<void> play(String? url) async {
    if (url == null || url.isEmpty) {
      debugPrint("URL vacía");
      return;
    }

    try {
      await _player.stop();

      /// 🌐 streaming URL (MVP ahora, backend después)
      await _player.play(UrlSource(url));

      _isPlaying.value = true;
    } catch (e) {
      debugPrint("ERROR audio: $e");
      _isPlaying.value = false;
    }
  }

  /// ⏸ PAUSE
  Future<void> pause() async {
    try {
      await _player.pause();
      _isPlaying.value = false;
    } catch (e) {
      debugPrint("ERROR pausa: $e");
    }
  }

  /// ⏹ STOP (🆕 útil para cambiar de módulo o cerrar pantalla)
  Future<void> stop() async {
    try {
      await _player.stop();
      _isPlaying.value = false;
    } catch (e) {
      debugPrint("ERROR stop: $e");
    }
  }

  /// 🧹 DISPOSE
  /// ⚠️ normalmente NO se usa por ser singleton
  void dispose() {
    _player.dispose();
    _isPlaying.dispose();
  }

  /// 🔓 acceso directo (debug)
  AudioPlayer get player => _player;
}
