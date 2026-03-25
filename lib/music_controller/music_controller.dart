import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;

  MusicController._internal();

  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  Future<void> play(String? url) async {
    if (url == null || url.isEmpty) {
      debugPrint("URL de audio vacía");
      return;
    }

    try {
      await _player.stop();

      await _player.setUrl(url); // aquí suele petar en Windows

      await _player.play();

      isPlaying = true;
    } catch (e) {
      debugPrint("ERROR reproduciendo audio: $e");
      isPlaying = false;
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
      isPlaying = false;
    } catch (e) {
      debugPrint("ERROR pausando audio: $e");
    }
  }

  void dispose() {
    _player.dispose();
  }

  AudioPlayer get player => _player;
}
