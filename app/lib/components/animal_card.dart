import 'package:app/models/animal.dart';
import 'package:app/screens/lista_animais_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;

  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    final imageProvider =
        Provider.of<ListaAnimaisScreen>(context).imageProvider;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image(
              image: imageProvider,
            ),
            title: Text(animal.nome),
            subtitle: Text('${animal.especie} - ${animal.raca}'),
          )
        ],
      ),
    );
  }
}
