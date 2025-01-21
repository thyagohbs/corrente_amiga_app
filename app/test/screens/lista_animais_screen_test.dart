import 'package:app/models/animal.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:mockito/annotations.dart';

import '../services/api_service_test.mocks.dart';

@GenerateMocks([http.Client]) // Anotar a classe que você quer mockar
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
        // Mockar a resposta da API
        when(mockClient.get(Uri.parse('${ApiService.baseUrl}/animais')))
            .thenAnswer((_) async => http.Response(
                '[{"nome": "Totó", "especie": "Cachorro", "raca": "Vira-lata", "foto": "foto.jpg"}]',
                200));

        final animais = await apiService.buscarAnimais();

        expect(animais, isA<List<Animal>>());
        expect(animais.length, 1);
        expect(animais[0].nome, 'Totó');
      },
    );

    test(
      'deve lançar uma exceção quando a chamada da API falhar',
      () async {
        when(mockClient.get(Uri.parse('${ApiService.baseUrl}/animais')))
            .thenAnswer((_) async => http.Response('Erro', 404));

        expect(apiService.buscarAnimais(), throwsException);
      },
    );
  });
}
