import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;

  MusicController._internal() {
    // 🔥 Escuchar estado real del player
    _player.playerStateStream.listen((state) {
      isPlaying = state.playing;
    });
  }

  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;

  Future<void> play(String? url) async {
    if (url == null || url.isEmpty) {
      debugPrint("URL vacía");
      return;
    }

    try {
      await _player.stop();

      // 🔥 IMPORTANTE: validar URL
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasAbsolutePath) {
        throw Exception("URL inválida");
      }

      await _player.setUrl(url);

      await _player.play();
    } catch (e) {
      debugPrint("ERROR audio: $e");
      isPlaying = false;
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint("ERROR pausa: $e");
    }
  }

  void dispose() {
    _player.dispose();
  }

  AudioPlayer get player => _player;
}
