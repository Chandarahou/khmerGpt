import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khmergpt/screen/chat_screen.dart';
import 'package:khmergpt/services/assests_manager.dart';
import 'package:khmergpt/widgets/chat_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (ctx) => const ChatScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4c917),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset(
              AssetsManager.sourLogo,
              width: 300.0,
              height: 300.0,
            )),
            const SpinKitSquareCircle(color: Colors.blue, size: 30.0),
          ],
        ),
      ),
    );
  }
}
