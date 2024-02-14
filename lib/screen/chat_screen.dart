import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khmergpt/constants/constant.dart';
import 'package:khmergpt/widgets/chat_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../services/assests_manager.dart';
import 'package:http/http.dart';
import 'package:grouped_list/grouped_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _istyping = true;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void addNewMessage(String message, int chatIndex) {
    setState(() {
      chatMessages.add({
        "msg": message,
        "chatIndex": chatIndex,
      });
      scrollListToEND();
    });
  }

  String message = "";

  final url = "http://localhost:8000/api/message";
  // final url = "http://192.168.1.100:8000/api/message";

  void postData(String Question) async {
    try {
      final response = await post(Uri.parse(url), body: {
        "txtquestion": Question,
      });

      final value = jsonDecode(response.body);
      print(value["answer"]);

      addNewMessage(value["answer"], 1);
    } catch (er) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       scrollListToEND();
      //     });
      //   },
      //   child: new Icon(Icons.expand_circle_down),
      // ),

      appBar: AppBar(
        elevation: 0,
        title: Image.asset(
          AssetsManager.sourIcon,
        ),
        actions: [
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 40.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index]["msg"].toString(),
                    chatIndex: int.parse(
                      chatMessages[index]["chatIndex"].toString(),
                    ),
                  );
                },
              ),
            ),
            if (_istyping) ...[
              const SpinKitThreeBounce(color: Colors.black, size: 15.0),
              Material(
                color: cardColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        onSubmitted: (value) {
                          setState(() {
                            message = value;
                          });
                          postData(message);
                          addNewMessage(message, 0);
                          textEditingController.clear();
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "Send Message here",
                            hintStyle: TextStyle(color: Colors.black)),
                      ).px16(),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          message = textEditingController.text;
                        });
                        postData(message);
                        addNewMessage(message, 0);
                        textEditingController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 2),
        curve: Curves.easeOut);
  }
}
