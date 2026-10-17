import 'package:flutter/material.dart';

class TelaInicialController extends ChangeNotifier {
  int? _total;
  int? _pendentes;
  int? _resolvidos;

  String get total => _total?.toString() ?? '—';
  String get pendentes => _pendentes?.toString() ?? '—';
  String get resolvidos => _resolvidos?.toString() ?? '—';

  void atualizarEstatisticas({
    required int total,
    required int pendentes,
    required int resolvidos,
  }) {
    _total = total;
    _pendentes = pendentes;
    _resolvidos = resolvidos;

    notifyListeners();
  }
}