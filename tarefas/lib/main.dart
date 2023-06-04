import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController _nameController = TextEditingController();

  void _startReports() {
    String userName = _nameController.text.trim();

    if (userName.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyReportPage(userName: userName),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, digite seu nome.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Report'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao Daily Report!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startReports,
              child: Text('Começar Relatos'),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyReportPage extends StatefulWidget {
  final String userName;

  DailyReportPage({required this.userName});

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  List<Map<String, dynamic>> _dailyReports = [];
  String _currentTime = '';
  TextEditingController _reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    setState(() {
      _currentTime = formattedTime;
    });
  }

  void _submitReport() {
    String reportText = _reportController.text.trim();

    if (reportText.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

      Map<String, dynamic> report = {
        'date': formattedDate,
        'time': _currentTime,
        'report': reportText,
      };

      setState(() {
        _dailyReports.insert(0, report);
      });

      _reportController.clear();
      _getCurrentTime();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Relato enviado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, digite um relato válido.')),
      );
    }
  }

  void _viewPreviousReports() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviousReportsPage(dailyReports: _dailyReports),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório Diário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${widget.userName}!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Data: ${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Horário: $_currentTime',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reportController,
              onChanged: (text) {
                // Atualize o valor do relato conforme o usuário digita
              },
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Relato do dia',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReport,
              child: Text('Enviar Relato'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _viewPreviousReports,
              child: Text('Ver Relatos Anteriores'),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousReportsPage extends StatelessWidget {
  final List<Map<String, dynamic>> dailyReports;

  PreviousReportsPage({required this.dailyReports});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatos Anteriores'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: dailyReports.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dailyReports[index]['report']),
              subtitle: Text(
                '${dailyReports[index]['date']} ${dailyReports[index]['time']}',
              ),
            );
          },
        ),
      ),
    );
  }
}
