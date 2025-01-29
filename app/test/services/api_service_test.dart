import 'dart:convert';
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

  group('registrarUsuario', () {
    test('deve registrar um usuário com sucesso', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3333/api/registrar'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"message": "success"}', 200));

      await apiService.registrarUsuario('Teste', 'teste@teste.com', '123456');

      verify(mockClient.post(
        Uri.parse('http://localhost:3333/api/registrar'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).called(1);
    });

    test('deve lançar uma exceção quando o registro falhar', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3333/api/registrar'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 400));

      expect(
        () async => await apiService.registrarUsuario(
            'Teste', 'teste@teste.com', '123456'),
        throwsException,
      );
    });
  });

  group('login', () {
    test('deve retornar um token quando o login for bem-sucedido', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3333/api/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"token": "fake_token"}', 200));

      final token = await apiService.login('teste@teste.com', '123456');
      expect(token, 'fake_token');
    });

    test('deve lançar uma exceção quando o login falhar', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3333/api/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 400));

      expect(
        () async => await apiService.login('teste@teste.com', '123456'),
        throwsException,
      );
    });
  });

  group('buscarAnimais', () {
    test(
        'deve retornar uma lista de animais quando a chamada da API for bem-sucedida',
        () async {
      when(mockClient.get(
        Uri.parse('http://localhost:3333/api/animais'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
            '[{"nome": "Ralfi", "especie": "Cachorro", "raca": "Labrador", "foto": "https://i.ibb.co/xY07zW7/dog.png"}]',
            200,
          ));

      final animais = await apiService.buscarAnimais('fake_token');
      expect(animais, isA<List<Animal>>());
      expect(animais.length, 1);
      expect(animais[0].nome, 'Ralfi');
    });

    test('deve lançar uma exceção quando a resposta da API for inválida',
        () async {
      when(mockClient.get(
        Uri.parse('http://localhost:3333/api/animais'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('invalid_json', 200));

      expect(
        () async => await apiService.buscarAnimais('fake_token'),
        throwsException,
      );
    });
  });
}
