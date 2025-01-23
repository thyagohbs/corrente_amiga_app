import 'package:app/models/animal.dart';
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;

  const AnimalCard({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(animal.foto),
            title: Text(animal.nome),
            subtitle: Text('${animal.especie} - ${animal.raca}'),
          )
        ],
      ),
    );
  }
}
