// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentora_app/presentation/main_layout/roadmap/models/roadmap.dart';


class ApiService {

  //http://127.0.0.1:8081/generate-roadmap
  // Use your actual backend URL. If running locally, it's typically this:
  // final String _baseUrl = 'http://10.0.2.2:8000'; // Or 'http://localhost:8000'
  final String _baseUrl = 'http://10.0.2.2:8081'; // Or 'http://localhost:8000'

  Future<Roadmap> generateRoadmap(String targetJobRole) async {
    // Ensure it's not a named parameter here if you're calling it positionally
    final url = Uri.parse('$_baseUrl/generate-roadmap');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'target_job_role': targetJobRole}),
      );

      if (response.statusCode == 200) {
        return Roadmap.fromJson(jsonDecode(response.body));
      } else {
        // Handle specific API errors from the backend
        Map<String, dynamic> errorBody = jsonDecode(response.body);
        String detail = errorBody['detail'] ?? 'An unknown error occurred.';
        throw Exception(
          'Failed to generate roadmap: Error code: ${response.statusCode} - $detail',
        );
      }
    } catch (e) {
      // General network or parsing errors
      throw Exception(
        'Network error: Could not connect to the backend server. Please ensure the server is running and accessible. Details: $e',
      );
    }
  }
}
