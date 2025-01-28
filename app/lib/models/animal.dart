/// Representa um animal no sistema.
///
/// Contém informações como nome, espécie, raça, foto, etc.
class Animal {
  final String nome;
  final String especie;
  final String? raca;
  final String? porte;
  final String? sexo;
  final int? idade;
  final String? descricao;
  final String foto;
  final String localizacao;
  final bool isMissing;
  final DateTime? dataCadastro;

  /// Construtor da classe Animal.
  ///
  /// [nome] e [especie] são obrigatórios.
  /// [foto] deve ser uma URL ou caminho de arquivo válido.
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
    this.isMissing = false,
    this.dataCadastro,
  })  : assert(nome.isNotEmpty, 'O nome não pode estar vazio.'),
        assert(especie.isNotEmpty, 'A espécie não pode estar vazia.'),
        assert(foto.isNotEmpty, 'A foto não pode estar vazia.');

  /// Converte um mapa JSON em um objeto Animal.
  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      nome: json['nome'] ?? 'Sem nome',
      especie: json['especie'] ?? 'Sem espécie',
      raca: json['raca'],
      porte: json['porte'],
      sexo: json['sexo'],
      idade: json['idade'],
      descricao: json['descricao'],
      foto: json['foto'] ?? 'assets/placeholder.png',
      localizacao: json['localizacao'] ?? 'Localização desconhecida',
      isMissing: json['isMissing'] ?? false,
      dataCadastro: json['dataCadastro'] != null
          ? DateTime.parse(json['dataCadastro'])
          : null,
    );
  }

  /// Converte o objeto Animal em um mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'especie': especie,
      'raca': raca,
      'porte': porte,
      'sexo': sexo,
      'idade': idade,
      'descricao': descricao,
      'foto': foto,
      'localizacao': localizacao,
      'isMissing': isMissing,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  /// Cria uma cópia do objeto Animal com alterações opcionais.
  Animal copyWith({
    String? nome,
    String? especie,
    String? raca,
    String? porte,
    String? sexo,
    int? idade,
    String? descricao,
    String? foto,
    String? localizacao,
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
      isMissing: isMissing ?? this.isMissing,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }
}
