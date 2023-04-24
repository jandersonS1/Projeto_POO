import 'package:flutter/material.dart';

void main() => runApp(MelhoresCervejasApp());

class MelhoresCervejasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melhores Cervejas',
      home: MelhoresCervejasPage(),
    );
  }
}

class MelhoresCervejasPage extends StatelessWidget {
  final List<String> cervejas = [
    'Westvleteren 12',
    'Trappistes Rochefort 10',
    'Westmalle Tripel',
    'St. Bernardus Abt 12',
    'Quadrupel Oak Aged Batch 65',
    'La Trappe Quadrupel',
    'Chimay Grande Reserve',
    'Närke Kaggen Stormaktsporter',
    'Trappistes Rochefort 8',
    'Founders CBS',
    'Founders KBS',
    'Oskar Blues Ten FIDY',
    'Alesmith Speedway Stout',
    'Sierra Nevada Narwhal',
    'Russian River Pliny the Elder',
    'Three Floyds Dark Lord',
    'Bourbon County Brand Stout',
    'Hill Farmstead Abner',
    'Tree House Julius',
    'Cigar City Hunahpu\'s Imperial Stout',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Melhores Cervejas do Mundo'),
      ),
      body: ListView.builder(
        itemCount: cervejas.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${index + 1}. ${cervejas[index]}'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Lógica para o botão de menu de café
              },
              child: Text('Café'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para o botão de cerveja
              },
              child: Text('Cerveja'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para o botão de água
              },
              child: Text('Água'),
            ),
          ],
        ),
      ),
    );
  }
}
