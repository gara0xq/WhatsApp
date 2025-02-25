import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/src/domain/entities/user.dart';
import 'package:whatsapp/src/presentation/providers/chat_provider.dart';
import 'package:whatsapp/src/presentation/screens/chat_screen.dart';
import '../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  String userId;
  HomeScreen({super.key, this.userId = "user_1"});

  // final chatProvider = Get.put(ChatProvider());

  @override
  Widget build(BuildContext context) {
    final homeProvider = Get.put(HomeProvider(userId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.secondary,
        title: Text('WhatsApp'),
        titleTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 33,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              size: 33,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () {
              return homeProvider.chats.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: homeProvider.chats.length,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        final chat = homeProvider.chats[i];
                        String today =
                            DateFormat('d/M/yy').format(DateTime.now());
                        String yesterday = DateFormat('d/M/yy')
                            .format(DateTime.now().add(Duration(days: -1)));

                        String date = DateFormat('d/M/yy')
                            .format(chat.lastMessageId!.timestamp);
                        date = today == date
                            ? DateFormat('h:mm a')
                                .format(chat.lastMessageId!.timestamp)
                            : date == yesterday
                                ? "Yesterday"
                                : today;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => ChatScreen(
                                    chatId: chat.chatId,
                                    userId: userId,
                                  ));
                            },
                            hoverColor: Colors.grey.shade700,
                            title: Text(chat.user1Id.displayName),
                            subtitle: Text(
                              chat.lastMessageId!.message,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            trailing: Column(
                              children: [
                                Text(date),
                                chat.countUnseenMessages > 0
                                    ? Container(
                                        height: 25,
                                        width: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color:
                                              Get.theme.colorScheme.secondary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "${chat.countUnseenMessages}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeProvider.createChat(
            "6f0bcf0a-ce88-4d38-8b84-c194dbcde48f",
            "user_1",
          );
        },
        backgroundColor: Get.theme.colorScheme.secondary,
        child: Icon(Icons.message),
      ),
    );
  }
}
