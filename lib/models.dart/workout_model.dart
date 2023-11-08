// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Workout workoutFromJson(String str) => Workout.fromJson(json.decode(str));

String workoutToJson(Workout data) => json.encode(data.toJson());

class Workout {
  int? id;
  String fecha;
  String grupo;

  Workout({
    this.id,
    required this.fecha,
    required this.grupo,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json["id"],
        fecha: json["fecha"],
        grupo: json["grupo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "grupo": grupo,
      };
}