// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

GeneralUser generalUserFromJson(String str) => GeneralUser.fromJson(json.decode(str));

String generalUserToJson(GeneralUser data) => json.encode(data.toJson());

class GeneralUser {
  int? id;
  String name;
  String password;
  double? weight;
  double? height;
  String? rol;

  GeneralUser({
    this.id,
    required this.name,
    required this.password,
    this.weight,
    this.height,
    this.rol
  });

  factory GeneralUser.fromJson(Map<String, dynamic> json) => GeneralUser(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        weight: json["weight"],
        height: json["height"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "weight": weight,
        "height": height,
        "rol": rol,
      };
}