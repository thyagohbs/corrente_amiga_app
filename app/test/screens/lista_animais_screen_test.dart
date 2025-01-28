import 'package:app/models/animal.dart';
import 'package:app/screens/detalhes_animal_screen.dart';
import 'package:app/screens/lista_animais_screen.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'lista_animais_screen_test.mocks.dart';
import 'mock_image_provider_test.dart';

@GenerateMocks([ListaAnimaisViewModel])
void main() {
  late MockListaAnimaisViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockListaAnimaisViewModel();
  });

  testWidgets('deve exibir CircularProgressIndicator enquanto carrega',
      (WidgetTester tester) async {
    when(mockViewModel.carregando).thenReturn(true);

    final mockImageProvider = MockImageProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (_) => mockViewModel,
        child: MaterialApp(
          home: ListaAnimaisScreen(imageProvider: mockImageProvider),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('deve exibir mensagem quando não houver animais',
      (WidgetTester tester) async {
    when(mockViewModel.carregando).thenReturn(false);
    when(mockViewModel.erro).thenReturn(null);
    when(mockViewModel.animais).thenReturn([]);

    final mockImageProvider = MockImageProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (_) => mockViewModel,
        child: MaterialApp(
          home: ListaAnimaisScreen(imageProvider: mockImageProvider),
        ),
      ),
    );

    expect(find.text('Nenhum animal encontrado.'), findsOneWidget);
  });

  testWidgets('deve exibir a lista de animais quando houver animais',
      (WidgetTester tester) async {
    final mockImageProvider = MockImageProvider();

    when(mockViewModel.carregando).thenReturn(false);
    when(mockViewModel.erro).thenReturn(null);
    when(mockViewModel.animais).thenReturn([
      Animal(
        nome: 'Ralfi',
        especie: 'Cachorro',
        raca: 'Vira-lata',
        foto: 'foto.png',
        localizacao: '',
      ),
    ]);

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (_) => mockViewModel,
        child: MaterialApp(
          home: ListaAnimaisScreen(imageProvider: mockImageProvider),
        ),
      ),
    );

    expect(find.text('Ralfi'), findsOneWidget);
    expect(find.text('Cachorro - Vira-lata'), findsOneWidget);
  });

  testWidgets('deve exibir mensagem de erro quando ocorrer um erro',
      (WidgetTester tester) async {
    when(mockViewModel.carregando).thenReturn(false);
    when(mockViewModel.erro).thenReturn('Erro ao carregar animais');
    when(mockViewModel.animais).thenReturn([]);

    final mockImageProvider = MockImageProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (_) => mockViewModel,
        child: MaterialApp(
          home: ListaAnimaisScreen(imageProvider: mockImageProvider),
        ),
      ),
    );

    expect(find.text('Erro ao carregar animais'), findsOneWidget);
  });

  testWidgets('deve navegar para a tela de detalhes ao tocar em um animal',
      (WidgetTester tester) async {
    final mockImageProvider = MockImageProvider();

    when(mockViewModel.carregando).thenReturn(false);
    when(mockViewModel.erro).thenReturn(null);
    when(mockViewModel.animais).thenReturn([
      Animal(
        nome: 'Ralfi',
        especie: 'Cachorro',
        raca: 'Vira-lata',
        foto: 'foto.png',
        localizacao: '',
      ),
    ]);

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (_) => mockViewModel,
        child: MaterialApp(
          home: ListaAnimaisScreen(imageProvider: mockImageProvider),
        ),
      ),
    );

    await tester.tap(find.text('Ralfi'));
    await tester.pumpAndSettle(); // Aguarda a navegação

    expect(find.byType(DetalhesAnimalScreen), findsOneWidget);
  });
}
