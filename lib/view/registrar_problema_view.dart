
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/app_routes.dart';

class RegistrarProblemaView extends StatefulWidget {
  const RegistrarProblemaView({super.key});

  @override
  State<RegistrarProblemaView> createState() =>
      _RegistrarProblemaViewState();
}

class _RegistrarProblemaViewState
    extends State<RegistrarProblemaView> {
  final Color vermelho = const Color(0xFFE7000B);
  final Color cinza = const Color(0xFF333333);

  String? _categoriaSelecionada = 'Energia';

  final TextEditingController _descricaoController =
      TextEditingController();
  final TextEditingController _ruaController =
      TextEditingController();
  final TextEditingController _numeroController =
      TextEditingController();
  final TextEditingController _cepController =
      TextEditingController();

  final List<Map<String, dynamic>> _categorias = [
    {'titulo': 'Energia', 'icone': Icons.flash_on},
    {'titulo': 'Água e Esgoto', 'icone': Icons.water_drop},
    {'titulo': 'Ambiental', 'icone': Icons.eco},
    {'titulo': 'Infraestrutura Urbana', 'icone': Icons.location_city},
    {'titulo': 'Segurança Pública', 'icone': Icons.shield},
    {'titulo': 'Limpeza Urbana', 'icone': Icons.cleaning_services},
    {'titulo': 'Trânsito e Mobilidade', 'icone': Icons.traffic},
    {'titulo': 'Saúde Pública', 'icone': Icons.local_hospital},
    {'titulo': 'Outros', 'icone': Icons.help_outline},
  ];

  @override
  void dispose() {
    _descricaoController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _cepController.dispose();
    super.dispose();
  }

  void _enviarOcorrencia() {
    final descricao = _descricaoController.text.trim();
    final rua = _ruaController.text.trim();
    final numero = _numeroController.text.trim();
    final cep = _cepController.text.trim();

    if (descricao.isEmpty ||
        rua.isEmpty ||
        numero.isEmpty ||
        cep.isEmpty) {
      _mostrarMensagem('Preencha todos os campos obrigatórios.');
      return;
    }

    if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(descricao)) {
      _mostrarMensagem(
        'A descrição deve conter somente letras e espaços.',
      );
      return;
    }

    if (!RegExp(r'^(?=.*[a-zA-ZÀ-ÿ])[a-zA-ZÀ-ÿ0-9\s.,-]+$')
        .hasMatch(rua)) {
      _mostrarMensagem(
        'Informe um nome de rua válido, com pelo menos uma letra.',
      );
      return;
    }

    if (!RegExp(r'^[a-zA-ZÀ-ÿ0-9\s.,/-]+$').hasMatch(numero)) {
      _mostrarMensagem(
        'O número/complemento deve conter somente letras e números.',
      );
      return;
    }

    if (!RegExp(r'^\d{8}$').hasMatch(cep)) {
      _mostrarMensagem(
        'CEP inválido. Digite exatamente 8 números, sem traço.',
      );
      return;
    }

    final Map<String, dynamic> solicitacao = {
      'categoria': _categoriaSelecionada ?? 'Outros',
      'descricao': descricao,
      'rua': rua,
      'numero': numero,
      'cep': cep,
      'data': DateTime.now(),
      'status': 'Pendente',
    };

    Navigator.pushNamed(
      context,
      AppRoutes.minhasSolicitacoes,
      arguments: solicitacao,
    );
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: cinza,
        content: Text(
          mensagem,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: vermelho,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 76,
        title: const Text(
          'Registrar Problema',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 29,
            color: Colors.white,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.login,
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qual tipo de problema?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cinza,
              ),
            ),
            const SizedBox(height: 6),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 1.4,
              ),
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                final selecionada =
                    _categoriaSelecionada == categoria['titulo'];

                return InkWell(
                  onTap: () {
                    setState(() {
                      _categoriaSelecionada = categoria['titulo'];
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: selecionada
                          ? vermelho.withValues(alpha: 0.08)
                          : Colors.white,
                      border: Border.all(
                        color: selecionada
                            ? vermelho
                            : Colors.grey.shade300,
                        width: selecionada ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          categoria['icone'] as IconData,
                          color: selecionada
                              ? vermelho
                              : Colors.grey.shade700,
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            categoria['titulo'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              height: 1.0,
                              fontWeight: selecionada
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: cinza,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 2),
            const Divider(height: 1),
            const SizedBox(height: 2),
            Text(
              'Descreva o problema',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cinza,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Descrição *',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _descricaoController,
              maxLines: 3,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZÀ-ÿ\s]'),
                ),
              ],
              decoration: _inputDecoration(
                'Descreva o problema encontrado...',
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 8),
            Text(
              'Informe a localização',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cinza,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Nome da rua *',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _ruaController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZÀ-ÿ0-9\s.,-]'),
                ),
              ],
              decoration: _inputDecoration(
                'Ex.: Avenida Nove de Julho',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Número/Complemento *',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _numeroController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZÀ-ÿ0-9\s.,/-]'),
                ),
              ],
              decoration: _inputDecoration(
                'Ex.: 1500, próximo ao supermercado',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'CEP *',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.text,
              maxLength: 8,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
              ],
              decoration: _inputDecoration('00000000').copyWith(
                counterText: '',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _enviarOcorrencia,
                icon: const Icon(Icons.send, size: 18),
                label: const Text('Enviar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: vermelho,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 13,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: vermelho),
      ),
    );
  }
}