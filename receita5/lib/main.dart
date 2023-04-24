import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


var dataObjects = [];


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Dicas",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            DataTableWidget(jsonObjects: dataObjects),
          ],
        ),
        bottomNavigationBar: NewNavBar(),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  NewNavBar();

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
      backgroundColor: Colors.red,
      onTap: (index) {
        state.value = index;
      },
      currentIndex: state.value,
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined, color: Colors.blue),
        ),
        BottomNavigationBarItem(
          label: "Cervejas",
          icon: Icon(Icons.local_drink_outlined, color: Colors.amber),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_circle_outlined, color: Colors.black),
        ),
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;

  DataTableWidget({this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    var columnNames = ["Nome", "Estilo", "IBU"];
    var propertyNames = ["name", "style", "ibu"];

    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects
          .map(
            (obj) => DataRow(
              cells: propertyNames
                  .map(
                    (propName) => DataCell(
                      Text(obj[propName]),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}