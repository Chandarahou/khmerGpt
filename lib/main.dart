import 'package:flutter/material.dart';
import 'package:khmergpt/screen/chat_screen.dart';
import 'splash_screen.dart';

import 'constants/constant.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: scaffoldBackgroundColor,
          )),
      home: const splashScreen(),
    );
  }
}
