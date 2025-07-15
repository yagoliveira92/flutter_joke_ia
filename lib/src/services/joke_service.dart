import 'package:firebase_ai/firebase_ai.dart';

class JokeService {
  Future<String> sendSqlFirebase(String jokeTheme, ChatSession session) async {
    final prompt = Content.multi([
      TextPart('Este é o tema da piada: $jokeTheme'),
    ]);
    final response = await session.sendMessage(prompt);
    if (response.candidates.isNotEmpty) {
      return response.text ?? '';
    }
    throw Exception('No function calls found in the response.');
  }
}
