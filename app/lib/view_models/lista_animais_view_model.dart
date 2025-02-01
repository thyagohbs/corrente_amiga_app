import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/animal.dart';
import '../screens/services/api_service.dart';

class ListaAnimaisViewModel with ChangeNotifier {
  final ApiService apiService;

  ListaAnimaisViewModel({required this.apiService});

  final List<Animal> _animais = [];
  List<Animal> get animais => _animais;

  bool _carregando = false;
  bool get carregando => _carregando;

  String? _erro;
  String? get erro => _erro;
  String? _filtroLocalizacao;

  int _paginaAtual = 1;
  bool _temMaisItens = true;

  Future<void> buscarAnimais() async {
    if (!_temMaisItens) return;

    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        _erro = 'Usuário não autenticado!';
        return;
      }

      final novosAnimais = await apiService.buscarAnimais(token);
      if (novosAnimais.isEmpty) {
        _temMaisItens = false;
      } else {
        _animais.addAll(novosAnimais);
        _paginaAtual++;
      }
    } catch (e) {
      _erro = 'Erro ao buscar animais: $e';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  /// Filtra os animais por localização
  void filtrarAnimais(String? localizacao) {
    _filtroLocalizacao = localizacao;
    if (localizacao == null || localizacao.isEmpty) {
      // Remove o filtro
      notifyListeners();
      return;
    }
    _animais.removeWhere((animal) => animal.localizacao != localizacao);
    notifyListeners();
  }

  Future<void> refresh() async {
    _paginaAtual = 1;
    _temMaisItens = true;
    _animais.clear();
    await buscarAnimais();
  }
}
