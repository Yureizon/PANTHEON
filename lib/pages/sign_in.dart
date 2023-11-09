import 'package:flutter/material.dart';
import 'package:pantheon/widgets/login_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/images/fondosesion1.jpg"), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 200),
          children: <Widget> [
            const Text("WELCOME TO", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
            const Text("PANTHEON", style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
            const Text("Sign In", style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.amber), textAlign: TextAlign.center,),
            const Divider(height: 30.0,),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}