import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/workout_model.dart';
import 'package:pantheon/providers.dart/db_provider.dart';

class WorkoutProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = "create";
  int? id;
  String fecha = '';
  String grupo = '';

  List<Workout>workoutList = [];

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<Workout> addWorkout() async {
    final Workout workout = Workout(fecha: fecha, grupo: grupo);

    final id = await DBProvider.db.newWorkout(workout);
    workout.id = id;
    workoutList.add(workout);
    notifyListeners();
    return workout;
  }

  resetWorkoutData(){
    fecha = '';
    grupo = '';
  }

  deleteWorkoutById(int id) async {
    final res = await DBProvider.db.deleteWorkout(id);
    loadWorkouts();
  }

  loadWorkouts() async {
    final List<Workout> workoutList = await DBProvider.db.getAllWorkouts();
    this.workoutList = [...workoutList];
    notifyListeners();
  }

}