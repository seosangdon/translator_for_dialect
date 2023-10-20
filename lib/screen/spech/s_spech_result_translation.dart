import 'package:flutter/material.dart';
import 'package:test_create2/main.dart';
import 'package:test_create2/widgets/spech/w_spech_result_translation_body.dart';

class SpechResultTranslation extends StatelessWidget {
  final String translatedText;
  final String lastWords;

  const SpechResultTranslation(
      {super.key, required this.translatedText, required this.lastWords});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SpechResultTranslationBody(
        translatedText: translatedText,
        lastWords: lastWords,
      ),
    );
  }
}
