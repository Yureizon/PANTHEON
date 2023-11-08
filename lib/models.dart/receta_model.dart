import 'dart:convert';

Receta recetaFromJson(String str) => Receta.fromJson(json.decode(str));

String recetaToJson(Receta data) => json.encode(data.toJson());

class Receta {
  int? id;
  String titulo;
  String descripcion;

  Receta({
    this.id,
    required this.titulo,
    required this.descripcion,
  });

  factory Receta.fromJson(Map<String, dynamic> json) => Receta(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
      );

      Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
      };
}