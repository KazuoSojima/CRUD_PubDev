import 'dart:convert';

class Carros {
  String carro;

  Carros({
    required this.carro,
  });

  Map<String, dynamic> toMap() {
    return {
      'carro': carro,
    };
  }

  factory Carros.fromMap(Map<String, dynamic> map) {
    return Carros(
      carro: map['carro'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Carros.fromJson(String source) => Carros.fromMap(json.decode(source));
}
