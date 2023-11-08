import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/receta_model.dart';
import 'package:pantheon/pages/new_receta.dart';
import 'package:pantheon/providers.dart/receta_provider.dart';
import 'package:pantheon/widgets/nutrition_card.dart';
import 'package:pantheon/widgets/nutrition_card_1.dart';
import 'package:provider/provider.dart';

class NutritionPage extends StatelessWidget {
  NutritionPage({super.key});
  bool admin = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green.shade100,
        appBar: AppBar(
          title: const Text('Alimentación', style: TextStyle(fontWeight: FontWeight.bold)), 
          backgroundColor: Colors.green, 
          leading: const Icon(Icons.spa),
          actions: admin ? <Widget> [
            IconButton(
              onPressed: () {
                final route = MaterialPageRoute(
                  builder: (context) => const NewReceta()
                );
                Navigator.push(context, route);
              }, 
              icon: const Icon(Icons.add_box_rounded),
              tooltip: 'Agregar Receta',
            )
          ] 
          : null,
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: ListNutrition(),
        ),
      ),
    );
  }
}

class ListNutrition extends StatelessWidget {
  const ListNutrition({super.key});
  
  void detail (BuildContext context, RecetaProvider recetaProvider, int index) {
    final recetaList = recetaProvider.recetasList;
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(recetaList[index].titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
              const SizedBox(height: 20,),
              const Text("Descripción", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(recetaList[index].descripcion, style: const TextStyle(fontSize: 18),),
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

  void displayDialog(BuildContext context, RecetaProvider recetaProvider, int id) {
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
                recetaProvider.deleteRecetaById(id);
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

    RecetaProvider recetaProvider = Provider.of<RecetaProvider>(context);
    recetaProvider.loadRecetas();
    final recetaList = recetaProvider.recetasList;
    
    return ListView.separated(
      itemCount: recetaList.length,
      separatorBuilder: (_, index) => const SizedBox(height: 10,),
      itemBuilder: (_, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: ListTile(
          leading: const Icon(Icons.spa),
          title: Text(recetaList[index].titulo),
          trailing: PopupMenuButton(
          onSelected: (int i) {
            displayDialog(context, recetaProvider, recetaList[index].id!);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 0, child: Text('Eliminar'),),
          ],
        ),
        onTap: () => detail(context, recetaProvider, index),
        ),
      ),
    );
  }
}

class ListNutrition2 extends StatelessWidget {
  const ListNutrition2 ({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: const <Widget>[
          NutritionCard(
            text1: "Comida Sana", 
            text2: "TdeA",
            imagePath: "lib/images/comida1.jpg", 
            uri1: "tdea.edu.co", uri2: "", uri3: "", uri4: ""
          ),
          NutritionCard(
            text1: "Comida Sana X2", 
            text2: "YouTube",
            imagePath: "lib/images/comida1.jpg", // youtube.com/@tdeatv?si=daAeXqFQBeSmNzC1
            uri1: "youtube.com", uri2: "/@tdeatv", uri3: "", uri4: ""
          ), 
          NutritionCard(
            text1: "Comida Sana X2.1", 
            text2: "YouTube Video",
            imagePath: "lib/images/indianMan.jpg", // youtu.be/94RXQg8f6J0?si=9FzNJ_jq_zybaaWO
            uri1: "youtu.be", uri2: "/94RXQg8f6J0?si=9FzNJ_jq_zybaaWO", uri3: "", uri4: ""
          ),
          NutritionCard(
            text1: "Comida Sana X3 ", 
            text2: "Other 1",
            imagePath: "lib/images/comida1.jpg", 
            uri1: "directoalpaladar.com", uri2: "", uri3: "", uri4: ""
          ),
          NutritionCard(
            text1: "Comida Sana X3.1 ", 
            text2: "Other 2",
            imagePath: "lib/images/comida1.jpg", 
            uri1: "directoalpaladar.com", uri2: "/recetario/101-recetas-sanas-para-para-tener-menu-saludable-lunes-a-domingo", uri3: "", uri4: ""
          ),
          NutritionCard1(
            text1: "Ripio de papa", 
            text2: "'Optional Text...?'", 
            imagePath: "lib/images/sad1.jpg"
          )
        ],
      );
  }
}