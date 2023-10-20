import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'package:test_create2/screen/spech/s_spech_result_translation.dart';

class SpechTranslationBody extends StatefulWidget {
  const SpechTranslationBody({super.key});

  @override
  State<SpechTranslationBody> createState() => _SpechTranslationBodyState();
}

class _SpechTranslationBodyState extends State<SpechTranslationBody> {
  String lastWords = '';
  String translatedText = '';
  List<String> recognizedSentences = [];

  Future<void> _sendTextToDjango(String text) async {
    final apiUrl = 'http://20.80.37.21:8000/accounts/text-entry/';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        translatedText = responseData['translated_text'];
      });
    } else {
      print('Failed to send text to Django');
    }
  }

  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
    // 페이지 진입 시 음성 인식 자동 시작
    if (_hasSpeech) {
      startListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                              text: lastWords, style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        onPressed: !_hasSpeech || speech.isListening
                            ? null
                            : startListening,
                        icon: Icon(
                          !_hasSpeech || speech.isListening
                              ? Icons.stop_circle
                              : Icons.play_circle,
                          size: 48,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    recognizedSentences.clear();
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  Future<void> resultListener(SpeechRecognitionResult result) async {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords;
    });

    // 음성 인식 결과를 문장 단위로 처리
    if (result.finalResult) {
      recognizedSentences.add(result.recognizedWords);

      // 서버로 전송할 전체 문장 생성
      String fullText = recognizedSentences.join(' ');

      // 서버로 전송
      await _sendTextToDjango(fullText);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SpechResultTranslation(
            translatedText: translatedText,
            lastWords: lastWords,
          ),
        ),
      );
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }
}
