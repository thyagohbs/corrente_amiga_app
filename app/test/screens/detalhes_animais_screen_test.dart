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
    localizacao: 'São Paulo',
  );

  testWidgets('deve exibir os detalhes do animal', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: animal),
      ),
    );

    expect(find.text('Nome: Rex'), findsOneWidget);
    expect(find.text('Espécie: Cachorro'), findsOneWidget);
    expect(find.text('Raça: Pastor alemão'), findsOneWidget);
    expect(find.text('Idade: 3'), findsOneWidget);
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

  testWidgets('deve exibir o ícone de fallback quando a imagem falhar',
      (WidgetTester tester) async {
    final invalidAnimal = Animal(
      nome: 'Rex',
      especie: 'Cachorro',
      raca: 'Pastor alemão',
      idade: 3,
      descricao: 'Amigável e brincalhão!',
      foto: 'invalid_url.jpg', // URL inválida
      localizacao: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: invalidAnimal),
      ),
    );

    expect(find.byIcon(Icons.pets), findsOneWidget);
  });

  testWidgets('deve exibir mensagem padrão para campos opcionais vazios',
      (WidgetTester tester) async {
    final incompleteAnimal = Animal(
      nome: 'Rex',
      especie: 'Cachorro',
      raca: null,
      idade: null,
      descricao: null,
      foto: 'rex.jpg',
      localizacao: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DetalhesAnimalScreen(animal: incompleteAnimal),
      ),
    );

    expect(find.text('Raça: Não informada'), findsOneWidget);
    expect(find.text('Idade: Não informada'), findsOneWidget);
    expect(find.text('Nenhuma descrição disponível.'), findsOneWidget);
  });
}
