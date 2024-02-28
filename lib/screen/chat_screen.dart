import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  final controller = ScrollController();
  bool _istyping = true;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;

  @override
  void initState() {
    // _listScrollController = ScrollController();
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
    } catch (er) {
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              scrollListToEND();
            });
          },
          child: const Icon(CupertinoIcons.arrow_down_circle),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Image.asset(
          AssetsManager.sourIcon,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.settings,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: controller,
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
              // const SpinKitThreeBounce(color: Colors.black, size: 15.0),
              Material(
                color: cardColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        onSubmitted: (value) {
                          controller.animateTo(
                              controller.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                          setState(() {
                            message = value;
                          });
                          textEditingController.clear();
                          postData(message);
                          addNewMessage(message, 0);
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: "Send Message here",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ).px16(),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.animateTo(
                            controller.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        setState(() {
                          message = textEditingController.text;
                        });
                        textEditingController.clear();
                        postData(message);
                        addNewMessage(message, 0);
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
    controller.animateTo(controller.position.maxScrollExtent,
        duration: const Duration(microseconds: 500), curve: Curves.bounceIn);
  }
}
