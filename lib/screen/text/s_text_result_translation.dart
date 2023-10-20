import 'package:flutter/material.dart';
import 'package:test_create2/main.dart';
import 'package:test_create2/widgets/text/w_text_result_translation_body.dart';

class ResultTranslation extends StatelessWidget {
  final String translatedText;
  final String originalText;

  ResultTranslation({
    Key? key,
    required this.translatedText,
    required this.originalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('홈'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          ResultTranslatioBody(
            translatedText: translatedText,
            originalText: originalText,
          ),
        ],
      ),
    );
  }
}
