import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SoundPlayerButton extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();

    // 재생이 끝났을 때 _isPlaying false로 초기화
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> _togglePlay() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(widget.audioUrl));
      }

      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      debugPrint('오디오 재생 오류: $e');
    }
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
          const SizedBox(width: 20),
          Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              color: WeveColor.main.orange1_30,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              _isPlaying ? "재생 중..." : widget.text,
              style: WeveText.header4(color: WeveColor.main.orange1),
            ),
          )
        ],
      ),
    );
  }
}
