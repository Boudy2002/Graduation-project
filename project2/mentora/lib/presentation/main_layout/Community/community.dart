import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../community/models/chat_message.dart';
import '../../community/screens/chat_screen.dart';
import '../../community/services/chat_service.dart';
import 'package:intl/intl.dart';

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

  Future<String> fetchSenderName(String uid) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.exists ? userDoc.get('name') ?? 'Unknown' : 'Unknown';
  }

  Future<void> sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    final name = await fetchSenderName(user.uid);
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    final joined = List<String>.from(userDoc.data()?['joined_communities'] ?? []);
    final communityId = currentCommunityId;
    final message = ChatMessage(
      senderId: user.uid,
      senderName: name,
      text: _messageController.text.trim(),
      timestamp: DateTime.now(),
    );

    _chatService.sendMessage('communities/general/chats', message);
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
              stream: _chatService.getMessages('communities/general/chats'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final messages = snapshot.data;

                if (messages == null || messages.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message.senderId == FirebaseAuth.instance.currentUser?.uid;

                    if (isUser) {
                      final time = DateFormat.Hm().format(message.timestamp); // e.g., 14:05

                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D24CA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                message.text,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                time,
                                style: const TextStyle(color: Colors.white70, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(message.senderId)
                            .get(),
                        builder: (context, userSnapshot) {
                          String senderName = '...';
                          if (userSnapshot.hasData && userSnapshot.data!.exists) {
                            senderName = userSnapshot.data!.get('name') ?? 'Unknown';
                          }

                          final time = DateFormat.Hm().format(message.timestamp); // or jm()

                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    senderName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message.text,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    time,
                                    style: const TextStyle(color: Colors.black45, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
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