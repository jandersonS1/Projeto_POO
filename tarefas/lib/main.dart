import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);
  var chaves = ["name", "style", "ibu"];
  var colunas = ["Coluna", "Coluna", "Coluna"];

  void carregar(index) {
    var carregadores = [
      carregarCafe,
      carregarCervejas,
      carregarNacoes,
    ];
// teste
    carregadores[index]();
  }

  void PropCervejas() {
    chaves = ["name", "style", "ibu"];
    colunas = ["Nome", "Estilo", "IBU"];
  }

  void PropCafes() {
    chaves = ["name", "intensidade", "nacionalidade"];
    colunas = ["Nome", "Intensidade", "Nacionalidade"];
  }

  void PropNacoes() {
    chaves = ["name", "moeda", "habitantes"];
    colunas = ["Nome", "Moeda", "Habitantes"];
  }

  void carregarCervejas() {
    PropCervejas();

    tableStateNotifier.value = [
      {
      "name": "Westvleteren 12", 
      "style": "Belgian Quadrupel", 
      "ibu": "30"
      },
      {
        "name": "Trappist Rochefort 10",
        "style": "Belgian Quadrupel",
        "ibu": "100"
      },
      {
      "name": "Westmalle Tripel", 
      "style": "Tripel", 
      "ibu": "35"
      },
      {
      "name": "Pliny the Elder", 
      "style": "American Double IPA", 
      "ibu": "100"
      },
      {
      "name": "Rochefort 10", 
      "style": "Belgian Strong Ale", 
      "ibu": "30"
      }
    ];
  }

  void carregarCafe() {
    PropCafes();

    tableStateNotifier.value = [
      {
        "name": "Kopi Luwak",
        "intensidade": "Nível 6",
        "nacionalidade": "Indonésia"
      },
      {
        "name": "Blue Mountian",
        "intensidade": "Nível 5",
        "nacionalidade": "Jamaica"
      },
      {
        "name": "Ethiopian Yirgacheffe",
        "intensidade": "Nível 4",
        "nacionalidade": "Etiópia"
      },
      {
        "name": "Hawaiian Kona",
        "intensidade": "Nível 4",
        "nacionalidade": "Havaí, Estados Unidos"
      },
      {
        "name": "Colombian Supremo",
        "intensidade": "Nível 3",
        "nacionalidade": "Colômbia"
      }
    ];
  }

  void carregarNacoes() {
    PropNacoes();

    tableStateNotifier.value = [
      {"name": "China", "moeda": "Yuan (CNY)", "habitantes": "1,41 Bilhão"},
      {"name": "India", "moeda": "Rúpia indiana (INR)", "habitantes": "1,38 Bilhão"},
      {"name": "Estados Unidos", "moeda": "Dólar americano (USD)", "habitantes": "332 Milhões"},
      {"name": "Indonésia", "moeda": "Rupiah indonésio (IDR)", "habitantes": "275 Milhões"},
      {"name": "Paquistão", "moeda": "Rupia paquistanesa (PKR)", "habitantes": "225 Milhões"}
    ];
  }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                return DataTableWidget(
                  jsonObjects: value,
                  propertyNames: dataService.chaves,
                  columnNames: dataService.colunas,
                );
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  var itemSelectedCallback; //esse atributo será uma função

  NewNavBar({this.itemSelectedCallback}) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(0);
    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          print(state.value);
          itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;

  final List<String> columnNames;

  final List<String> propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const ["Coluna", "Coluna", "Coluna"],
      this.propertyNames = const ["name", "style", "ibu"]});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}