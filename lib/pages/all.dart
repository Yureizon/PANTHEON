import 'package:flutter/material.dart';
import 'package:pantheon/pages/exercise_page.dart';
import 'package:pantheon/pages/nutrition_page.dart';
import 'package:pantheon/pages/user_page.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

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
        ],
      ),
      body: <Widget>[
        const ExercisesPage(),
        const NutritionPage(),
        const UserPage(),
      ][currentPageIndex],
    );
  }

}