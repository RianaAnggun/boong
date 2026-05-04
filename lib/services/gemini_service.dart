import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyDLc6KfjcFpEOkemyR9xje5HMf-aYbDi7Q";

  // ✅ FUNCTION CHAT AI
  static Future<String> ask(
      List<Map<String, String>> history) async {
    try {
      final url = Uri.parse(
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
);

      final text = history.last["text"] ?? "";

      final response = await http.post(
  url,
  headers: {
    "Content-Type": "application/json",
  },
  body: jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": text}
        ]
      }
    ]
  }),
);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        return "Error ${response.statusCode}\n${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  // ✅ FUNCTION CEK MODEL
static Future<String> listModels() async {
  final url = Uri.parse(
    "https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey",
  );

  final res = await http.get(url);

  return "STATUS: ${res.statusCode}\n${res.body}";
}
}