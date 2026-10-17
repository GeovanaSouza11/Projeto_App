import 'package:flutter/material.dart';
import '../core/app_routes.dart';

class SugestoesView extends StatefulWidget {
  const SugestoesView({super.key});

  @override
  State<SugestoesView> createState() => _SugestoesViewState();
}

class _SugestoesViewState extends State<SugestoesView> {
  static const Color vermelho = Color(0xFFE7000B);
  static const Color cinza = Color(0xFF333333);
  static const Color fundo = Color(0xFFF5F5F5);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController =
      TextEditingController();

  final TextEditingController _descricaoController =
      TextEditingController();

  void _voltar() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.telaInicial,
      );
    }
  }

  void _irParaTelaInicial() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.telaInicial,
      (route) => false,
    );
  }

  void _enviarSugestao() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sugestão enviada com sucesso!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: cinza,
        ),
      );

      _tituloController.clear();
      _descricaoController.clear();
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 29,
            color: Colors.white,
          ),
          onPressed: _voltar,
        ),
        title: const Text(
          'Sugestões de Melhorias',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              size: 29,
              color: Colors.white,
            ),
            tooltip: 'Tela inicial',
            onPressed: _irParaTelaInicial,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  size: 45,
                  color: vermelho,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Sua ideia faz a diferença!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: cinza,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Ajude a melhorar esse aplicativo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: cinza,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Título da sugestão',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cinza,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _tituloController,
                  maxLength: 60,
                  decoration: InputDecoration(
                    hintText: 'Ex.: Melhorar recuperar senha',
                    counterText: '',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: vermelho,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Digite o título da sugestão.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Descreva sua sugestão',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cinza,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: TextFormField(
                    controller: _descricaoController,
                    maxLength: 500,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Explique sua ideia...',
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: vermelho,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (valor) {
                      if (valor == null || valor.trim().isEmpty) {
                        return 'Descreva sua sugestão.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _enviarSugestao,
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Enviar sugestão',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: vermelho,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
