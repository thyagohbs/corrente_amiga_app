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
    foto: 'rex.jpg',
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
}
