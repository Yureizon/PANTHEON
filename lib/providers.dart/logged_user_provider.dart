import 'package:flutter/material.dart';

class LoggedUserProvider extends ChangeNotifier {
  int? id;
  String name = '';
  String password = '';
  double? weight;
  double? height;
  String rol = '';

  isLogged(id, name, password, weight, height, rol){
    this.id = id;
    this.name = name;
    this.password = password;
    this.weight = weight;
    this.height = height;
    this.rol = rol;
  }

  clear(){
    id = 0;
    name = '';
    password = '';
    weight = 0;
    height = 0;
    rol = '';
  }
  
}