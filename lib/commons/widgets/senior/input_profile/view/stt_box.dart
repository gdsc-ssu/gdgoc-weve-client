import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:weve_client/commons/widgets/senior/button/view/speech_button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SpeechToTextBox extends StatefulWidget {
  const SpeechToTextBox({super.key});

  @override
  State<SpeechToTextBox> createState() => _SpeechToTextBoxState();
}

class _SpeechToTextBoxState extends State<SpeechToTextBox> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking...";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      setState(() {
        _isListening = true;
        _text = "Listening...";
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
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
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: WeveColor.bg.bg2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _text,
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
