import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pantheon/pages/new_ejercicio.dart';
import 'package:pantheon/providers.dart/ejercicio_provider.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';
import 'package:provider/provider.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});
  

  @override
  Widget build(BuildContext context) {

    final LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);
    bool admin = loggedUserProvider.esAdmin();
    
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Ejercicios', style: TextStyle(fontWeight: FontWeight.bold)), 
          backgroundColor: Colors.amber.shade400, 
          leading: const Icon(Symbols.exercise_rounded),
          actions: admin ? <Widget> [
            IconButton(
              onPressed: () {
                final route = MaterialPageRoute(
                  builder: (context) => const NewEjercicio()
                );
                Navigator.push(context, route);
              }, 
              icon: const Icon(Icons.add_box_rounded),
              tooltip: 'Agregar Ejercicio',
            )
          ] 
          : null,
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: ListTileExample(),
        ),
      ),
    );
  }
}

class ListTileExample extends StatelessWidget {
  const ListTileExample({super.key});

  void detail (BuildContext context, EjercicioProvider ejercicioProvider, int index) {
    final ejercicioList = ejercicioProvider.ejercicioList; 
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(ejercicioList[index].titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
              const SizedBox(height: 15,),
              Text.rich(
                TextSpan(
                  style: const TextStyle(fontSize: 18),
                  children: <TextSpan> [
                    const TextSpan(text: "Grupo Muscular: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ejercicioList[index].subtitulo),
                  ]
                )
              ),
              const SizedBox(height: 20,),
              const Text("Descripción", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(ejercicioList[index].descripcion, style: const TextStyle(fontSize: 18),),
              TextButton(
                onPressed:() => Navigator.of(context).pop(), child: const Text("Okay", style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                )
            ],
          ),
        );
      }
    );
  }

  void displayDialog(BuildContext context, EjercicioProvider ejercicioProvider, int id) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text("WARNING"),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to permanently delete the registry?"),
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
                ejercicioProvider.deleteEjercicioById(id);
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

    EjercicioProvider ejercicioProvider = Provider.of<EjercicioProvider>(context);
    ejercicioProvider.loadEjercicios();
    final ejerciciosList = ejercicioProvider.ejercicioList;

    final LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);
    bool admin = loggedUserProvider.esAdmin();
    
    return ListView.separated(
      itemCount: ejerciciosList.length,
      separatorBuilder: (_, index) => const SizedBox(height: 15,),
      itemBuilder: (_, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: ListTile(
          leading: const Icon(Symbols.exercise_rounded),
          title: Text(ejerciciosList[index].titulo),
          subtitle: Text(ejerciciosList[index].subtitulo),
          trailing: admin ? PopupMenuButton(
          onSelected: (int i) {
            displayDialog(context, ejercicioProvider, ejerciciosList[index].id!);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 0, child: Text('Eliminar'),),
          ],
        ) : null,
        onTap: () => detail(context, ejercicioProvider, index),
        ),
      ),
    );
  }
}

