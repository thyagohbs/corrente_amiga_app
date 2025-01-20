import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../services/api_service.dart';

class ListaAnimaisViewModel with ChangeNotifier {
  final ApiService apiService;

  ListaAnimaisViewModel({required this.apiService});

  List<Animal> _animais = [];
  List<Animal> get animais => _animais;

  bool _carregando = false;
  bool get carregando => _carregando;

  String? _erro;
  String? get erro => _erro;

  Future<void> buscarAnimais() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _animais = await apiService.buscarAnimais();
    } catch (e) {
      _erro = 'Erro ao buscar animais: $e';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
