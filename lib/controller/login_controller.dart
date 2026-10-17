import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  String _email = '';
  String _senha = '';
  bool _mostrarSenha = false;

  String get email => _email;
  String get senha => _senha;
  bool get mostrarSenha => _mostrarSenha;

  bool get camposPreenchidos =>
      _email.trim().isNotEmpty && _senha.isNotEmpty;

  void atualizarEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void atualizarSenha(String senha) {
    _senha = senha;
    notifyListeners();
  }

  void alternarVisibilidadeSenha() {
    _mostrarSenha = !_mostrarSenha;
    notifyListeners();
  }
}