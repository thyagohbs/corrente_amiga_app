import 'package:app/models/animal.dart';
import 'package:flutter/material.dart';

class DetalhesAnimalScreen extends StatelessWidget {
  final Animal animal;

  const DetalhesAnimalScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.nome),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Image.network(
              animal.foto,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.pets, size: 100); // Ícone de fallback
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome: ${animal.nome}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Espécie: ${animal.especie}'),
                  SizedBox(height: 8),
                  Text('Raça: ${animal.raca ?? "Não informada"}'),
                  SizedBox(height: 8),
                  Text('Idade: ${animal.idade ?? "Não informada"}'),
                  SizedBox(height: 8),
                  Text(
                    'Descrição:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(animal.descricao ?? 'Nenhuma descrição disponível.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Entrar em Contato'),
                    content: Text('Formulário de contato aqui...'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Fechar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Entrar em Contato'),
          ),
        ],
      ),
    );
  }
}
