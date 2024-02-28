import 'package:flutter/material.dart';
import 'package:khmergpt/constants/constant.dart';
import 'package:khmergpt/services/assests_manager.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.msg, required this.chatIndex})
      : super(key: key);

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return
       Padding(
        padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
        child: Column(
          children: [
            Material(
              color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: chatIndex == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Image.asset(
                    chatIndex == 0
                        ? AssetsManager.userImage
                        : AssetsManager.openailogo,
                    height: 30,
                    width: 30,
                  ),
                  Flexible(
                    child: Text(
                      msg,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}

// Column(
// children: [
// Material(
// color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Image.asset(
// chatIndex == 0
// ? AssetsManager.userImage
//     : AssetsManager.openailogo,
// height: 30,
// width: 30,
// ),
// const SizedBox(
// width: 10.0,
// ),
// Expanded(
// child: Text(
// msg,
// style: const TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: 20.0),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// );
