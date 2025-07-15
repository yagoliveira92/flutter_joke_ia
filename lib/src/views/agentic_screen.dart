// Suggested code may be subject to a license. Learn more: ~LicenseLog:3145182086.
import 'package:flutter/material.dart';
import 'package:myapp/src/viewmodels/joke_viewmodel.dart';
import 'package:provider/provider.dart';

class AgenticScreen extends StatefulWidget {
  const AgenticScreen({super.key});

  @override
  State<AgenticScreen> createState() => _AgenticScreenState();
}

class _AgenticScreenState extends State<AgenticScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JokeViewModel>(
      builder: (context, jokeViewModel, child) {
        if (jokeViewModel.isInitializing) {
          return Scaffold(
            appBar: AppBar(title: const Text('Aplicação Agêntica')),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Inicializando o chat e comendo o fiofó do curioso..."),
                ],
              ),
            ),
          );
        }
        if (jokeViewModel.initializationError != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('SQL Chat')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Erro na inicialização: ${jokeViewModel.initializationError}\nPor favor, verifique se você fez o upload do arquivo .sql.",
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Agentic Application')),
          bottomSheet: Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: jokeViewModel.jokeController,
                        onSubmitted: (_) => jokeViewModel.submitThemeJoke(),
                        maxLines: 3,
                        decoration: const InputDecoration.collapsed(
                          border: OutlineInputBorder(gapPadding: 10),

                          hintText: 'Escreva o tema da piada',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon:
                            jokeViewModel.loading
                                ? const CircularProgressIndicator()
                                : Icon(Icons.send),
                        onPressed: () => jokeViewModel.submitThemeJoke(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/ary_toledo.png', // Replace with your image path
                      width: 180,
                      height: 180,
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Bem vindo(a) ao gerador de piada mais esquisito da história!!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  child: SelectableText(
                    jokeViewModel.responseMessage,
                    style: TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
