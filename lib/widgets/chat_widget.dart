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
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.openailogo,
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    msg,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
