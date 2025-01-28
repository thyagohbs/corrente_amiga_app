import 'package:app/screens/detalhes_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/lista_animais_view_model.dart';
import '../components/animal_card.dart';

class ListaAnimaisScreen extends StatefulWidget {
  final ImageProvider imageProvider;

  const ListaAnimaisScreen({super.key, required this.imageProvider});

  @override
  State<ListaAnimaisScreen> createState() => _ListaAnimaisScreenState();
}

class _ListaAnimaisScreenState extends State<ListaAnimaisScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListaAnimaisViewModel>().buscarAnimais();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animais para Adoção'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ListaAnimaisViewModel>().buscarAnimais();
        },
        child: Consumer<ListaAnimaisViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.carregando) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.erro != null) {
              return Center(child: Text('Erro: ${viewModel.erro}'));
            } else if (viewModel.animais.isEmpty) {
              return const Center(child: Text('Nenhum animal encontrado.'));
            } else {
              return ListView.builder(
                itemCount: viewModel.animais.length,
                itemBuilder: (context, index) {
                  final animal = viewModel.animais[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalhesAnimalScreen(animal: animal),
                        ),
                      );
                    },
                    child: AnimalCard(
                      animal: animal,
                      imageProvider: widget.imageProvider,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
