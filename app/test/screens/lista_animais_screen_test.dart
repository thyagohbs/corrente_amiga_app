import 'package:app/models/animal.dart';
import 'package:app/screens/lista_animais_screen.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'lista_animais_screen_test.mocks.dart';

@GenerateMocks([ListaAnimaisViewModel])
void main() {
  late MockListaAnimaisViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockListaAnimaisViewModel();
  });

  testWidgets('deve exibir CircularProgressIndicator enquanto carrega',
      (WidgetTester tester) async {
    when(mockViewModel.carregando).thenReturn(true);

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (context) => mockViewModel,
        child: const MaterialApp(
          home: ListaAnimaisScreen(),
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

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (context) => mockViewModel,
        child: const MaterialApp(
          home: ListaAnimaisScreen(),
        ),
      ),
    );

    expect(find.text('Nenhum animal encontrado.'), findsOneWidget);
  });

  testWidgets('deve exibir a lista de animais quando houver animais',
      (WidgetTester tester) async {
    when(mockViewModel.carregando).thenReturn(false);
    when(mockViewModel.erro).thenReturn(null);
    when(mockViewModel.animais).thenReturn([
      Animal(
          nome: 'Ralfi',
          especie: 'Cachorro',
          raca: 'Vira-lata',
          foto: 'foto.png')
    ]);

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>(
        create: (context) => mockViewModel,
        child: const MaterialApp(
          home: ListaAnimaisScreen(),
        ),
      ),
    );
  });
}
