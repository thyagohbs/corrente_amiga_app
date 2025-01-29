import 'package:app/models/animal.dart';
import 'package:flutter/material.dart';

/// Widget que exibe um card com informações sobre um animal.
///
/// Recebe um [Animal] e um [ImageProvider] para exibir a imagem do animal.
/// Pode ser clicável se um [onTap] for fornecido.
class AnimalCard extends StatelessWidget {
  final Animal animal;
  final ImageProvider imageProvider;
  final bool showDetailsButton;
  final VoidCallback? onTap;

  const AnimalCard({
    super.key,
    required this.animal,
    required this.imageProvider,
    this.showDetailsButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: imageProvider,
                radius: 30,
                child: imageProvider == null ? Icon(Icons.pets) : null,
              ),
              title: Text(
                animal.nome,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${animal.especie} - ${animal.raca}'),
                  Text('Localização: ${animal.localizacao}'),
                  Text(
                    animal.isMissing
                        ? 'Desaparecido'
                        : 'Disponível para adoção',
                    style: TextStyle(
                      color: animal.isMissing ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            if (showDetailsButton)
              OverflowBar(
                children: <Widget>[
                  TextButton(
                    onPressed: onTap,
                    child: Text('Ver detalhes'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
