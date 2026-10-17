import 'package:flutter/material.dart';
import '../core/dependencias.dart';
import '../controller/perfil_controller.dart';

class CadastrarUsuarioView extends StatefulWidget {
  const CadastrarUsuarioView({super.key});

  @override
  State<CadastrarUsuarioView> createState() =>
      _CadastrarUsuarioViewState();
}

class _CadastrarUsuarioViewState
    extends State<CadastrarUsuarioView> {
  final PerfilController _perfilController =
      g<PerfilController>();

  final TextEditingController _nomeController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _senhaController =
      TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  static const Color vermelho = Color(0xFFE7000B);
  static const Color cinza = Color(0xFF333333);
  static const Color fundo = Color(0xFFF5F5F5);

  void _cadastrar() {
    String nome = _nomeController.text.trim();
    String email = _emailController.text.trim();
    String senha = _senhaController.text;
    String confirmarSenha =
        _confirmarSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );
      return;
    }

    // Verifica se o nome contém apenas letras e espaços.
    bool nomeValido =
        RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(nome);

    // Verifica se o e-mail possui um formato válido.
    bool emailValido = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);

    if (!nomeValido && !emailValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um nome e um e-mail válidos.',
          ),
        ),
      );
      return;
    }

    if (!nomeValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um nome válido, usando apenas letras.',
          ),
        ),
      );
      return;
    }

    if (!emailValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formato de e-mail inválido.'),
        ),
      );
      return;
    }

    // Verifica se as senhas são iguais.
    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem.'),
        ),
      );
      return;
    }

    _perfilController.cadastrarUsuario(
      nome: nome,
      email: email,
      telefone: '',
      senha: senha,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        backgroundColor: vermelho,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Cadastro de Usuário',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 29,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 460,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.person_add_alt_1,
                        size: 54,
                        color: vermelho,
                      ),
                    ),
                    const SizedBox(height: 12),

                    const Center(
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: cinza,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Center(
                      child: Text(
                        'Preencha seus dados para se cadastrar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      'Nome completo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cinza,
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _nomeController,
                      textCapitalization:
                          TextCapitalization.words,
                      decoration: _decoracao(
                        'Digite seu nome',
                        Icons.person_outline,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'E-mail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cinza,
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _emailController,
                      keyboardType:
                          TextInputType.emailAddress,
                      decoration: _decoracao(
                        'Digite seu e-mail',
                        Icons.email_outlined,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Senha',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cinza,
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: _decoracao(
                        'Crie uma senha',
                        Icons.lock_outline,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Confirmar senha',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cinza,
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _confirmarSenhaController,
                      obscureText: true,
                      decoration: _decoracao(
                        'Digite a senha novamente',
                        Icons.lock_outline,
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _cadastrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: vermelho,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Já tem uma conta? Entrar',
                          style: TextStyle(
                            color: vermelho,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoracao(
    String dica,
    IconData icone,
  ) {
    return InputDecoration(
      hintText: dica,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icone,
        color: Colors.grey.shade700,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: vermelho,
          width: 1.5,
        ),
      ),
    );
  }
}