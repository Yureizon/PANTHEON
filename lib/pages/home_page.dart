import 'package:flutter/material.dart';
import 'package:pantheon/pages/sign_in.dart';
import 'package:pantheon/pages/sign_up.dart';

class HomePage extends  StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/images/fondosesion1.jpg"), fit: BoxFit.cover),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 200),
            children:  <Widget>[
              const Text("WELCOME TO", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
              const Text("PANTHEON", style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
              const Divider(height: 20.0,),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: TextButton(
                  // Parametros para los botones flotantes
                  //splashColor: Colors.green,
                  //backgroundColor: Colors.amber,
                  style: const ButtonStyle( 
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                    splashFactory: InkRipple.splashFactory,
                  ),
                  onPressed: (){
                    final route = MaterialPageRoute(
                      builder: (context) => const SignIn());
                      Navigator.push(context, route);
                  },
                  child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ),
              const Divider(height: 20.0,),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: TextButton(
                  // Parametros para los botones flotantes
                  //splashColor: Colors.green,
                  //backgroundColor: Colors.amber,
                  style: const ButtonStyle( 
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                    splashFactory: InkRipple.splashFactory,
                  ),
                  onPressed: (){
                    final route = MaterialPageRoute(
                      builder: (context) => const SignUp());
                      Navigator.push(context, route);
                  },
                  child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              )
            ],
          )
        ),
      );
  }



}