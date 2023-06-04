import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qual tipo de Frases seu dia merece?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> motivacional = [
    "A persistência é o caminho do êxito.",
    "No meio da dificuldade encontra-se a oportunidade.",
    "Imagine uma nova história para sua vida e acredite nela.",
  ];

  final List<String> aleatorio = [
    "A vida é feita de momentos.",
    "Nunca é tarde demais para ser o que você poderia ter sido.",
    "Não espere por oportunidades, crie-as.",
  ];

  final List<String> depressivo = [
    "Nada faz sentido.",
    "A vida é uma eterna tristeza.",
    "O futuro é sombrio.",
  ];

  final Random random = Random();

  String getMotivationalPhrase() {
    int index = random.nextInt(motivacional.length);
    return motivacional[index];
  }

  String getRandomPhrase() {
    int index = random.nextInt(aleatorio.length);
    return aleatorio[index];
  }

  String getDepressivePhrase() {
    int index = random.nextInt(depressivo.length);
    return depressivo[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qual tipo de Frases seu dia merece?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Esse App é para melhorar seu dia", style: TextStyle(
        fontSize: 40,
        color: Color.fromARGB(255, 238, 0, 0),
      ),),
            ElevatedButton(
              onPressed: () {
                String fraseMotivacional = getMotivationalPhrase();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Frase Motivacional'),
                      content: Text(fraseMotivacional),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Fechar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Frases Motivacionais'),
            ),
            ElevatedButton(
              onPressed: () {
                String fraseAleatoria = getRandomPhrase();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Frase Aleatória'),
                      content: Text(fraseAleatoria),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Fechar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Frases Aleatórias'),
            ),
            ElevatedButton(
              onPressed: () {
                String fraseDepressiva = getDepressivePhrase();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Frase Depressiva'),
                      content: Text(fraseDepressiva),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Fechar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Frases Depressivas'),
            ),
          ],
        ),
      ),
    );
  }
}
