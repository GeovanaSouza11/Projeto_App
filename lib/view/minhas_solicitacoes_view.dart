import 'package:flutter/material.dart';
import '../core/app_routes.dart';

class MinhasSolicitacoesView extends StatelessWidget {
  const MinhasSolicitacoesView({super.key});

  static const Color vermelho = Color(0xFFE7000B);
  static const Color cinza = Color(0xFF333333);

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();

    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context)?.settings.arguments;

    final Map<String, dynamic>? solicitacao =
        argumentos is Map<String, dynamic> ? argumentos : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.registrarProblema,
              );
            }
          },
        ),
        title: const Text(
          'Minhas Solicitações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
      body: solicitacao == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nenhuma solicitação registrada.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: cinza,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Confira as informações da sua solicitação.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: cinza,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              solicitacao['categoria'] ?? 'Outros',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: cinza,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Pendente',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 10),
                      _buildInformacao(
                        icone: Icons.description_outlined,
                        titulo: 'Descrição',
                        valor: solicitacao['descricao'] ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildInformacao(
                        icone: Icons.location_on_outlined,
                        titulo: 'Endereço',
                        valor:
                            '${solicitacao['rua'] ?? ''}, '
                            '${solicitacao['numero'] ?? ''}',
                      ),
                      const SizedBox(height: 16),
                      _buildInformacao(
                        icone: Icons.markunread_mailbox_outlined,
                        titulo: 'CEP',
                        valor: solicitacao['cep'] ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildInformacao(
                        icone: Icons.calendar_today_outlined,
                        titulo: 'Data do registro',
                        valor: solicitacao['data'] is DateTime
                            ? _formatarData(
                                solicitacao['data'] as DateTime,
                              )
                            : 'Data não informada',
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detalhesSolicitacao,
                              arguments: solicitacao,
                            );
                          },
                          icon: const Icon(
                            Icons.visibility_outlined,
                            size: 25,
                          ),
                          label: const Text(
                            'Acompanhar retorno da solicitação',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vermelho,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInformacao({
    required IconData icone,
    required String titulo,
    required String valor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icone,
          color: vermelho,
          size: 23,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                valor,
                style: TextStyle(
                  fontSize: 17,
                  color: cinza,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
