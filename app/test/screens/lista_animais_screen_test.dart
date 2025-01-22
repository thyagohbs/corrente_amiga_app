import 'package:app/models/animal.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'lista_animais_screen_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(client: mockClient);
  });

  group('buscarAnimais', () {
    test(
      'deve retornar uma lista de animais quando a chamada da API for bem-sucedida',
      () async {
        // Mockar a resposta da API para o login
        when(mockClient.post(Uri.parse('${ApiService.baseUrl}/login'),
                body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(
                '{"token": "oat_Mw.ZC0waHlIYnF6WUlUYWI0bElfeEcwMndWbnI3cnpjZXlpcEk0RHpfMzk4MjY2NjEwOQ"}',
                200));

        // Fazer o login para obter o token
        final token = await apiService.login('teste@teste.com', '123456');

        // Mockar a resposta da API para buscar animais
        when(mockClient.get(Uri.parse('${ApiService.baseUrl}/animais'),
                headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(
                '[{"nome": "Ralfi", "especie": "Cachorro", "raca": "Labrador", "foto": "foto.jpg"}]',
                200));

        // Chamar buscarAnimais com o token
        final animais = await apiService.buscarAnimais(token);

        expect(animais, isA<List<Animal>>());
        expect(animais.length, 1);
        expect(animais[0].nome, 'Ralfi');
      },
    );
  });
}
