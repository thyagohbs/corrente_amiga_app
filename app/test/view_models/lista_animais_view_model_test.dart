import 'package:app/models/animal.dart';
import 'package:app/services/api_service.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'lista_animais_view_model_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late ListaAnimaisViewModel viewModel;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    viewModel = ListaAnimaisViewModel(apiService: mockApiService);
  });

  group('buscarAnimais', () {
    test('deve carregar os animais e notificar os listeners', () async {
      when(mockApiService.login('email@example.com', 'senha123'))
          .thenAnswer((_) async => 'seu_token_de_acesso');

      final token = await mockApiService.login('email@example.com', 'senha123');

      // Mockar a resposta da API
      when(mockApiService.buscarAnimais(token)).thenAnswer((_) async => [
            Animal(
                nome: 'Totó',
                especie: 'Cachorro',
                raca: 'Vira-lata',
                foto: 'foto.jpg'),
          ]);

      // Chamar a função que estamos testando
      await viewModel.buscarAnimais();

      // Verificar se o estado do viewModel foi atualizado corretamente
      expect(viewModel.carregando, false);
      expect(viewModel.animais.length, 1);
      expect(viewModel.animais[0].nome, 'Totó');
      verify(mockApiService.buscarAnimais(token)).called(1);
    });

    test('deve lidar com erros e notificar os listeners', () async {
      when(mockApiService.login('email@example.com', 'senha123'))
          .thenAnswer((_) async => 'seu_token_de_acesso');

      final token = await mockApiService.login('email@example.com', 'senha123');

      // Mockar a resposta da API com um erro ANTES de chamar a função
      when(mockApiService.buscarAnimais(token))
          .thenThrow(Exception('Erro na API'));

      // Chamar a função que estamos testando
      await viewModel.buscarAnimais();

      // Verificar se o estado do viewModel foi atualizado corretamente
      expect(viewModel.carregando, false);
      expect(viewModel.erro, isNotNull);
      verify(mockApiService.buscarAnimais(token)).called(1);
    });
  });
}
