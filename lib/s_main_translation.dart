import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_create2/extension/after_layout.dart';
import 'package:test_create2/extension/flutter_async.dart';
import 'package:test_create2/extension/num_duration_extension.dart';
import 'package:test_create2/screen/spech/s_spech_translation.dart';
import 'package:test_create2/widgets/w_main_translation_input.dart'; // 번역 입력 위젯 임포트

class Translation extends StatefulWidget {
  @override
  _TranslationState createState() => _TranslationState();
}

class _TranslationState extends State<Translation> with AfterLayoutMixin {
  // 번역 입력 필드를 위한 컨트롤러
  final TextEditingController _inputController = TextEditingController();

  Future<void> _showExitDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('앱 종료'),
          content: Text('앱을 종료하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('취소'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
                child: Text('종료'))
          ],
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // 앱 초기화 후 스플래시 화면을 지연 시간 후에 제거
    delay(() {
      FlutterNativeSplash.remove();
    }, 1500.ms);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showExitDialog();
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: MainTranslationInput(
              inputController: _inputController, // 번역 입력 필드 위젯
              context: context,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: IconButton(
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
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
