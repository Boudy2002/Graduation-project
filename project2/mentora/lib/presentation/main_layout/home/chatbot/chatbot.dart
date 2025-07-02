// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:mentora_app/core/colors_manager.dart';
//
// class Chatbot extends StatefulWidget {
//   const Chatbot({super.key});
//
//
//   @override
//   ChatbotScreenState createState() => ChatbotScreenState();
// }
//
// class ChatbotScreenState extends State<Chatbot> {
//   bool isLiked = false;
//   bool isDisliked = false;
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   bool _isLoading = false; // To show a loading indicator for bot response
//   final ScrollController _scrollController =
//   ScrollController(); // To auto-scroll
//
//   // !! IMPORTANT: CHOOSE THE CORRECT OLLAMA ADDRESS !!
//   // For Android Emulator, use 'http://10.0.2.2:11434/api/chat'
//   // For iOS Simulator or if Flutter is running on the same machine as Ollama, use 'http://localhost:11434/api/chat'
//   //final String _ollamaApiUrl = 'http://localhost:11434/api/chat';
//   final String _ollamaApiUrl = 'http://10.0.2.2:11434/api/chat';
//
//   @override
//   void initState() {
//     super.initState();
//     _addWelcomeMessage();
//   }
//
//   void _scrollToBottom() {
//     // Scroll to the bottom after a short delay to allow the UI to update
//     if (_scrollController.hasClients) {
//       Future.delayed(Duration(milliseconds: 100), () {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       });
//     }
//   }
//
//   void _addWelcomeMessage() {
//     setState(() {
//       _messages.add({
//         'text': "Hello! How can I help you today?",
//         'isUser': false,
//         'timestamp': _getFormattedTime(),
//       });
//     });
//   }
//
//   Future<void> _queryOllama() async {
//     setState(() {
//       _isLoading = true;
//     });
//     _scrollToBottom(); // Scroll down to show loading indicator if needed
//
//     // Prepare the messages for Ollama API
//     // Ollama expects a list of all previous messages for context
//     List<Map<String, String>> ollamaMessages = _messages
//         .where(
//           (msg) => msg['text'] != null && msg['text'] is String,
//     ) // Ensure text exists and is a String
//         .map((msg) {
//       return {
//         "role": msg['isUser'] == true
//             ? "user"
//             : "assistant", // Ensure 'isUser' resolves to a boolean
//         "content":
//         msg['text']
//         as String, // Cast to String, now safe due to .where()
//       };
//     })
//         .toList();
//
//     final requestBody = {
//       "model": "llama3.2", // Or your chosen model, e.g., "llama2", "mistral"
//       "messages": ollamaMessages,
//       "stream": false, // Get the full response at once
//     };
//
//     try {
//       final response = await http
//           .post(
//         Uri.parse(_ollamaApiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(requestBody),
//       )
//           .timeout(const Duration(seconds: 120)); // Added timeout
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(
//           utf8.decode(response.bodyBytes),
//         ); // Ensure UTF-8 decoding
//         final botResponse = responseData['message']?['content'];
//
//         if (botResponse != null) {
//           setState(() {
//             _messages.add({
//               'text': botResponse.trim(),
//               'isUser': false,
//               'timestamp': _getFormattedTime(),
//             });
//           });
//         } else {
//           throw Exception("Failed to parse bot response or content is null.");
//         }
//       } else {
//         final errorBody = utf8.decode(response.bodyBytes);
//         print("Error from Ollama: ${response.statusCode}");
//         print("Response body: $errorBody");
//         setState(() {
//           _messages.add({
//             'text':
//             "Sorry, I couldn't connect to the AI. (Status: ${response.statusCode})",
//             'isUser': false,
//             'timestamp': _getFormattedTime(),
//           });
//         });
//       }
//     } catch (e) {
//       print("Exception when calling Ollama: $e");
//       setState(() {
//         _messages.add({
//           'text': "Error: $e",
//           'isUser': false,
//           'timestamp': _getFormattedTime(),
//         });
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//       _scrollToBottom();
//     }
//   }
//
//   void _toggleLike() {
//     setState(() {
//       isLiked = true;
//       isDisliked = false;
//       //  send this feedback somewhere
//     });
//   }
//
//   void _toggleDislike() {
//     setState(() {
//       isLiked = false;
//       isDisliked = true;
//       //  send this feedback somewhere
//     });
//   }
//
//   void _sendMessage() {
//     if (_messageController.text.trim().isNotEmpty) {
//       final userMessageText = _messageController.text.trim();
//       setState(() {
//         _messages.add({
//           'text': userMessageText,
//           'isUser': true,
//           'timestamp': _getFormattedTime(),
//         });
//       });
//       _messageController.clear();
//       _scrollToBottom();
//
//       // Call Ollama to get the bot's response
//       _queryOllama();
//     }
//   }
//
//   void _openMenu() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.help_outline),
//             title: Text('FAQ'),
//             onTap: () {
//               Navigator.pop(context);
//               // Implement FAQ navigation or display
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.feedback),
//             title: Text('Feedback'),
//             onTap: () {
//               Navigator.pop(context);
//               // Implement Feedback navigation or display
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getFormattedTime() {
//     final now = DateTime.now();
//     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         // backgroundColor: Colors.white,
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
//           onPressed: _openMenu,
//         ),
//         title: _buildHeaderTitle(),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             padding: EdgeInsets.zero,
//             alignment: Alignment.center,
//             icon: Icon(Icons.minimize, color: Theme.of(context).iconTheme.color, size: 20),
//             onPressed: () {
//               // Minimize the chat screen, typically this would be a custom action
//               if (Navigator.canPop(context)) {
//                 Navigator.pop(context);
//               }
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.close, color: Theme.of(context).iconTheme.color),
//             onPressed: () {
//               if (Navigator.canPop(context)) {
//                 Navigator.pop(context); // Close chat screen
//               }
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildChatSection()),
//           if (_isLoading)
//             Padding(
//               padding: REdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 16.0,
//               ),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 20.w,
//                     height: 20.h,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     "Bot is thinking...",
//                     style: Theme.of(context).textTheme.displaySmall
//                   ),
//                 ],
//               ),
//             ),
//           _buildInputSection(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeaderTitle() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CircleAvatar(
//           backgroundColor: ColorsManager.blue,
//           radius: 18,
//           child: Icon(Icons.chat, color: Colors.white, size: 20),
//         ),
//         SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Chatbot",
//               style: Theme.of(context).textTheme.bodySmall
//             ),
//             Text(
//               "Online", // Or "Support Agent"
//               style: GoogleFonts.poppins(fontSize: 12, color: Colors.green),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildChatSection() {
//     return ListView.builder(
//       controller: _scrollController,
//       padding: REdgeInsets.all(16),
//       itemCount: _messages.length,
//       itemBuilder: (context, index) {
//         final message = _messages[index];
//         final bool isUserMessage = message['isUser'];
//         return Column(
//           crossAxisAlignment: isUserMessage
//               ? CrossAxisAlignment.end
//               : CrossAxisAlignment.start,
//           children: [
//             // Timestamp above the message
//             Padding(
//               padding: REdgeInsets.only(
//                 top: 8,
//                 bottom: 2,
//                 left: 8,
//                 right: 8,
//               ),
//               child: Text(
//                 message['timestamp'],
//                 style:Theme.of(context).textTheme.displaySmall
//               ),
//             ),
//             // Chat bubble
//             _buildChatBubble(message['text'], isBot: !isUserMessage),
//             if (!isUserMessage && index == _messages.length - 1)
//               _buildFeedbackButtons(),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildFeedbackButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         SizedBox(width: 10.w),
//         IconButton(
//           icon: Icon(
//             FontAwesomeIcons.thumbsUp,
//             color: isLiked ? ColorsManager.blue : Theme.of(context).iconTheme.color,
//             size: 16,
//           ),
//           onPressed: _toggleLike,
//         ),
//         IconButton(
//           icon: Icon(
//             FontAwesomeIcons.thumbsDown,
//             color: isDisliked ? ColorsManager.blue : Theme.of(context).iconTheme.color,
//             size: 16,
//           ),
//           onPressed: _toggleDislike,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildChatBubble(String message, {required bool isBot}) {
//     return Align(
//       alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         margin: REdgeInsets.symmetric(vertical: 4),
//         padding: REdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           color: isBot ? Colors.grey[200] : Color(0xFF1D24CA),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.r),
//             topRight: Radius.circular(16.r),
//             bottomLeft: isBot ? Radius.circular(4.r) : Radius.circular(16.r),
//             bottomRight: isBot ? Radius.circular(16.r) : Radius.circular(4.r),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 2,
//               offset: Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Text(
//           message,
//           style: GoogleFonts.poppins(
//             fontSize: 14.sp,
//             color: isBot ? Colors.black87 : Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputSection() {
//     return Container(
//       padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Colors.grey.shade300)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 0,
//             blurRadius: 10,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.emoji_emotions_outlined, color: Theme.of(context).iconTheme.color),
//             onPressed: () {
//               // TODO: Implement emoji picker
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Emoji picker not implemented yet.")),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.attach_file, color: Theme.of(context).iconTheme.color),
//             onPressed: () async {
//               // TODO: Implement file picking and handling
//               // For now, it just picks a file but doesn't send it or use it.
//               // Sending files to Ollama requires a multimodal model and different API handling.
//               try {
//                 FilePickerResult? result = await FilePicker.platform
//                     .pickFiles();
//                 if (result != null) {
//                   PlatformFile file = result.files.first;
//                   print("Picked file: ${file.name}");
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         "Picked file: ${file.name}. Sending not implemented.",
//                       ),
//                     ),
//                   );
//                 } else {
//                   // User canceled the picker
//                 }
//               } catch (e) {
//                 print("Error picking file: $e");
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text("Could not pick file.")));
//               }
//             },
//           ),
//           Expanded(
//             child: Container(
//               padding: REdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: TextField(
//                 controller: _messageController,
//                 decoration: InputDecoration(
//                   hintText: "Write a message...",
//                   border: InputBorder.none,
//                   hintStyle: GoogleFonts.poppins(fontSize: 14.sp),
//                 ),
//                 onSubmitted: (_) => _sendMessage(), // Send on keyboard submit
//                 textCapitalization: TextCapitalization.sentences,
//               ),
//             ),
//           ),
//           SizedBox(width: 8.w),
//           IconButton(
//             icon: Icon(Icons.send, color: Color(0xFF1D24CA)),
//             onPressed: _isLoading
//                 ? null
//                 : _sendMessage, // Disable send button while loading
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

// lib/chatbot_screen.dart
// This chatbot is powered by Google Gemini 2.0

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/presentation/main_layout/home/chatbot/chatbot_service.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  bool _isTyping = false;
  bool isLiked = false;
  bool isDisliked = false;

  final ChatService _chatService = ChatService();
  final Color primaryBlue = const Color(0xFF1D24CA);

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add({
      'text':
      "👋 Hi! I'm your learning assistant. Ask me anything about your courses, concepts, or how to learn better!",
      'isUser': false,
      'timestamp': _formattedTime(),
    });
  }

  String _formattedTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'isUser': true,
        'timestamp': _formattedTime(),
      });
      _isTyping = true;
      _messageController.clear();
    });

    _scrollToBottom();

    final botReply = await _chatService.getGeminiResponse(text);

    setState(() {
      _messages.add({
        'text': botReply,
        'isUser': false,
        'timestamp': _formattedTime(),
      });
      _isTyping = false;
    });

    _scrollToBottom();
  }

  void _toggleLike() => setState(() {
    isLiked = true;
    isDisliked = false;
  });

  void _toggleDislike() => setState(() {
    isLiked = false;
    isDisliked = true;
  });

  Widget _buildChatBubble(String message, {required bool isBot}) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isBot ? Colors.white : primaryBlue,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isBot
                ? const Radius.circular(4)
                : const Radius.circular(16),
            bottomRight: isBot
                ? const Radius.circular(16)
                : const Radius.circular(4),
          ),
          border: isBot ? Border.all(color: Colors.grey.shade300) : null,
        ),
        child: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isBot ? Colors.black87 : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildChatSection() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isTyping && index == _messages.length) {
          return Row(
            children: const [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 10),
              Text("Thinking..."),
            ],
          );
        }

        final msg = _messages[index];
        return Column(
          crossAxisAlignment: msg['isUser']
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                msg['timestamp'],
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            _buildChatBubble(msg['text'], isBot: !msg['isUser']),
            if (!msg['isUser'] && index == _messages.length - 1)
              _buildFeedbackButtons(),
          ],
        );
      },
    );
  }

  Widget _buildFeedbackButtons() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            FontAwesomeIcons.thumbsUp,
            color: isLiked ? primaryBlue : Colors.grey,
            size: 16,
          ),
          onPressed: _toggleLike,
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.thumbsDown,
            color: isDisliked ? primaryBlue : Colors.grey,
            size: 16,
          ),
          onPressed: _toggleDislike,
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Emoji picker not implemented.")),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles();
              if (result != null) {
                final file = result.files.first;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Picked file: ${file.name} (not yet used)"),
                  ),
                );
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorsManager.black
              ),
              decoration: InputDecoration(
                hintText: "Write a message...",
                // hintStyle: GoogleFonts.poppins(fontSize: 14),
                border: Theme.of(context).inputDecorationTheme.border
              ),
              onSubmitted: (_) => _sendMessage(),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: primaryBlue,
            onPressed: _isTyping ? null : _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set entire screen white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                ListTile(leading: Icon(Icons.help_outline), title: Text("FAQ")),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text("Feedback"),
                ),
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryBlue,
              child: const Icon(Icons.school, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Learning Assistant",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
                Text(
                  "Powered by Gemini 2.0",
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.minimize, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildChatSection()),
          _buildInputSection(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
