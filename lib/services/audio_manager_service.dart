import 'package:audioplayers/audioplayers.dart';

class AudioManagerService {
  AudioManagerService._privateConstructor();
  static final AudioManagerService instance = AudioManagerService._privateConstructor();

  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = true;

  Future<void> init() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('music/theme.mp3'),
        volume: 1);
  }

  void toggle() {
    if (isPlaying) {
      _player.pause();
    } else {
      _player.resume();
    }
    isPlaying = !isPlaying;
  }

  void dispose() {
    _player.dispose();
  }
}
