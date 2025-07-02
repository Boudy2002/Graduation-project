// lib/chat_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String _apiKey = 'AIzaSyBEjvo9XoEWhLJHj0OWpeG1ygeRsi09pBc';
  final String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  /// Sends a prompt to the Gemini API and returns the AI's response.
  Future<String> getGeminiResponse(String userMessage) async {
    final url = Uri.parse('$_baseUrl?key=$_apiKey');

    final Map<String, dynamic> body = {
      "contents": [
        {
          "parts": [
            {
              "text":
              "You are an AI learning assistant in a Learning Experience Platform (LXP). "
                  "Support users by explaining concepts clearly, answering questions, and promoting curiosity.\n\n"
                  "User: $userMessage",
            },
          ],
        },
      ],
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['candidates']?[0]['content'];
        final parts = content?['parts'];
        return parts?[0]['text'] ?? "⚠️ No response text found.";
      } else {
        print("Gemini API error: ${response.statusCode} ${response.body}");
        return "❌ Gemini API error: ${response.statusCode}";
      }
    } catch (e) {
      print("Exception: $e");
      return "❌ Connection error: $e";
    }
  }
}
