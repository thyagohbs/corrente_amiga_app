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
      when(mockApiService.login('teste@teste.com', '123456')).thenAnswer(
          (_) async =>
              'oat_Mw.ZC0waHlIYnF6WUlUYWI0bElfeEcwMndWbnI3cnpjZXlpcEk0RHpfMzk4MjY2NjEwOQ');

      final token = await mockApiService.login('teste@teste.com', '123456');

      // Mockar a resposta da API
      when(mockApiService.buscarAnimais(token)).thenAnswer((_) async => [
            Animal(
                nome: 'Ralfi',
                especie: 'Cachorro',
                raca: 'Labrador',
                foto: 'foto.jpg'),
          ]);

      // Chamar a função que estamos testando
      await viewModel
          .buscarAnimais(); // Chamada movida para antes das asserções

      // Verificar se o estado do viewModel foi atualizado corretamente
      expect(viewModel.carregando, false);
      expect(viewModel.animais.length, 1);
      expect(viewModel.animais[0].nome, 'Ralfi');
      verify(mockApiService.buscarAnimais(token)).called(1);
    });
  });
}
