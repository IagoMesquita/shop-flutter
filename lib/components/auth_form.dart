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
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSingup() => _authMode == AuthMode.Singup;

  void _switchAuthMode() {
    if (_isLogin()) {
      setState(() {
        _authMode = AuthMode.Singup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _submit() {

  }

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
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
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
              if (_isSingup())
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: _isLogin()
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
              if (_isLoading) 
                const CircularProgressIndicator()
              else
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
                child: Text(
                    _authMode == AuthMode.Login ? ('ENTRAR') : 'REGISTRAR'),
              ),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                    _isLogin() ? 'Deseja se registrar ?' : 'Já possui conta ?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
