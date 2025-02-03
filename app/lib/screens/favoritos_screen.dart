import 'package:app/screens/detalhes_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/components/animal_card.dart';
import 'package:app/view_models/lista_animais_view_model.dart';

class FavoritosScreen extends StatelessWidget {
  final ImageProvider imageProvider;

  const FavoritosScreen({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListaAnimaisViewModel>(context);

    final favoritos = viewModel.animais
        .where((animal) => viewModel.favoritos.contains(animal.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Favoritos'),
      ),
      body: favoritos.isEmpty
          ? Center(
              child: Text('Nenhum animal favorito'),
            )
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final animal = favoritos[index];
                return AnimalCard(
                  animal: animal,
                  imageProvider: imageProvider,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesAnimalScreen(animal: animal),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
