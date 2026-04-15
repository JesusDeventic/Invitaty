import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;

  MusicController._internal() {
    _player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
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
      await _player.play(UrlSource(url));
      isPlaying = true;
    } catch (e) {
      debugPrint("ERROR audio: $e");
      isPlaying = false;
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
      isPlaying = false;
    } catch (e) {
      debugPrint("ERROR pausa: $e");
    }
  }

  void dispose() {
    _player.dispose();
  }

  AudioPlayer get player => _player;
}
