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
      body: SingleChildScrollView(
        // Para permitir rolagem se o conteúdo for muito grande
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do animal
              Center(
                child: Image.network(
                  animal.foto,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Nome: ${animal.nome}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Espécie: ${animal.especie}'),
              const SizedBox(height: 8),
              Text('Raça: ${animal.raca}'),
              const SizedBox(height: 8),
              Text('Idade: ${animal.idade}'),
              const SizedBox(height: 8),
              const Text(
                'Descrição:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(animal.descricao ?? ''), // Descrição pode ser nula
              const SizedBox(height: 16),

              // Botão de contato
              ElevatedButton(
                onPressed: () {
                  // Lógica para entrar em contato com o responsável
                },
                child: const Text('Entrar em Contato'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
