import 'dart:convert';

Ejercicio ejercicioFromJson(String str) => Ejercicio.fromJson(json.decode(str));

String ejercicioToJson(Ejercicio data) => json.encode(data.toJson());

class Ejercicio {
  int? id;
  String titulo;
  String subtitulo;
  String descripcion;

  Ejercicio({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.subtitulo,
  });

  factory Ejercicio.fromJson(Map<String, dynamic> json) => Ejercicio(
        id: json["id"],
        titulo: json["titulo"],
        subtitulo: json["subtitulo"],
        descripcion: json["descripcion"],
      );

      Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "descripcion": descripcion,
      };
}