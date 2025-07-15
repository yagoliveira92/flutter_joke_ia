import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/services/gemini_chat_service.dart';
import 'package:myapp/src/services/joke_service.dart';

class JokeViewModel extends ChangeNotifier {
  JokeViewModel() {
    _initialize(); // Chamar o método de inicialização assíncrona
  }

  // Serviços
  final JokeService _jokeService = JokeService();
  final GeminiChatService _chatService = GeminiChatService();

  final TextEditingController jokeController = TextEditingController();
  late GenerativeModel? _generativeModel;
  late ChatSession? _chatSession;

  String? _lastSubmittedJoke;
  String? get lastSubmittedJoke => _lastSubmittedJoke;

  String _responseMessage = '';
  String get responseMessage => _responseMessage;

  bool _isInitializing = true; // Estado de inicialização
  bool get isInitializing => _isInitializing;

  String? _initializationError;
  String? get initializationError => _initializationError;

  bool _loading = false;
  bool get loading => _loading;

  // Método de inicialização assíncrona
  Future<void> _initialize() async {
    try {
      _isInitializing = true;
      _initializationError = null;
      notifyListeners(); // Notificar que a inicialização começou
      _generativeModel = _chatService.initChat();
      _chatSession = _generativeModel!.startChat();
    } catch (e) {
      print("JokeViewModel: Erro durante a inicialização: $e");
      _initializationError = "Erro ao inicializar o chat: $e";
    } finally {
      _isInitializing = false;
      notifyListeners(); // Notificar que a inicialização terminou (com sucesso ou erro)
    }
  }

  Future<void> submitThemeJoke() async {
    if (_isInitializing) {
      _responseMessage = 'Aguarde, o chat está sendo inicializado...';
      notifyListeners();
      return;
    }

    if (_chatSession == null) {
      _responseMessage =
          'Erro: Sessão de chat não inicializada. Verifique se o esquema do BD foi carregado.';
      notifyListeners();
      return;
    }

    final jokeTheme = jokeController.text.trim();

    if (jokeTheme.isNotEmpty) {
      _loading = true;
      notifyListeners();

      try {
        final response = await _jokeService.sendSqlFirebase(
          jokeTheme,
          _chatSession!,
        );
        print(response);

        _responseMessage = response;
        _lastSubmittedJoke = jokeTheme;
        _loading = false;
        jokeController.clear();
      } catch (e) {
        _responseMessage = 'Erro: $e';
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    jokeController.dispose();
    super.dispose();
  }
}
