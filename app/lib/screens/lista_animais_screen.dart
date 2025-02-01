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
  final TextEditingController _searchController = TextEditingController();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por localização',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<ListaAnimaisViewModel>().filtrarAnimais(query);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<ListaAnimaisViewModel>().buscarAnimais();
              },
              child: Consumer<ListaAnimaisViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.carregando) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (viewModel.erro != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Erro ao carregar animais!'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ListaAnimaisViewModel>()
                                  .buscarAnimais();
                            },
                            child: const Text('Tentar Novamente'),
                          ),
                        ],
                      ),
                    );
                  } else if (viewModel.animais.isEmpty) {
                    return const Center(
                      child: Text(
                          'Nenhum animal disponível para adoção no momento.'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: viewModel.animais.length,
                      itemBuilder: (context, index) {
                        final animal = viewModel.animais[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      DetalhesAnimalScreen(animal: animal),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AnimalCard(
                                animal: animal,
                                imageProvider: widget.imageProvider,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
