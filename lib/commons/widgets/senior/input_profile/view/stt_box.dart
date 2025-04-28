import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:weve_client/commons/widgets/senior/button/view/speech_button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/provider/speech_to_text_provider.dart';

class SpeechToTextBox extends ConsumerStatefulWidget {
  final StateNotifierProvider<SpeechToTextController, String>
      speechTextProvider;

  const SpeechToTextBox({super.key, required this.speechTextProvider});

  @override
  ConsumerState<SpeechToTextBox> createState() => _SpeechToTextBoxState();
}

class _SpeechToTextBoxState extends ConsumerState<SpeechToTextBox> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _speech.stop();
    _speech.cancel();
    ref.read(widget.speechTextProvider.notifier).reset();
    super.dispose();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) {
        print("Error: $error");
        setState(() {
          _isListening = false;
        });
        ref
            .read(widget.speechTextProvider.notifier)
            .setText("Error occurred. Try again!");
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
      });
      ref.read(widget.speechTextProvider.notifier).setText("🎤 Listening...");

      _speech.listen(
        localeId: "ko_KR",
        onResult: (result) {
          ref
              .read(widget.speechTextProvider.notifier)
              .setText("📝 Recognizing...");
          Future.delayed(Duration(milliseconds: 500), () {
            ref.read(widget.speechTextProvider.notifier).setText(
                result.recognizedWords.isEmpty
                    ? "No voice detected"
                    : result.recognizedWords);
          });
        },
      );
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
    ref.read(widget.speechTextProvider.notifier).setText("✅ Stopped");
  }

  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(widget.speechTextProvider);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 130,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: WeveColor.bg.bg2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: WeveText.header4(color: WeveColor.gray.gray1),
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset(
            'assets/animations/audio_wave.json',
            repeat: true,
            animate: true,
          ),
        ),
        SizedBox(height: 20),
        SpeechButton(
          onTap: _toggleListening,
          isListening: _isListening,
        ),
      ],
    );
  }
}
