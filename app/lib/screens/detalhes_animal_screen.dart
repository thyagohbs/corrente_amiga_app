import 'package:app/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DetalhesAnimalScreen extends StatelessWidget {
  final Animal animal;

  const DetalhesAnimalScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(animal.nome),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                animal.foto,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.pets, size: 100, color: theme.primaryColor);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome: ${animal.nome}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Espécie: ${animal.especie}'),
                  const SizedBox(height: 8),
                  Text('Raça: ${animal.raca ?? "Não informada"}'),
                  const SizedBox(height: 8),
                  Text('Idade: ${animal.idade ?? "Não informada"}'),
                  const SizedBox(height: 8),
                  Text('Localização: ${animal.localizacao}'),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final query = Uri.encodeComponent(animal.localizacao);
                      final url =
                          'https://www.google.com/maps/search/?api=1&query=$query';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Não foi possível abrir o mapa.')),
                        );
                      }
                    },
                    icon: Icon(Icons.map),
                    label: Text('Ver no Mapa'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Descrição:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(animal.descricao ?? 'Nenhuma descrição disponível.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Share.share(
                    'Olha este animal disponível para adoção: ${animal.nome} (${animal.especie})\n${animal.descricao}\nFoto: ${animal.foto}',
                  );
                },
                icon: Icon(Icons.share),
                label: Text('Compartilhar'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String mensagem = '';
                      return AlertDialog(
                        title: Text('Entre em Contato'),
                        content: TextField(
                          decoration: InputDecoration(
                            labelText: 'Mensagem',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => mensagem = value,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (mensagem.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Mensagem enviada!')),
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Enviar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.message),
                label: Text('Contato'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
