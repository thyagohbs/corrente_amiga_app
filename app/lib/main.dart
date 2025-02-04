import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/favoritos_screen.dart';
import 'package:app/screens/lista_animais_screen.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:app/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaAnimaisViewModel(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Corrente Amiga',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>
              ListaAnimaisScreen(imageProvider: MemoryImage(Uint8List(0))),
          '/favoritos': (context) =>
              FavoritosScreen(imageProvider: MemoryImage(Uint8List(0))),
        },
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              switch (settings.name) {
                case '/':
                  return ListaAnimaisScreen(
                    imageProvider: MemoryImage(Uint8List(0)),
                  );
                case '/favoritos':
                  return FavoritosScreen(
                    imageProvider: MemoryImage(Uint8List(0)),
                  );
                default:
                  return Container();
              }
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    );
  }
}
