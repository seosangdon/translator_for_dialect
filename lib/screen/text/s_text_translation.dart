import 'package:flutter/material.dart';
import 'package:test_create2/widgets/text/w_text_translation_body.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          '홈',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: TextTranslationBody(context: context,),
    );
  }
}


