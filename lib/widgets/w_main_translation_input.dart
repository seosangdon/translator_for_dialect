import 'package:flutter/material.dart';
import 'package:test_create2/screen/text/s_text_translation.dart';

class MainTranslationInput extends StatelessWidget {
  final TextEditingController inputController;
  final BuildContext context;

  MainTranslationInput(
      {super.key, required this.inputController, required this.context});

  void _navigateToNewScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TextTranslation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToNewScreen();
      },
      child: Column(
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '텍스트 입력',hintStyle: TextStyle(fontSize: 25)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
