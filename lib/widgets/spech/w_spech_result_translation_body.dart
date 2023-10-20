import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:test_create2/screen/spech/s_spech_translation.dart';

class SpechResultTranslationBody extends StatefulWidget {
  final String translatedText;
  final String lastWords;

  const SpechResultTranslationBody(
      {Key? key, required this.translatedText, required this.lastWords})
      : super(key: key);

  @override
  _SpechResultTranslationBody createState() => _SpechResultTranslationBody();
}

class _SpechResultTranslationBody extends State<SpechResultTranslationBody> {
  bool isStandardFirst = true;
  FlutterTts flutterTts = FlutterTts();

  void togglePosition() {
    setState(() {
      isStandardFirst = !isStandardFirst;
    });
  }

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage("ko-KR"); // 음성 언어 설정
    await flutterTts.setPitch(1.0); // 음성 피치 설정 (기본값)
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    isStandardFirst ? '표준어' : '방언',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            isStandardFirst
                                ? widget.lastWords
                                : widget.translatedText,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      speakText(isStandardFirst
                          ? widget.lastWords
                          : widget.translatedText); // 음성 출력 기능 추가
                    },
                    icon: const Icon(Icons.volume_up),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(height: 40, color: Colors.indigo),
                  ),
                  Text(
                    isStandardFirst ? '방언' : '표준어',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    isStandardFirst
                        ? widget.translatedText
                        : widget.lastWords,
                    style: const TextStyle(fontSize: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      speakText(isStandardFirst
                          ? widget.translatedText
                          : widget.lastWords); // 음성 출력 기능 추가
                    },
                    icon: const Icon(Icons.volume_up),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.mic,
                size: 48,
              ),
              style: IconButton.styleFrom(
                  backgroundColor: Colors.indigo, shape: CircleBorder()),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpechTranslation(),
                    ));
              },
            ),
          ],
        ),
            SizedBox(height: 15,)
      ],
    );

  }
}
