import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextController extends StateNotifier<String> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  SpeechToTextController() : super('');

  void setText(String newText) {
    state = newText;
  }

  void reset() {
    state = '';
  }

  Future<void> stopSpeech() async {
    if (_speech.isListening) {
      await _speech.stop();
      await _speech.cancel();
    }
    state = '';
  }

  stt.SpeechToText get speech => _speech;
}
