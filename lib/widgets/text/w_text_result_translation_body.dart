import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ResultTranslatioBody extends StatefulWidget {
  final String translatedText;
  final String originalText;

  const ResultTranslatioBody(
      {Key? key, required this.translatedText, required this.originalText})
      : super(key: key);

  @override
  _ResultTranslatioBodyState createState() => _ResultTranslatioBodyState();
}

class _ResultTranslatioBodyState extends State<ResultTranslatioBody> {
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
        Row(
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
                                    ? widget.originalText
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
                              ? widget.originalText
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
                            : widget.originalText,
                        style: const TextStyle(fontSize: 30),
                      ),
                      IconButton(
                        onPressed: () {
                          speakText(isStandardFirst
                              ? widget.translatedText
                              : widget.originalText); // 음성 출력 기능 추가
                        },
                        icon: const Icon(Icons.volume_up),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black54,
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(left: 25),
                icon: const Icon(null),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                value: isStandardFirst ? '표준어' : '방언',
                onChanged: (newValue) {
                  setState(() {
                    isStandardFirst = newValue == '표준어';
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: '표준어',
                    child: Center(child: Text('표준어')),
                  ),
                  DropdownMenuItem<String>(
                    value: '방언',
                    child: Center(child: Text('방언')),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              onPressed: togglePosition,
            ),
            Container(
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black54,
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(left: 25),
                isExpanded: true,
                icon: const Icon(null),
                underline: const SizedBox.shrink(),
                value: isStandardFirst ? '방언' : '표준어',
                onChanged: (newValue) {
                  setState(() {
                    isStandardFirst = newValue == '방언';
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: '방언',
                    child: Center(child: Text('방언')),
                  ),
                  DropdownMenuItem<String>(
                    value: '표준어',
                    child: Center(child: Text('표준어')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
