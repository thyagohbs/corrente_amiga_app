import 'package:url_launcher/url_launcher.dart';

enum Porte { pequeno, medio, grande }

enum Sexo { macho, femea }

class Animal {
  final String nome;
  final String especie;
  final String? raca;
  final Porte? porte;
  final Sexo? sexo;
  final int? idade;
  final String? descricao;
  final String foto;
  final String localizacao;
  final double? latitude;
  final double? longitude;
  final bool isMissing;
  final DateTime? dataCadastro;

  Animal({
    required this.nome,
    required this.especie,
    this.raca,
    this.porte,
    this.sexo,
    this.idade,
    this.descricao,
    required this.foto,
    required this.localizacao,
    this.latitude,
    this.longitude,
    this.isMissing = false,
    DateTime? dataCadastro,
  })  : dataCadastro = dataCadastro ?? DateTime.now(),
        assert(nome.isNotEmpty, 'O nome não pode estar vazio.'),
        assert(especie.isNotEmpty, 'A espécie não pode estar vazia.'),
        assert(Uri.parse(foto).isAbsolute, 'A foto deve ser uma URL válida.');

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      nome: json['nome'] ?? 'Sem nome',
      especie: json['especie'] ?? 'Sem espécie',
      raca: json['raca'],
      porte: json['porte'] != null ? Porte.values.byName(json['porte']) : null,
      sexo: json['sexo'] != null ? Sexo.values.byName(json['sexo']) : null,
      idade: json['idade'],
      descricao: json['descricao'],
      foto: json['foto'] ?? 'assets/placeholder.png',
      localizacao: json['localizacao'] ?? 'Localização desconhecida',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      isMissing: json['isMissing'] ?? false,
      dataCadastro: json['dataCadastro'] != null
          ? DateTime.parse(json['dataCadastro'])
          : null,
    );
  }

  get id => null;

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'especie': especie,
      'raca': raca,
      'porte': porte?.name,
      'sexo': sexo?.name,
      'idade': idade,
      'descricao': descricao,
      'foto': foto,
      'localizacao': localizacao,
      'latitude': latitude,
      'longitude': longitude,
      'isMissing': isMissing,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  Animal copyWith({
    String? nome,
    String? especie,
    String? raca,
    Porte? porte,
    Sexo? sexo,
    int? idade,
    String? descricao,
    String? foto,
    String? localizacao,
    double? latitude,
    double? longitude,
    bool? isMissing,
    DateTime? dataCadastro,
  }) {
    return Animal(
      nome: nome ?? this.nome,
      especie: especie ?? this.especie,
      raca: raca ?? this.raca,
      porte: porte ?? this.porte,
      sexo: sexo ?? this.sexo,
      idade: idade ?? this.idade,
      descricao: descricao ?? this.descricao,
      foto: foto ?? this.foto,
      localizacao: localizacao ?? this.localizacao,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isMissing: isMissing ?? this.isMissing,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }
}
