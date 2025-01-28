import 'package:app/models/animal.dart';
import 'package:app/screens/detalhes_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'detalhes_animais_screen_test.mocks.dart';

@GenerateMocks([DetalhesAnimalScreen])
void main() {
  late MockDetalhesAnimalScreen mockDetalhesAnimalScreen;

  setUp(() {
    mockDetalhesAnimalScreen = MockDetalhesAnimalScreen();
  });

  final animal = Animal(
    nome: 'Rex',
    especie: 'Cachorro',
    raca: 'Pastor alemão',
    idade: 3,
    descricao: 'Amigável e brincalhão!',
    foto: 'rex.jpg',
    localizacao: '',
  );

  testWidgets('deve exibir os detalhes do animal', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: animal),
      ),
    );

    expect(find.text('Rex'), findsOneWidget);
    expect(find.text('Cachorro'), findsOneWidget);
    expect(find.text('Pastor alemão'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Amigável e brincalhão!'), findsOneWidget);
  });

  testWidgets('deve exibir a imagem do animal', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: animal),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('deve exibir o botão de contato', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: animal),
      ),
    );

    expect(find.text('Entrar em Contato'), findsOneWidget);
  });

  testWidgets('deve abrir o diálogo de contato ao pressionar o botão',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: animal),
      ),
    );

    await tester.tap(find.text('Entrar em Contato'));
    await tester.pump(); // Aguarda a animação do diálogo

    expect(find.text('Formulário de contato aqui...'), findsOneWidget);
  });
}
