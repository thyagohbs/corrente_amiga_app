import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:app/services/api_service.dart';

class CadastroScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nome',
                decoration: InputDecoration(labelText: 'Nome'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Campo obrigatório'),
                ]),
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Campo obrigatório'),
                  FormBuilderValidators.email(errorText: 'E-mail inválido'),
                ]),
              ),
              FormBuilderTextField(
                name: 'senha',
                decoration: InputDecoration(labelText: 'Senha'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Campo obrigatório'),
                  FormBuilderValidators.minLength(6,
                      errorText: 'Mínimo de 6 caracteres')
                ]),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final values = _formKey.currentState!.value;
                    try {
                      await apiService.registrarUsuario(
                        values['nome'],
                        values['email'],
                        values['senha'],
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Usuário cadastrado com sucesso!'),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao cadastrar: $e'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
