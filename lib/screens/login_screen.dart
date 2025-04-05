import 'package:app_diario/models/user.dart';
import 'package:flutter/material.dart';
import 'plans_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Text(
              'ProMeta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 48),

            // Campo de email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),

            // Campo de senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),

            // Botão de Login
            ElevatedButton(
              onPressed: () {
                final mockUser = User(
                  id: '1',
                  name: 'Usuário Teste',
                  email:
                      _emailController.text.isEmpty
                          ? 'teste@exemplo.com'
                          : _emailController.text,
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PlansScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(child: Text('Enter')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
