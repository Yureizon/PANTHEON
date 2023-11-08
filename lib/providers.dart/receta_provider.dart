import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/receta_model.dart';
import 'package:pantheon/providers.dart/db_provider.dart';

class RecetaProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = "create";
  int? id;
  String titulo = '';
  String descripcion = '';

  List<Receta>recetasList = [];

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<Receta> addReceta() async {
    final Receta receta = Receta(titulo: titulo, descripcion: descripcion);

    final id = await DBProvider.db.newReceta(receta);
    receta.id = id;
    recetasList.add(receta);
    notifyListeners();
    return receta;
  }

  resetRecetaData(){
    titulo = '';
    descripcion = '';
  }

  deleteRecetaById(int id) async {
    final res = await DBProvider.db.deleteReceta(id);
    loadRecetas();
  }

  loadRecetas() async {
    final List<Receta> recetasList = await DBProvider.db.getAllRecetas();
    this.recetasList = [...recetasList];
    notifyListeners();
  }
  
}