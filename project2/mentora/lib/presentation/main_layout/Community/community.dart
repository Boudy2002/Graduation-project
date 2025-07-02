// community.dart
import 'package:flutter/material.dart';
import '../../community/screens/chats_tab.dart';
import '../../community/screens/communities_tab.dart';
import 'package:mentora_app/core/colors_manager.dart';
class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community'),
          bottom: const TabBar(
            labelColor: ColorsManager.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Chats'),
              Tab(icon: Icon(Icons.public), text: 'Communities'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatsTab(),
            CommunitiesTab(),
          ],
        ),
      ),
    );
  }
}
