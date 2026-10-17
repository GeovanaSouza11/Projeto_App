import 'package:flutter/material.dart';
import '../core/app_routes.dart';

class DetalhesSolicitacoesView extends StatelessWidget {
  const DetalhesSolicitacoesView({super.key});

  static const Color vermelho = Color(0xFFE7000B);
  static const Color cinza = Color(0xFF333333);
  static const Color fundo = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context)?.settings.arguments;

    final Map<String, dynamic>? solicitacao =
        argumentos is Map<String, dynamic> ? argumentos : null;

    final String retorno =
        solicitacao?['retorno']?.toString().trim() ?? '';

    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        backgroundColor: vermelho,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black45,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 29,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detalhes da Solicitação',
          style: TextStyle(
            fontSize: 21,
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
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.telaInicial,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.timeline,
                size: 44,
                color: vermelho,
              ),
              const SizedBox(height: 4),
              const Text(
                'Acompanhamento da Solicitação',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: cinza,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Acompanhe as etapas e os retornos da prefeitura.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Histórico de acompanhamento',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: cinza,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: solicitacao == null
                            ? Center(
                                child: Text(
                                  'Registre um problema para acompanhar '
                                  'as atualizações por aqui.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: _etapa(
                                      icone: Icons.check_circle,
                                      titulo: 'Solicitação registrada',
                                      descricao:
                                          'Problema: '
                                          '${solicitacao['categoria'] ?? 'Outros'}',
                                      cor: Colors.green,
                                    ),
                                  ),
                                  Expanded(
                                    child: _etapa(
                                      icone: Icons.hourglass_top,
                                      titulo:
                                          solicitacao['status'] ??
                                              'Pendente',
                                      descricao:
                                          'Sua solicitação foi enviada '
                                          'e aguarda acompanhamento.',
                                      cor: Colors.orange,
                                      ultima: retorno.isEmpty,
                                    ),
                                  ),
                                  if (retorno.isNotEmpty)
                                    Expanded(
                                      child: _etapa(
                                        icone: Icons.account_balance,
                                        titulo: 'Retorno da Prefeitura',
                                        descricao: retorno,
                                        cor: vermelho,
                                        ultima: true,
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.sugestoes,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: vermelho,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 17,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Quer melhorar esse aplicativo?\n'
                    'Clique aqui e faça uma sugestão',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _etapa({
    required IconData icone,
    required String titulo,
    required String descricao,
    required Color cor,
    bool ultima = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Icon(icone, color: cor, size: 27),
              if (!ultima)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: cinza,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  descricao,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}