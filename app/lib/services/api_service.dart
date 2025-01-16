import 'package:app/models/animal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = '';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Animal>> buscarAnimais() async {
    throw UnimplementedError();
  }
}
