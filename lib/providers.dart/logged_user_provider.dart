import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/db_provider.dart';

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

  bool esAdmin(){
    if (rol == 'admin') {
      return true;
    }
    else {
      return false;
    }
  }

  updateWeight() async {
    final res = await DBProvider.db.updateWeight(weight!, id!);
    //print('*** updateWeight del PROVIDER: $res'); // retorna 0 si todo es OKAY y -1 si falla
    notifyListeners(); // Para que los cambios se vean
  }

  updateHeight() async {
    final res = await DBProvider.db.updateHeight(height!, id!);
    //print('*** updateWeight del PROVIDER: $res'); // retorna 0 si todo es OKAY y -1 si falla
    notifyListeners(); // Para que los cambios se vean
  }
  
}