import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../providers/search_provider.dart';
import '../../../chat/presentation/screens/chat_screen.dart';

class SearchUsersScreen extends StatelessWidget {
  final String userId;
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  SearchUsersScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Get.put(SearchProvider(userId: userId));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 60,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(30),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (e) => searchProvider.filterUsers(e),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Obx(
                () => ListView.builder(
                  itemCount: searchProvider.filterdUsers.length,
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    final user = searchProvider.filterdUsers[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        onTap: () async {
                          String? chatId = await searchProvider.getChatId(
                            userId,
                            user.userId,
                          );

                          Get.to(
                            () => ChatScreen(
                              chatId: chatId ?? "",
                              userId: userId,
                              user2Id: user.userId,
                            ),
                          );
                        },
                        hoverColor: Colors.grey.shade700,
                        title: Text(user.displayName),
                        subtitle: Text(
                          user.status,
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
