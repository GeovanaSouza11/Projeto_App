
import 'package:flutter/material.dart';
import '../core/dependencias.dart';
import '../controller/perfil_controller.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final PerfilController _perfilController =
      g<PerfilController>();

  final TextEditingController _nomeController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  static const Color vermelho = Color(0xFFE7000B);
  static const Color cinza = Color(0xFF333333);
  static const Color fundo = Color(0xFFF5F5F5);

  @override
  void initState() {
    super.initState();

    _nomeController.text = _perfilController.nome ?? '';
    _emailController.text = _perfilController.email ?? '';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _salvarAlteracoes() {
    final nome = _nomeController.text.trim();

    // Aceita apenas letras e espaços no nome.
    final nomeValido =
        RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(nome);

    if (!nomeValido || nome.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um nome válido, usando apenas letras '
            'e pelo menos 3 caracteres.',
          ),
        ),
      );
      return;
    }

    bool atualizado =
        _perfilController.atualizarNome(nome);

    if (!atualizado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível atualizar o nome.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nome atualizado com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: vermelho,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Perfil do Usuário',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        // SOMENTE A SETA DE VOLTAR
        leading: IconButton(
          padding: EdgeInsets.zero,
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
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 460,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: fundo,
                      child: Icon(
                        Icons.person,
                        size: 54,
                        color: cinza,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Center(
                    child: Text(
                      'Meu perfil',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: cinza,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Center(
                    child: Text(
                      'Consulte e atualize seus dados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'Dados pessoais',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: cinza,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Nome do usuário',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: cinza,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _nomeController,
                    textCapitalization: TextCapitalization.words,
                    decoration: _decoracao(
                      'Digite seu nome',
                      Icons.person_outline,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'E-mail (não editável)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: cinza,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _emailController,
                    enabled: false,
                    decoration: _decoracao(
                      'E-mail cadastrado',
                      Icons.email_outlined,
                    ).copyWith(
                      filled: true,
                      fillColor: fundo,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _salvarAlteracoes,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: vermelho,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Salvar Alterações',
                        style: TextStyle(
                          fontSize: 16,
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
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}