import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantheon/pages/exercise_page.dart';
import 'package:pantheon/pages/nutrition_page.dart';
import 'package:pantheon/pages/phantheon_page.dart';
import 'package:pantheon/pages/user_page.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  /*
  @override
  void initState(){
    super.initState();
    getUsers();
  }

  void getUsers() async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("Users");
    QuerySnapshot users = await collectionReference.get();
    
    if (users.docs.isEmpty == false){
      for (var doc in users.docs) {
        print(doc.data());
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightGreenAccent[400],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          /*NavigationDestination(
            selectedIcon: Icon(Icons.account_balance),
            icon: Icon(Icons.account_balance_outlined),
            label: 'Rutinas',
          ),*/
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Ejercicios',
          ),
          NavigationDestination(
            icon: Icon(Icons.apple),
            label: 'Nutrición',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Yo',
          ),
          /*NavigationDestination(
            icon: Icon(Icons.energy_savings_leaf), 
            label: 'Pruebas')*/
        ],
      ),
      body: <Widget>[
        //fondologin()
        //const PhantheonPage(),
        ExercisesPage(),
        NutritionPage(),
        const UserPage(),
      ][currentPageIndex],
    );
  }








  Widget loginTitle(){
    return const Text("Sign in", style: TextStyle( color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold));
  }

  Widget campoUsuario(){
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: const TextField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "User",
          fillColor: Colors.white30,
          filled: true
        ),
      ),
    );
  }

  Widget campoPassword(){
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Password",
          fillColor: Colors.white30,
          filled: true
        ),
      ),
    );
  }

  Widget buttonSignIn(){
    return FloatingActionButton(

      splashColor: Colors.green,
      backgroundColor: Colors.amber,
      onPressed: (){},
      child: const Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold),),
      );
  }

  Widget fondologin(){
    return Container(
      decoration: const BoxDecoration(
        //image: DecorationImage(image: NetworkImage("https://i.pinimg.com/originals/bb/2d/4a/bb2d4adde42ca01f0ae4eb40c95058f0.jpg"),
        //fit: BoxFit.cover)
        image: DecorationImage(image: AssetImage("lib/images/fondosesion1.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginTitle(),
            campoUsuario(),
            campoPassword(),
            const SizedBox(height: 20.0,),
            buttonSignIn(),
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ],
        ),
      )
    );
  }

  Widget login(){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            //onChanged: ((value) {},
          ),
          TextField(),
          ElevatedButton(onPressed: null,
          child: Text('Sign In'))
        ],
      )
    );
  }

}