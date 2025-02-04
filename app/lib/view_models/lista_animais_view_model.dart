import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/animal.dart';
import '../services/api_service.dart';

class ListaAnimaisViewModel with ChangeNotifier {
  final ApiService apiService;

  ListaAnimaisViewModel({required this.apiService});

  final List<Animal> _animais = [];
  List<Animal> get animais => _animais;

  bool _carregando = false;
  bool get carregando => _carregando;

  String? _erro;
  String? get erro => _erro;

  String? _filtroEspecie;
  String? _filtroLocalizacao;

  int _paginaAtual = 1;
  bool _temMaisItens = true;

  final Set<int> _favoritos = {};

  Set<int> get favoritos => _favoritos;

  Future<void> carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritos = prefs.getStringList('favoritos') ?? [];
    _favoritos.clear();
    _favoritos.addAll(favoritos.map(int.parse));
    notifyListeners();
  }

  Future<void> salvarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favoritos', _favoritos.map((id) => id.toString()).toList());
  }

  void toggleFavorito(int animalId) {
    if (_favoritos.contains(animalId)) {
      _favoritos.remove(animalId);
    } else {
      _favoritos.add(animalId);
    }
    salvarFavoritos();
    notifyListeners();
  }

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

  void aplicarFiltros({String? especie, String? localizacao}) {
    _filtroEspecie = especie;
    _filtroLocalizacao = localizacao;
    refresh();
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
