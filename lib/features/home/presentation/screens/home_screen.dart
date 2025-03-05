import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:whatsapp/features/chat/presentation/screens/chat_screen.dart';
import 'package:whatsapp/features/search/presentation/screens/search_users_screen.dart';
import '../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  const HomeScreen({super.key, this.userId = "user_3"});

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
              return ListView.builder(
                itemCount: homeProvider.chats.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  final chat = homeProvider.chats[i];
                  final date = homeProvider
                      .reformatMessageDateTime(chat.lastMessageId!.timestamp);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          () => ChatScreen(
                            chatId: chat.chatId,
                            userId: userId,
                            chat: homeProvider.chats[i],
                          ),
                        );
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
                          color: Colors.grey,
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
                                    color: Get.theme.colorScheme.secondary,
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
          Get.to(() => SearchUsersScreen(userId: userId));
        },
        backgroundColor: Get.theme.colorScheme.secondary,
        child: Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
    );
  }
}
