import 'package:flutter/material.dart';
import 'package:test_create2/widgets/spech/w_spech_translation_body.dart';

class SpechTranslation extends StatelessWidget {
  const SpechTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '홈',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          SpechTranslationBody(),
        ],
      ),
    );
  }
}
