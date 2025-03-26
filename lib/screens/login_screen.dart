import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final List<Map<String, String>> usuarios = [
    {
      'nome': 'Usuário 1',
      'foto':
          'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png',
    },
    {
      'nome': 'Usuário 2',
      'foto':
          'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecione um Usuário')),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          var usuario = usuarios[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(usuario['foto']!),
                      radius: 30,
                    ),
                    SizedBox(width: 20),
                    Text(usuario['nome']!, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
