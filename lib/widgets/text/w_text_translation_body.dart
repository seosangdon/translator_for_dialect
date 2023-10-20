import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_create2/screen/text/s_text_result_translation.dart';

class TextTranslationBody extends StatefulWidget {
  final BuildContext context;
  const TextTranslationBody({Key? key, required this.context}) : super(key: key);

  @override
  State<TextTranslationBody> createState() => _TextTranslationBodyState();
}

class _TextTranslationBodyState extends State<TextTranslationBody> {
  String originalText = '';
  String translatedText = '';

  void _GyeolTranslation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultTranslation(translatedText: translatedText, originalText: originalText,),
      ),
    );
  }

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
        originalText = responseData['original_text'];
        translatedText = responseData['translated_text'];
      });
    } else {
      print('Failed to send text to Django');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (translatedText.isEmpty) {
          Navigator.of(context).pop();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      style: TextStyle(fontSize: 25),
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '텍스트 입력',
                      ),
                      onChanged: (text) {
                        _sendTextToDjango(text);
                      },
                    ),
                  ),
                  if (translatedText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Divider(
                            height: 40,
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                    ),
                  if (translatedText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translatedText,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 60),
                  if (translatedText.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _GyeolTranslation();
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                      ),
                      style:
                      IconButton.styleFrom(backgroundColor: Colors.indigo),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}