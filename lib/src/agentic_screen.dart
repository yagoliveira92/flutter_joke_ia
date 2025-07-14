// Suggested code may be subject to a license. Learn more: ~LicenseLog:3145182086.
import 'package:flutter/material.dart';

class AgenticScreen extends StatefulWidget {
  const AgenticScreen({super.key});

  @override
  State<AgenticScreen> createState() => _AgenticScreenState();
}

class _AgenticScreenState extends State<AgenticScreen> {
  final TextEditingController _textController = TextEditingController();
  // final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    /*
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _generateResponse();
    */
  }

  void _generateResponse() {
    // This is where you would call your AI model to get a response.
    // For now, we'll just add a placeholder response.
    //ChatMessage response = ChatMessage(
    //  text: "This is a placeholder response from the AI.",
    //  isUserMessage: false,
    //);
    /*
    setState(() {
      _messages.insert(0, response);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agentic Application')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/ary_toledo.png', // Replace with your image path
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Bem vindo(a) ao gerador de piada mais esquisito da história!!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => Text("Exemplo"),
              itemCount: 5,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
