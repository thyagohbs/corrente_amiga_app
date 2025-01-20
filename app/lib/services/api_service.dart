import 'dart:convert';
import 'package:app/models/animal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://localhost:3333/api/animais';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Animal>> buscarAnimais() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Animal.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar animais');
    }
  }
}
