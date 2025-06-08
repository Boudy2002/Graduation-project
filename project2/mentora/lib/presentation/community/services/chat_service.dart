import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatMessage>> getMessages(String chatPath) {
    return _firestore.collection(chatPath)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList()
    );
  }

  Future<void> sendMessage(String chatPath, ChatMessage message) async {
    print("Writing to: $chatPath"); // DEBUG
    await _firestore.collection(chatPath).add(message.toMap());
  }

}
