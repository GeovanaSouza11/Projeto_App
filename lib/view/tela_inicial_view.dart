
import 'package:flutter/material.dart';
import '../core/app_routes.dart';

class TelaInicialView extends StatelessWidget {
  const TelaInicialView({super.key});

  final Color vermelho = const Color(0xFFE7000B);
  final Color cinza = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: vermelho,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 58,
        title: const Text(
          'Ribeirão Resolve',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: const SizedBox(
                width: 58,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 29,
                      color: Colors.white,
                    ),
                    Text(
                      'Sair',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Olá, cidadão!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: cinza,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                'Ajude a construir uma cidade melhor.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'Viu algum problema na cidade?',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: cinza,
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 66,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.registrarProblema,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: vermelho,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    elevation: 2,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.campaign, size: 32),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'REGISTRAR PROBLEMA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'Acesse seus serviços',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: cinza,
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _criarAtalho(
                        contexto: context,
                        icone: Icons.account_circle_outlined,
                        titulo: 'Meu perfil',
                        descricao: 'Consulte seus dados pessoais',
                        rota: AppRoutes.perfil,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Expanded(
                      child: _criarAtalho(
                        contexto: context,
                        icone: Icons.lightbulb_outline,
                        titulo: 'Enviar sugestão',
                        descricao: 'Compartilhe suas ideias',
                        rota: AppRoutes.sugestoes,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Expanded(
                      child: _criarAtalho(
                        contexto: context,
                        icone: Icons.assignment_outlined,
                        titulo: 'Minhas solicitações',
                        descricao: 'Consulte os problemas registrados',
                        rota: AppRoutes.minhasSolicitacoes,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Expanded(
                      child: _criarAtalho(
                        contexto: context,
                        icone: Icons.timeline,
                        titulo: 'Acompanhar solicitação',
                        descricao: 'Veja o andamento e os retornos',
                        rota: AppRoutes.detalhesSolicitacao,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _criarAtalho({
    required BuildContext contexto,
    required IconData icone,
    required String titulo,
    required String descricao,
    required String rota,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(contexto, rota);
      },
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: vermelho.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icone,
                color: vermelho,
                size: 29,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cinza,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    descricao,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: cinza,
            ),
          ],
        ),
      ),
    );
  }
}
