import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/animal.dart';
import 'package:app/components/animal_card.dart';

void main() {
  final animal = Animal(
    nome: 'Rex',
    especie: 'Cachorro',
    raca: 'Pastor Alemão',
    idade: 3,
    localizacao: 'São Paulo',
    isMissing: false,
    foto: '/assets/foto.jpg',
  );

  Uint8List mockImageData =
      Uint8List.fromList(List<int>.generate(100, (index) => index % 256));

  testWidgets('deve exibir as informações do animal com uma imagem válida',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimalCard(
            animal: animal,
            imageProvider:
                MemoryImage(mockImageData), // Simula uma imagem válida
            onTap: () {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Rex'), findsOneWidget);
    expect(find.text('Cachorro - Pastor Alemão'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('deve exibir ícone de fallback quando a imagem falhar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimalCard(
            animal: animal,
            imageProvider: null, // Simula falha na imagem
            onTap: () {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.pets), findsOneWidget);
  });
}
