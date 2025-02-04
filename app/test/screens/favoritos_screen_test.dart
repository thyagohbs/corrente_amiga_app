import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:app/models/animal.dart';
import 'package:app/screens/favoritos_screen.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'favoritos_screen_test.mocks.dart';

@GenerateMocks([ListaAnimaisViewModel])
void main() {
  late MockListaAnimaisViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockListaAnimaisViewModel();
  });

  testWidgets('Deve exibir a lista de animais favoritos',
      (WidgetTester tester) async {
    when(mockViewModel.animais).thenReturn([
      Animal(
        idade: 1,
        nome: 'Ralfi',
        especie: 'Cachorro',
        raca: 'Labrador',
        foto: 'https://i.ibb.co/xY07zW7/dog.png',
        localizacao: '',
      ),
      Animal(
        idade: 2,
        nome: 'Ralfi',
        especie: 'Cachorro',
        raca: 'Labrador',
        foto: 'https://i.ibb.co/xY07zW7/dog.png',
        localizacao: '',
      )
    ]);

    when(mockViewModel.favoritos).thenReturn({1});

    await tester.pumpWidget(
      ChangeNotifierProvider<ListaAnimaisViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(
          home: FavoritosScreen(imageProvider: MemoryImage(Uint8List(0))),
        ),
      ),
    );

    expect(find.text('Ralfi'), findsOneWidget);
    expect(find.text('Milo'), findsOneWidget);
  });
}
