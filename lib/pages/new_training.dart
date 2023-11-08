import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/workout_provider.dart';
import 'package:provider/provider.dart';

class NewTraining extends StatelessWidget {
  const NewTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Adicionar Entrenamiento', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _CreateForm()
      ),
    );
  }
}

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    return Form(
      key: workoutProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "example: Espalda, Pierna, Brazo",
              labelText: "Grupo Muscular",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                workoutProvider.grupo = value;
              } else {
                workoutProvider.grupo = '';
              }
            },
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          const SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "example: 16/11/2023",
              labelText: "Fecha",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                workoutProvider.fecha = value;
              } else {
                workoutProvider.fecha = '';
              }
            },
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          /*const SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Sin puntos o comas: 30, 60, 120",
              labelText: "Tiempo de trabajo en minutos",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
          ),*/
          const SizedBox(height: 20,),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.lightBlue,
            splashColor: Colors.green,
            onPressed: (){
              //Quitar teclado al terminar
              FocusScope.of(context).unfocus();
              if(!workoutProvider.isValidForm()) return;
              workoutProvider.addWorkout();
              workoutProvider.resetWorkoutData();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text('Agregar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ),
          )
        ],
      ),
    );
  }
}
