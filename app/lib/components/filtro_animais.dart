import 'package:flutter/material.dart';

class FiltroAnimais extends StatelessWidget {
  final Function(String?, String?) onFiltrar;

  const FiltroAnimais({super.key, required this.onFiltrar});

  @override
  Widget build(BuildContext context) {
    final TextEditingController especieController = TextEditingController();
    final TextEditingController localizacaoController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: especieController,
            decoration: InputDecoration(
              labelText: 'Filtrar por espécie',
            ),
          ),
          TextField(
            controller: localizacaoController,
            decoration: InputDecoration(
              labelText: 'Filtrar por localização',
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              onFiltrar(
                especieController.text.isNotEmpty
                    ? especieController.text
                    : null,
                localizacaoController.text.isNotEmpty
                    ? localizacaoController.text
                    : null,
              );
            },
            child: Text('Aplicar filtros'),
          ),
        ],
      ),
    );
  }
}
