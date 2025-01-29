import 'package:app/models/animal.dart';
import 'package:flutter/material.dart';

/// Widget que exibe um card com informações sobre um animal.
///
/// Recebe um [Animal] e um [ImageProvider] para exibir a imagem do animal.
/// Pode ser clicável se um [onTap] for fornecido.
class AnimalCard extends StatelessWidget {
  final Animal animal;
  final ImageProvider? imageProvider;
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
    final Color statusColor = animal.isMissing ? Colors.red : Colors.green;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: imageProvider,
                onBackgroundImageError: (_, __) {
                  // Não retorna nada aqui, pois o callback não permite retorno
                },
                child: imageProvider == null
                    ? Icon(Icons.pets, size: 40, color: Colors.grey)
                    : null, // Fallback para quando a imagem falhar
              ),
              title: Flexible(
                child: Text(
                  animal.nome,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${animal.especie} - ${animal.raca ?? "Não informada"}'),
                  Text('Idade: ${animal.idade ?? "Não informada"}'),
                  Text('Localização: ${animal.localizacao ?? "Não informada"}'),
                  Text(
                    animal.isMissing
                        ? 'Desaparecido'
                        : 'Disponível para adoção',
                    style: TextStyle(color: statusColor),
                  ),
                ],
              ),
            ),
            if (showDetailsButton)
              OverflowBar(
                alignment: MainAxisAlignment.end,
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
