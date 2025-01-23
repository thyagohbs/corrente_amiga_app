import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/lista_animais_view_model.dart';
import '../components/animal_card.dart';

class ListaAnimaisScreen extends StatefulWidget {
  const ListaAnimaisScreen({Key? key}) : super(key: key);

  @override
  State<ListaAnimaisScreen> createState() => _ListaAnimaisScreenState();
}

class _ListaAnimaisScreenState extends State<ListaAnimaisScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListaAnimaisViewModel>(context, listen: false)
          .buscarAnimais();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animais para Adoção'),
      ),
      body: Consumer<ListaAnimaisViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.carregando) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.carregando) {
            return Center(child: Text('Erro: ${viewModel.erro}'));
          } else if (viewModel.animais.isEmpty) {
            return const Center(child: Text('Nenhum animal encontrado.'));
          } else {
            return ListView.builder(
              itemCount: viewModel.animais.length,
              itemBuilder: (context, index) {
                final animal = viewModel.animais[index];
                return AnimalCard(animal: animal);
              },
            );
          }
        },
      ),
    );
  }
}
