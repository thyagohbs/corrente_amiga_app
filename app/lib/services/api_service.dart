import 'dart:convert';
import 'package:app/models/animal.dart';
import 'package:http/http.dart' as http;

class BaseApiService {
  final http.Client client;
  static const String baseUrl = 'http://localhost:3333/api';

  BaseApiService({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await client
        .post(
          Uri.parse('$baseUrl/$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  Future<dynamic> get(String endpoint, {String? token}) async {
    final Map<String, String> headers =
        token != null ? {'Authorization': 'Bearer $token'} : {};
    final response = await client
        .get(
          Uri.parse('$baseUrl/$endpoint'),
          headers: headers,
        )
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}

class ApiService extends BaseApiService {
  ApiService({http.Client? client}) : super(client: client);
  String baseUrl = "";

  Future<void> registrarUsuario(String nome, String email, String senha) async {
    await post('registrar', {
      'nome': nome,
      'email': email,
      'senha': senha,
    });
  }

  Future<String> login(String email, String senha) async {
    final response = await post('login', {
      'email': email,
      'senha': senha,
    });
    return response['token'];
  }

  Future<List<Animal>> buscarAnimais(String token) async {
    final response = await get('animais', token: token);
    return (response as List).map((json) => Animal.fromJson(json)).toList();
  }
}
