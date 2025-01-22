import 'dart:convert';
import 'package:app/models/animal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3333/api';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<void> registrarUsuario(String nome, String email, String senha) async {
    final response = await client.post(
      Uri.parse('$baseUrl/registrar'),
      body: jsonEncode({
        'nome': nome,
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao registrar usuário');
    }
  }

  Future<String> login(String email, String senha) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return json['token'];
    } else {
      throw Exception('Falha ao fazer login');
    }
  }

  Future<List<Animal>> buscarAnimais(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/animais'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Animal.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar animais');
    }
  }
}
