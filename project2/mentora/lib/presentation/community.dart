import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'community/models/chat_message.dart';
import 'community/screens/chat_screen.dart';
import 'community/services/chat_service.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final ChatService _chatService = ChatService();
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _messageController = TextEditingController();
  List<Course> courses = [
    Course('AWS Fundamentals', 'assets/images/aws.png'),
    Course('Cybersecurity Fundamentals', 'assets/images/cybersecurity.png'),
    Course('Software Testing Fundamentals', 'assets/images/ISTQB.png'),
    Course('Cisco Networks Fundamentals', 'assets/images/CCNA.png'),
  ];
  int currentCourseIndex = 0;

  void switchCourse() {
    setState(() {
      currentCourseIndex = (currentCourseIndex + 1) % courses.length;
    });
  }

  void sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      senderId: user.uid,
      senderName: user.displayName ?? 'Anonymous',
      text: _messageController.text.trim(),
      timestamp: DateTime.now(),
    );

    _chatService.sendMessage('community_rooms/general/chats', newMessage);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(courses[currentCourseIndex].image),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          courses[currentCourseIndex].title,
                          style: TextStyle(
                            color: Color(0xFF1D24CA),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF1D24CA),
                          size: 18,
                        ),
                        onPressed: switchCourse,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.getMessages('community_rooms/general/chats'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message.senderId == user.uid;

                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser ? const Color(0xFF1D24CA) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            if (!isUser)
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/profile.png'),
                                    radius: 15,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    message.senderName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 5),
                            Text(
                              message.text,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: () async {
                      await FilePicker.platform.pickFiles();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Chat with your mates!',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Color(0xFF1D24CA)),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Course {
  final String title;
  final String image;
  Course(this.title, this.image);
}

