import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/receta_provider.dart';
import 'package:provider/provider.dart';

class NewReceta extends StatelessWidget {
  const NewReceta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Agregar Receta', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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

    final RecetaProvider recetaProvider = Provider.of<RecetaProvider>(context);
    return Form(
      key: recetaProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Titulo o nombre de la receta',
              labelText: 'Titulo o Nombre',
              labelStyle: TextStyle( fontSize: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8)
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                recetaProvider.titulo = value;
              } else {
                recetaProvider.titulo = '';
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
              hintText: 'Detalle de la receta',
              labelText: 'Descripción',
              labelStyle: TextStyle( fontSize: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8)
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                recetaProvider.descripcion = value;
              } else {
                recetaProvider.descripcion = '';
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
              if(!recetaProvider.isValidForm()) return;
              recetaProvider.addReceta();
              recetaProvider.resetRecetaData();
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