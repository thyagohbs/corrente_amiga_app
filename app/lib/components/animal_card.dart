import 'package:app/models/animal.dart';
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;
  final ImageProvider imageProvider;

  const AnimalCard({
    super.key,
    required this.animal,
    required this.imageProvider, // Receber o imageProvider como parâmetro
  });

  @override
  Widget build(BuildContext context) {
    // Remover a linha abaixo
    // final imageProvider = Provider.of<ListaAnimaisScreen>(context).imageProvider;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image(
              image:
                  imageProvider, // Usar o imageProvider recebido como parâmetro
            ),
            title: Text(animal.nome),
            subtitle: Text('${animal.especie} - ${animal.raca}'),
          )
        ],
      ),
    );
  }
}
