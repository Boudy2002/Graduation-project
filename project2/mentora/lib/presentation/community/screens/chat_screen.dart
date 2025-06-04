import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String chatPath; // e.g. "courses/courseId/chats" or "community_rooms/roomId/chats"
  const ChatScreen({super.key, required this.chatPath});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _chatService = ChatService();
  final _user = FirebaseAuth.instance.currentUser!;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final message = ChatMessage(
      senderId: _user.uid,
      senderName: _user.displayName ?? 'Anonymous',
      text: _controller.text.trim(),
      timestamp: DateTime.now(),
    );
    _chatService.sendMessage(widget.chatPath, message);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.getMessages(widget.chatPath),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (ctx, i) => MessageBubble(
                    message: messages[i],
                    isMe: messages[i].senderId == _user.uid,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Send a message...'),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
