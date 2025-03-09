import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/senior/sound_player/view/soundplayer_widget.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class QuestionBox extends StatelessWidget {
  final String audioUrl;
  final String text;

  const QuestionBox({
    super.key,
    required this.audioUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SoundPlayerWidget(audioUrl: audioUrl),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: WeveText.header3(color: WeveColor.gray.gray1),
          ),
        ),
      ],
    );
  }
}
