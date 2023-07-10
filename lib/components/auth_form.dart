import 'package:flutter/material.dart';

enum AuthMode { Singup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;
  final passwordController = TextEditingController();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (text) {
                  final email = text ?? '';
                  if (email.trim().isEmpty) {
                    return 'Email. é obrigatório!';
                  }
                  if (!email.contains('@') &&
                      (!email.endsWith('.com') || !email.endsWith('.com.br'))) {
                    return 'E-mail inválido!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (text) {
                  final password = text ?? '';
                  if (password.trim().isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  if (password.length < 5) {
                    return 'Senha deve ter no mínimo 5 caracteres';
                  }
                  return null;
                },
              ),
              if (_authMode == AuthMode.Singup)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: _authMode == AuthMode.Login
                      ? null
                      : (text) {
                          final password = text ?? '';
                          if (password != passwordController.text) {
                            return 'As senhas devem ser iguais!';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                ),
                child:
                    Text(_authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
