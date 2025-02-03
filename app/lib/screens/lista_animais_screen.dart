import 'package:app/components/filtro_animais.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final viewModel =
        Provider.of<ListaAnimaisViewModel>(context, listen: false);
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !viewModel.carregando) {
      viewModel.buscarAnimais();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListaAnimaisViewModel>(context);

    if (viewModel.carregando && viewModel.animais.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.erro != null) {
      return Center(child: Text(viewModel.erro!));
    }

    return Column(
      children: [
        FiltroAnimais(
          onFiltrar: (especie, localizacao) {
            viewModel.aplicarFiltros(
                especie: especie, localizacao: localizacao);
          },
        ),
        Expanded(
          child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  viewModel.animais.length + (viewModel.carregando ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < viewModel.animais.length) {
                  final animal = viewModel.animais[index];
                  return AnimalCard(
                    animal: animal,
                    imageProvider: widget.imageProvider,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetalhesAnimalScreen(animal: animal),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
