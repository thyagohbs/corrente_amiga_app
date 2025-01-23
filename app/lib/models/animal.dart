class Animal {
  final String nome;
  final String especie;
  final String? raca;
  final String? porte;
  final String? sexo;
  final int? idade;
  final String? descricao;
  final String foto;

  Animal({
    required this.nome,
    required this.especie,
    this.raca,
    this.porte,
    this.sexo,
    this.idade,
    this.descricao,
    required this.foto,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      nome: json['nome'],
      especie: json['especie'],
      raca: json['raca'],
      porte: json['porte'],
      sexo: json['sexo'],
      idade: json['idade'],
      descricao: json['descricao'],
      foto: json['foto'],
    );
  }
}
