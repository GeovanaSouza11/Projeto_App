import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/dependencias.dart';
import 'view/cadastrar_usuario_view.dart';
import 'view/login_view.dart';
import 'view/perfil_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/sobre_view.dart';
import 'view/tela_inicial_view.dart';
import 'view/registrar_problema_view.dart';
import 'view/minhas_solicitacoes_view.dart';
import 'view/sugestoes_view.dart';
import 'view/detalhes_solicitacao_view.dart';

void main(){
  configurarDependencias();
 
 runApp(
    DevicePreview(
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: const LoginView(),
      routes: {
        AppRoutes.cadastrarUsuario: (context) => const CadastrarUsuarioView(),
        AppRoutes.login: (context) => const LoginView(),
        AppRoutes.perfil: (context) => const PerfilView(),
        AppRoutes.recuperarSenha: (context) => const RecuperarSenhaView(),
        AppRoutes.sobre: (context) => const SobreView(),
        AppRoutes.telaInicial: (context) => const TelaInicialView(),
        AppRoutes.registrarProblema: (context) => const RegistrarProblemaView(),
        AppRoutes.minhasSolicitacoes: (context) => const MinhasSolicitacoesView(),
        AppRoutes.detalhesSolicitacao: (context) => const DetalhesSolicitacoesView(),
        AppRoutes.sugestoes: (context) => const SugestoesView(),  
      },
    );
  }
}


