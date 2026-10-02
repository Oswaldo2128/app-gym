import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundService {
  SoundService._();

  static final SoundService instance = SoundService._();

  /// Disable in unit tests to avoid platform channel setup.
  static bool enabled = true;

  AudioPlayer? _player;

  Future<void> playStart() => _play('sounds/start.wav');
  Future<void> playRestDone() => _play('sounds/rest_done.wav');
  Future<void> playComplete() => _play('sounds/complete.wav');

  Future<void> _play(String asset) async {
    if (!enabled) return;
    try {
      final player = _player ??= AudioPlayer();
      await player.stop();
      await player.play(AssetSource(asset));
    } catch (error, stack) {
      debugPrint('SoundService failed to play $asset: $error\n$stack');
    }
  }

  Future<void> dispose() async {
    await _player?.dispose();
    _player = null;
  }
}
