
import 'package:flutter/material.dart';

class PerfilController extends ChangeNotifier {
  String? _nome;
  String? _email;
  String? _telefone;
  String? _senha;

  String? get nome => _nome;
  String? get email => _email;
  String? get telefone => _telefone;

  // Guarda os dados do cadastro
  void cadastrarUsuario({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) {
    _nome = nome.trim();
    _email = email.trim().toLowerCase();
    _telefone = telefone.trim();
    _senha = senha;

    notifyListeners();
  }

  bool autenticar(String email, String senha) {
    return _email == email.trim().toLowerCase() &&
        _senha == senha;
  }

  //Atualiza 
  bool atualizarNome(String novoNome) {
    if (novoNome.trim().length < 3) {
      return false;
    }

    _nome = novoNome.trim();

    notifyListeners();
    return true;
  }
}
