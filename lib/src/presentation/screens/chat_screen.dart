import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../providers/chat_provider.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  final String userId;
  ChatScreen({
    super.key,
    required this.chatId,
    this.userId = "user_1",
  });

  final chatProvider = Get.put(ChatProvider());
  @override
  Widget build(BuildContext context) {
    chatProvider.getMessagesStream(chatId).listen((messages) {
      chatProvider.messages.assignAll(messages);
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cormatex",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "last seen today at 2:50 AM",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.videocam_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        leadingWidth: 25,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 70),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Get.theme.colorScheme.secondary.withAlpha(60),
                      BlendMode.modulate)),
            ),
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: chatProvider.messages.length,
                itemBuilder: (_, i) => BubbleSpecialOne(
                  text: chatProvider.messages[i].message,
                  textStyle: TextStyle(color: Colors.white),
                  status: chatProvider.messages[i].senderId == userId
                      ? chatProvider.messages[i].status
                      : "",
                  isSender: chatProvider.messages[i].senderId == userId,
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xff1f272a),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.sticky_note_2,
                              size: 25,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Form(
                                child: TextFormField(
                                  onChanged: (text) {},
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Message",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                  cursorColor: Color(0xff21c063),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.attach_file,
                              size: 25,
                              color: Colors.grey,
                            ),
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add your send message logic here
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff21c063),
                      ),
                      child: Icon(
                        Icons.send,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
