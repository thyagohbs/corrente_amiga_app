import 'package:app/models/animal.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'api_service_test.mocks.dart';

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
        when(mockClient.post(Uri.parse('${ApiService.baseUrl}/login'),
                body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(
                '{"token": "oat_Mw.ZC0waHlIYnF6WUlUYWI0bElfeEcwMndWbnI3cnpjZXlpcEk0RHpfMzk4MjY2NjEwOQ"}',
                200));

        final token = await apiService.login('teste@teste.com', '123456');

        when(mockClient.get(Uri.parse('${ApiService.baseUrl}/animais'),
                headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(
                '[{"nome": "Ralfi", "especie": "Cachorro", "raca": "Labrador", "foto": "foto.jpg"}]',
                200));

        final animais = await apiService.buscarAnimais(token);
        expect(animais, isA<List<Animal>>());
        expect(animais.length, 1);
        expect(animais[0].nome, 'Ralfi');
      },
    );
  });
}
