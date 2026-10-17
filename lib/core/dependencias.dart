import 'package:get_it/get_it.dart';

import '../controller/cadastrar_usuario_controller.dart';
import '../controller/login_controller.dart';
import '../controller/perfil_controller.dart';
import '../controller/recuperar_senha_controller.dart';
import '../controller/sobre_controller.dart';

final g = GetIt.instance;

void configurarDependencias() {
  g.registerSingleton<RecuperarSenhaController>(RecuperarSenhaController());
  g.registerSingleton<LoginController>(LoginController());
  g.registerSingleton<CadastrarUsuarioController>(CadastrarUsuarioController());  
  g.registerSingleton<PerfilController>(PerfilController());
  g.registerSingleton<SobreController>(SobreController());
}