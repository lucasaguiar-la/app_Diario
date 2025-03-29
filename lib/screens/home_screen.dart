import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, String>> planos = [
    {'nome': 'Meta março', 'dataInicio': '2025-03-06', 'dataFim': '2025-04-06'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Planos')),
      body: ListView.builder(
        itemCount: planos.length,
        itemBuilder: (context, index) {
          var plano = planos[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(plano['nome']!),
              subtitle: Text(
                'De ${plano['dataInicio']} até ${plano['dataFim']}',
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addPlan');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
