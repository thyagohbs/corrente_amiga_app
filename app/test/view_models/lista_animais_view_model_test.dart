import 'package:app/models/animal.dart';
import 'package:app/screens/services/api_service.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      SharedPreferences.setMockInitialValues({'token': 'fake_token'});
      when(mockApiService.buscarAnimais('fake_token')).thenAnswer((_) async => [
            Animal(
              nome: 'Ralfi',
              especie: 'Cachorro',
              raca: 'Labrador',
              foto: 'https://i.ibb.co/xY07zW7/dog.png',
              localizacao: '',
            ),
          ]);

      await viewModel.buscarAnimais();

      expect(viewModel.carregando, false);
      expect(viewModel.animais.length, 1);
      expect(viewModel.animais[0].nome, 'Ralfi');
      verify(mockApiService.buscarAnimais('fake_token')).called(1);
    });

    test('deve definir erro quando a API falhar', () async {
      when(mockApiService.buscarAnimais(any))
          .thenThrow(Exception('Erro na API'));

      await viewModel.buscarAnimais();

      expect(viewModel.erro, 'Erro ao buscar animais: Exception: Erro na API');
      expect(viewModel.carregando, false);
    });

    test('deve definir erro quando o token for nulo', () async {
      SharedPreferences.setMockInitialValues({});

      await viewModel.buscarAnimais();

      expect(viewModel.erro, 'Usuário não autenticado!');
      expect(viewModel.carregando, false);
    });

    test('deve notificar os listeners ao carregar os animais', () async {
      when(mockApiService.buscarAnimais(any)).thenAnswer((_) async => [
            Animal(
              nome: 'Ralfi',
              especie: 'Cachorro',
              raca: 'Labrador',
              foto: 'https://i.ibb.co/xY07zW7/dog.png',
              localizacao: '',
            ),
          ]);

      var listenerCalled = false;
      viewModel.addListener(() => listenerCalled = true);

      await viewModel.buscarAnimais();

      expect(listenerCalled, true);
    });

    test('deve definir carregando como true durante a busca', () async {
      when(mockApiService.buscarAnimais(any)).thenAnswer((_) async => []);

      final future = viewModel.buscarAnimais();
      expect(viewModel.carregando, true);

      await future;
      expect(viewModel.carregando, false);
    });
  });
}
