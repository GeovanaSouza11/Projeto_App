
import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

  static const Color vermelho = Color(0xFFE7000B);
  static const Color cinza = Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // CABEÇALHO
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: vermelho,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Sobre o Projeto',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        // BOTÃO VOLTAR
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

      // CONTEÚDO DA TELA
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ÍCONE DO PRÉDIO
                  const Center(
                    child: Icon(
                      Icons.location_city,
                      color: cinza,
                      size: 56,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // NOME DO APLICATIVO
                  const Center(
                    child: Text(
                      'Ribeirão Resolve',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: cinza,
                      ),
                    ),
                  ),

                  const SizedBox(height: 2),

                  // FRASE DO APLICATIVO
                  const Center(
                    child: Text(
                      'Juntos por uma cidade melhor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: cinza,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // OBJETIVO DO APLICATIVO
                  _titulo('Objetivo do Aplicativo'),

                  const SizedBox(height: 5),

                  const Text(
                    'O Ribeirão Resolve é um sistema mobile de '
                    'ouvidoria urbana que busca facilitar o registro '
                    'de problemas na cidade de Ribeirão Preto. '
                    'A proposta é facilitar a comunicação de problemas '
                    'urbanos pelos cidadãos e permitir o acompanhamento '
                    'das solicitações registradas no aplicativo. ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: cinza,
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 6),

                  // EQUIPE DE DESENVOLVIMENTO
                  _titulo('Equipe de Desenvolvimento'),

                  const SizedBox(height: 6),

                  _membro('Gabriela Rampazzo Galoni'),

                  const SizedBox(height: 5),

                  _membro('Geovana Souza'),

                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 6),

                  // INFORMAÇÕES INSTITUCIONAIS
                  _titulo('Informações Institucionais'),

                  const SizedBox(height: 8),

                  _informacao(
                    Icons.school_outlined,
                    'Instituição',
                    'Fatec Ribeirão Preto',
                  ),

                  const SizedBox(height: 8),

                  _informacao(
                    Icons.menu_book_outlined,
                    'Curso',
                    'Análise e Desenvolvimento de Sistemas (ADS)',
                  ),

                  const SizedBox(height: 8),

                  _informacao(
                    Icons.book_outlined,
                    'Disciplina',
                    'Programação para Dispositivos Móveis',
                  ),

                  const SizedBox(height: 8),

                  _informacao(
                    Icons.person_outline,
                    'Professor',
                    'Rodrigo de Oliveira Plotze',
                  ),

                  const SizedBox(height: 8),

                  _informacao(
                    Icons.info_outline,
                    'Versão do aplicativo',
                    '1.0.0',
                  ),

                  const SizedBox(height: 6),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TÍTULOS DAS SEÇÕES
  static Widget _titulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: cinza,
      ),
    );
  }

  // INTEGRANTES DA EQUIPE
  static Widget _membro(String nome) {
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          color: vermelho,
          size: 23,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            nome,
            style: const TextStyle(
              fontSize: 15,
              color: cinza,
            ),
          ),
        ),
      ],
    );
  }

  // INFORMAÇÕES INSTITUCIONAIS
  static Widget _informacao(
    IconData icone,
    String titulo,
    String descricao,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icone,
          color: vermelho,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                descricao,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                  color: cinza,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}