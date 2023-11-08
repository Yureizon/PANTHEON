import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/ejercicio_model.dart';
import 'package:pantheon/providers.dart/db_provider.dart';

class EjercicioProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = "create";
  int? id;
  String titulo = '';
  String subtitulo = '';
  String descripcion = '';

  List<Ejercicio>ejercicioList = [];

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<Ejercicio> addEjercicio() async {
    final Ejercicio ejercicio = Ejercicio(titulo: titulo, descripcion: descripcion, subtitulo: subtitulo);

    final id = await DBProvider.db.newEjercicio(ejercicio);
    ejercicio.id = id;
    ejercicioList.add(ejercicio);
    notifyListeners();
    return ejercicio;
  }

  resetEjercicioData(){
    titulo = '';
    subtitulo = '';
    descripcion = '';
  }

  deleteEjercicioById(int id) async {
    final res = await DBProvider.db.deleteEjercicio(id);
    loadEjercicios();
  }

  loadEjercicios() async {
    final List<Ejercicio> ejercicioList = await DBProvider.db.getAllEjercicios();
    this.ejercicioList = [...ejercicioList];
    notifyListeners();
  }

}