import 'package:flutter/material.dart';
import 'package:app/models/animal.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'package:provider/provider.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;
  final ImageProvider? imageProvider; // Torna o parâmetro opcional
  final bool showDetailsButton;
  final VoidCallback? onTap;

  const AnimalCard({
    super.key,
    required this.animal,
    this.imageProvider, // Agora é opcional
    this.showDetailsButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListaAnimaisViewModel>(context);

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
                onBackgroundImageError: (_, __) {},
                child: imageProvider == null
                    ? Icon(Icons.pets, size: 40, color: Colors.grey)
                    : null,
              ),
              title: Text(
                animal.nome.isNotEmpty ? animal.nome : 'Sem nome',
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${animal.especie ?? "Espécie não informada"} - ${animal.raca ?? "Não informada"}'),
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
              trailing: IconButton(
                icon: Icon(
                  viewModel.favoritos.contains(animal.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  viewModel.toggleFavorito(animal.id);
                },
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
