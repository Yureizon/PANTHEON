import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';
import 'package:pantheon/providers.dart/workout_provider.dart';
import 'package:provider/provider.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: const Text('Historial de Entrenamientos', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _List()
      ),
    );
  }
}

class _List extends StatelessWidget {

  void displayDialog(BuildContext context, WorkoutProvider workoutProvider, int id) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text("ALERTA"),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("¿Quieres eliminar permanentemente este registro?"),
              SizedBox(height: 10,)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancerl"),
            ),
            TextButton(
              onPressed: () {
                workoutProvider.deleteWorkoutById(id);
                Navigator.pop(context);
              },
              child: const Text("Yes!"),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);

    workoutProvider.userId = loggedUserProvider.id!;

    workoutProvider.loadWorkouts();
    final workoutLis = workoutProvider.workoutList;
    
    return ListView.builder(
      itemCount: workoutLis.length,
      itemBuilder: (_, index) { 
        // Invierte la lista y muestra los últimos elementos primero
        final reversedIndex = workoutLis.length - 1 - index;
        return ListTile(
          leading: const Icon(Symbols.exercise_rounded),
          title: Text(workoutLis[reversedIndex].grupo),
          subtitle: Text(workoutLis[reversedIndex].fecha),
          trailing: PopupMenuButton(
            onSelected: (int i) {
              displayDialog(context, workoutProvider, workoutLis[reversedIndex].id!);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 0, child: Text('Eliminar'),),
            ],
          ),
        );
      }
    );
  }
}