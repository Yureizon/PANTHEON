import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pantheon/pages/all.dart';
import 'package:pantheon/pages/home_page.dart';
import 'package:pantheon/pages/new_ejercicio.dart';
import 'package:pantheon/pages/new_receta.dart';
import 'package:pantheon/pages/new_training.dart';
import 'package:pantheon/pages/sign_in.dart';
import 'package:pantheon/pages/sign_up.dart';
import 'package:pantheon/pages/workout_list.dart';
import 'package:pantheon/providers.dart/ejercicio_provider.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';
import 'package:pantheon/providers.dart/receta_provider.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:pantheon/providers.dart/workout_provider.dart';
import 'package:provider/provider.dart';
//import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp().then((value) => runApp(const NavigationBarApp()));
  runApp(const NavigationBarApp());
} 

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => EjercicioProvider()),
        ChangeNotifierProvider(create: (_) => RecetaProvider()),
        ChangeNotifierProvider(create: (_) => LoggedUserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "Home",
        routes: <String, WidgetBuilder>{
          "Home": (BuildContext context) => HomePage(),
          "SignIn": (BuildContext context) => const SignIn(),
          "SignUp": (BuildContext context) => SignUp(),
          "Navigation": (BuildContext context) => const NavigationExample(),
          "NewTraining": (BuildContext context) => const NewTraining(),
          "WorkoutList": (BuildContext context) => const WorkoutList(),
          "NewEjercicio": (BuildContext context) => const NewEjercicio(),
          "NewReceta": (BuildContext context) => const NewReceta(),
        },
      ),
    );
  }
}
