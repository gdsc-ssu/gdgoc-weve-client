import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SoundPlayerButton extends StatefulWidget {
  // MP3 파일 경로
  final String audioUrl;
  final String text;

  const SoundPlayerButton({
    super.key,
    required this.audioUrl,
    required this.text,
  });

  @override
  State<SoundPlayerButton> createState() => _SoundPlayerButtonState();
}

class _SoundPlayerButtonState extends State<SoundPlayerButton> {
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: WeveColor.main.orange1,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CustomIcons.getIcon(CustomIcons.seniorAudio, size: 24),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              color: WeveColor.main.orange1_30,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(widget.text,
                style: WeveText.header4(color: WeveColor.main.orange1)),
          )
        ],
      ),
    );
  }
}
