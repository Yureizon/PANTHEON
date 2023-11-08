import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/ejercicio_provider.dart';
import 'package:provider/provider.dart';

class NewEjercicio extends StatelessWidget {
  const NewEjercicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        title: const Text('Agregar Ejercicio', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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

    final EjercicioProvider ejercicioProvider = Provider.of<EjercicioProvider>(context);
    return Form(
      key: ejercicioProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'example: Remo con Mancuernas',
              labelText: 'Nombre del Ejercicio',
              labelStyle: TextStyle( fontSize: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8)
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                ejercicioProvider.titulo = value;
              } else {
                ejercicioProvider.titulo = '';
              }
            },
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          const SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'example: Espalda',
              labelText: 'Grupo Muscular',
              labelStyle: TextStyle( fontSize: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8)
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                ejercicioProvider.subtitulo = value;
              } else {
                ejercicioProvider.subtitulo = '';
              }
            },
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          const SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            maxLines: 20,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'example: Espalda',
              labelText: 'Descipción',
              labelStyle: TextStyle( fontSize: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8)
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                ejercicioProvider.descripcion = value;
              } else {
                ejercicioProvider.descripcion = '';
              }
            },
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          const SizedBox(height: 20,),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.lightBlue,
            splashColor: Colors.green,
            onPressed: (){
              //Quitar teclado al terminar
              FocusScope.of(context).unfocus();
              if(!ejercicioProvider.isValidForm()) return;
              ejercicioProvider.addEjercicio();
              ejercicioProvider.resetEjercicioData();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text('Agregar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}