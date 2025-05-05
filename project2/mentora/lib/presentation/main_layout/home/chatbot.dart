import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentora_app/core/colors_manager.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  bool isLiked = false;
  bool isDisliked = false;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

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
            title: Text(AppLocalizations.of(context)!.faq),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text(AppLocalizations.of(context)!.feedback),
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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
          onPressed: _openMenu,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).iconTheme.color),
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
      padding: REdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.blue,
                child: Icon(Icons.chat, color: Colors.white),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.chatbot,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.support_agent,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
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
                  color: isLiked ? ColorsManager.blue : Theme.of(context).iconTheme.color,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.thumbsDown,
                  color: isDisliked ? ColorsManager.blue : Theme.of(context).iconTheme.color,
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
      padding: REdgeInsets.all(16),
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
              padding: REdgeInsets.symmetric(vertical: 4),
              child: Text(
                message['timestamp'],
                style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.grey),
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
      margin: REdgeInsets.symmetric(vertical: 5),
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isBot ? Colors.grey[200] : Color(0xFF1D24CA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: isBot ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, color: Theme.of(context).iconTheme.color),
            onPressed: () {}, // Open emoji picker
          ),
          IconButton(
            icon: Icon(Icons.attach_file, color: Theme.of(context).iconTheme.color),
            onPressed: () async {
              await FilePicker.platform.pickFiles();
            }, // File upload
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              cursorHeight: 30.h,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.write_a_message,
                contentPadding: REdgeInsets.all(6),
              )
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: ColorsManager.blue),
            onPressed: _sendMessage, // Send message
          ),
        ],
      ),
    );
  }
}
