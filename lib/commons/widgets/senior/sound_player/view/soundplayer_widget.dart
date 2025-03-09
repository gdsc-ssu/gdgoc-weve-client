import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';

class SoundPlayerWidget extends StatefulWidget {
  // MP3 파일 경로
  final String audioUrl;

  const SoundPlayerWidget({super.key, required this.audioUrl});

  @override
  State<SoundPlayerWidget> createState() => _SoundPlayerWidgetState();
}

class _SoundPlayerWidgetState extends State<SoundPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(widget.audioUrl));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: WeveColor.main.orange1,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: CustomIcons.getIcon(CustomIcons.seniorAudio, size: 24),
      ),
    );
  }
}
