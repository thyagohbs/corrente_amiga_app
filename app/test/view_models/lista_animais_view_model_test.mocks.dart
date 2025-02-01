// Mocks generated by Mockito 5.4.5 from annotations
// in app/test/view_models/lista_animais_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:app/models/animal.dart' as _i6;
import 'package:app/screens/services/api_service.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i3.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(this, Invocation.getter(#client)),
      ) as _i2.Client);

  @override
  _i4.Future<void> registrarUsuario(
    String? nome,
    String? email,
    String? senha,
  ) =>
      (super.noSuchMethod(
        Invocation.method(#registrarUsuario, [nome, email, senha]),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String> login(String? email, String? senha) => (super.noSuchMethod(
        Invocation.method(#login, [email, senha]),
        returnValue: _i4.Future<String>.value(
          _i5.dummyValue<String>(
            this,
            Invocation.method(#login, [email, senha]),
          ),
        ),
      ) as _i4.Future<String>);

  @override
  _i4.Future<List<_i6.Animal>> buscarAnimais(String? token) =>
      (super.noSuchMethod(
        Invocation.method(#buscarAnimais, [token]),
        returnValue: _i4.Future<List<_i6.Animal>>.value(<_i6.Animal>[]),
      ) as _i4.Future<List<_i6.Animal>>);

  @override
  _i4.Future<void> atualizarAnimal(String? token, _i6.Animal? animal) =>
      (super.noSuchMethod(
        Invocation.method(#atualizarAnimal, [token, animal]),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> excluirAnimal(String? token, int? animalId) =>
      (super.noSuchMethod(
        Invocation.method(#excluirAnimal, [token, animalId]),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> uploadFoto(String? token, int? animalId, String? filePath) =>
      (super.noSuchMethod(
        Invocation.method(#uploadFoto, [token, animalId, filePath]),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<dynamic> post(String? endpoint, Map<String, dynamic>? body) =>
      (super.noSuchMethod(
        Invocation.method(#post, [endpoint, body]),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<dynamic> get(String? endpoint, {String? token}) =>
      (super.noSuchMethod(
        Invocation.method(#get, [endpoint], {#token: token}),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}
