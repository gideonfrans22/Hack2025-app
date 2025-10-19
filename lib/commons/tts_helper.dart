import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _isInitialized = true;
  }

  static Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  static Future<void> stop() async {
    await _flutterTts.stop();
  }

  static Future<void> pause() async {
    await _flutterTts.pause();
  }

  static Future<void> setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }

  static Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  static Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  static Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }
}
