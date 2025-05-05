import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  bool isLiked = false;
  bool isDisliked = false;
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add a default welcome message when the chat screen loads
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add({
        'text': "Hello! How can I help you today?",
        'isUser': false,
        'timestamp': _getFormattedTime(),
      });
    });
  }

  void _toggleLike() {
    setState(() {
      isLiked = true;
      isDisliked = false;
    });
  }

  void _toggleDislike() {
    setState(() {
      isLiked = false;
      isDisliked = true;
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text.trim(),
          'isUser': true,
          'timestamp': _getFormattedTime(),
        });
      });
      _messageController.clear();
    }
  }

  void _openMenu() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('FAQ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onPressed: _openMenu,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.topRight,
            icon: Icon(Icons.minimize, color: Colors.black54),
            onPressed: () {
              Navigator.pop(context);
              // Minimize chat without ending session
            },
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.black54),
            onPressed: () {
              Navigator.pop(context); // Close chat session
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildChatSection()),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF1D24CA),
                child: Icon(Icons.chat, color: Colors.white),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chatbot",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Support Agent",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.thumbsUp,
                  color: isLiked ? Color(0xFF1D24CA) : Colors.grey,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.thumbsDown,
                  color: isDisliked ? Color(0xFF1D24CA) : Colors.grey,
                ),
                onPressed: _toggleDislike,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Column(
          crossAxisAlignment:
          message['isUser']
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // Timestamp above the message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                message['timestamp'],
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
              ),
            ),
            // Chat bubble
            _buildChatBubble(message['text'], isBot: !message['isUser']),
          ],
        );
      },
    );
  }

  Widget _buildChatBubble(String message, {required bool isBot}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isBot ? Colors.grey[200] : Color(0xFF1D24CA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: isBot ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.black54),
            onPressed: () {}, // Open emoji picker
          ),
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.black54),
            onPressed: () async {
              await FilePicker.platform.pickFiles();
            }, // File upload
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Write a message",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Color(0xFF1D24CA)),
            onPressed: _sendMessage, // Send message
          ),
        ],
      ),
    );
  }
}
