import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<void> requestSpeechPermissions() async {
    // 권한 상태 확인
    var speechStatus = await Permission.speech.status;
    var micStatus = await Permission.microphone.status;

    if (speechStatus.isDenied || micStatus.isDenied) {
      // 권한이 없으면 요청 (팝업 뜸)
      speechStatus = await Permission.speech.request();
      micStatus = await Permission.microphone.request();
    }

    if (speechStatus.isPermanentlyDenied || micStatus.isPermanentlyDenied) {
      // 사용자가 "영구적으로 거부"하면 설정으로 이동 유도
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    // requestSpeechPermissions();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) {
        print("Error: $error");
        setState(() {
          _isListening = false;
          _text = "Error occurred. Try again!";
        });
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _text = "🎤 Listening...";
      });

      _speech.listen(
        localeId: "ko_KR",
        onResult: (result) {
          setState(() {
            _text = "📝 Recognizing...";
          });

          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              _text = result.recognizedWords.isEmpty
                  ? "No voice detected"
                  : result.recognizedWords;
            });
          });
        },
      );
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
      _text = "✅ Stopped";
    });
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
          height: 130,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: WeveColor.bg.bg2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _text,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
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
