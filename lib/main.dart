import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_create2/s_main_translation.dart';

import 'package:flutter/services.dart';
void main() {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.dark()),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Center(
            child: const Text('사투리 번역기'),
          ),
        ),
        body: Translation(),
      ),
    );
  }
}

