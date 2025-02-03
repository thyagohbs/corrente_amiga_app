import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/components/animal_card.dart';
import 'package:app/components/filtro_animais.dart';
import 'package:app/view_models/lista_animais_view_model.dart';
import 'detalhes_animal_screen.dart';

class ListaAnimaisScreen extends StatelessWidget {
  final ImageProvider imageProvider;

  const ListaAnimaisScreen({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListaAnimaisViewModel>(
      create: (_) => ListaAnimaisViewModel(apiService: ApiService())
        ..carregarFavoritos(), // Carrega os favoritos ao inicializar
      child: _ListaAnimaisScreenState(imageProvider: imageProvider),
    );
  }
}

class _ListaAnimaisScreenState extends StatefulWidget {
  final ImageProvider imageProvider;

  const _ListaAnimaisScreenState({required this.imageProvider});

  @override
  State<_ListaAnimaisScreenState> createState() =>
      _ListaAnimaisScreenStateState();
}

class _ListaAnimaisScreenStateState extends State<_ListaAnimaisScreenState> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final viewModel =
        Provider.of<ListaAnimaisViewModel>(context, listen: false);
    if (_scrollController.position.pixels >=
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
            },
          ),
        ),
      ],
    );
  }
}
