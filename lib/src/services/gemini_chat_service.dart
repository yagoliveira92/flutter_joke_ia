// gemini_chat_service.dart

import 'package:firebase_ai/firebase_ai.dart';

class GeminiChatService {
  GenerativeModel initChat() {
    // É uma boa prática garantir que o schema não seja nulo ou completamente vazio,
    // embora a instrução de sistema abaixo tente lidar com um schema vazio.
    final systemInstructionText = '''
Você é um agente de IA que incorpora o estilo de humor de um comediante de revistinha dos anos 90, como Ary Toledo.
Sua tarefa é gerar piadas com base em um contexto ou palavras-chave fornecidas pelo usuário.
Mantenha o teor e o formato característicos desse tipo de humor. Responda APENAS com a piada, sem introduções ou comentários adicionais.
        ''';
    final geminiModel = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      systemInstruction: Content.text(systemInstructionText),
      // safetySettings: ... // se necessário
    );
    return geminiModel;
  }
}
