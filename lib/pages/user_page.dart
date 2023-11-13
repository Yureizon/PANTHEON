import 'package:flutter/material.dart';
import 'package:pantheon/pages/new_training.dart';
import 'package:pantheon/pages/workout_list.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    usersProvider.loadUsers;

    //LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: const Text("Mi perfil", style: TextStyle(fontWeight: FontWeight.bold),),
          actions: <Widget> [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'Home');
              },
              icon: const Icon(Icons.exit_to_app_outlined),
              tooltip: 'Cerrar Sesión',
            )
          ],
          backgroundColor: Colors.lightBlue.shade300,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,),
              child: const Text('Información Basica', style: TextStyle(fontSize: 18),),
              //Text('Información Basica || id del usuario en sesión:${loggedUserProvider.id}', style: TextStyle(fontSize: 18),),
            ),
            const InfoCard(),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    final route = MaterialPageRoute(
                    builder: (context) => const NewTraining()
                    );
                    Navigator.push(context, route);
                  },
                  child: const Center(
                    child: Text('Adicionar\nEntrenamiento', style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                ),
              )
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 18,),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    final route = MaterialPageRoute(
                    builder: (context) => const WorkoutList()
                    );
                    Navigator.push(context, route);
                  },
                  child: const Center(
                    child: Text('Ver Entrenamienos', style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                ),
              )
            ),
          ],
        ),
      )
    );
  }
}

class InfoCard extends StatelessWidget {
  
  const InfoCard({Key? key,
  }) : super(key: key);

  double calcularIMC(double peso, double altura) {
    double imc = peso / (altura * altura);
    return imc;
  }

  String estadoIMC(double imc) {
    if (imc<16) return 'Desnutrición Severa';
    if (imc>16.1 && imc<18.4) return 'Desnutrición Moderada';
    if (imc>18.5 && imc<22) return 'Bajo Peso';
    if (imc>22.1 && imc<24.9) return 'Peso Normal';
    if (imc>25 && imc<29.9) return 'Sobrepeso';
    if (imc>30 && imc<34.9) return 'Obesidad tipo I';
    if (imc>35 && imc<39.9) return 'Obesidad tipo II';
    if (imc>40) return 'Obesidad tipo III';
    return '._.?';
  }

  @override
  Widget build(BuildContext context) {

    LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);

    final double imc = calcularIMC(loggedUserProvider.weight!, loggedUserProvider.height!);

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              ListTile(
                title: const Text('Usuario'),
                subtitle: Text(loggedUserProvider.name, style: const TextStyle(fontSize: 24, color: Colors.black ,fontWeight: FontWeight.bold)),
              ),
              const Divider(height: 15),
              ListTile(
                title: const Text('Peso'),
                subtitle: Text(loggedUserProvider.weight.toString(), style: const TextStyle(fontSize: 24, color: Colors.black ,fontWeight: FontWeight.bold)),
                trailing: popupMenuButton1(context),
              ),
              const Divider(height: 15),
              ListTile(
                title: const Text('Altura'),
                subtitle: Text(loggedUserProvider.height.toString(), style: const TextStyle(fontSize: 24, color: Colors.black ,fontWeight: FontWeight.bold)),
                trailing: popupMenuButton2(context),
              ),
              const Divider(height: 15),
              ListTile(
                title: const Text('IMC (Indice de Masa Corporal)'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(imc.toStringAsFixed(2), style: const TextStyle(fontSize: 24, color: Colors.black ,fontWeight: FontWeight.bold)),
                    Text('Tu IMC indica: ${estadoIMC(imc)}', style: const TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

Widget popupMenuButton1 (context) {
  return PopupMenuButton(
    onSelected: (int i) {
      if (i == 0) {
        _showAddTaskBottomSheet(context);
      }
    },
    itemBuilder: (context) => const [
      PopupMenuItem(value: 0, child: Text("Actualizar"),),
    ],
  );
}

Widget popupMenuButton2 (context) {
  return PopupMenuButton(
    onSelected: (int i) {
      if (i == 0) {
        _showAddTaskBottomSheet2(context);
      }
    },
    itemBuilder: (context) => const [
      PopupMenuItem(value: 0, child: Text("Actualizar"),),
    ],
  );
}

void _showAddTaskBottomSheet(BuildContext context) {

  UsersProvider usersProvider = Provider.of<UsersProvider>(context, listen: false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context, listen: false);

  showModalBottomSheet(
    showDragHandle: true,
    context: context, 
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
         child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text('Peso actual: ${loggedUserProvider.weight}'),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "example: 53.7",
                    labelText: "Peso",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      try {
                        loggedUserProvider.weight = double.parse(value);
                      } catch(e) {
                        print('$e NO ES UN PESO ACEPTABLE');
                      }
                    }
                    else {
                      loggedUserProvider.weight = 0.0;
                    }
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.isNotEmpty) {
                        try {
                          double.parse(value);
                          return null;
                        } catch (e) {
                          return 'Ingresa un número válido.';
                        }
                      } else {
                        return 'El campo no debe estar vacío.';
                      }
                    } else {
                      return 'El campo no debe estar vacío.';
                    }
                  },
                ),
                const SizedBox(height: 15,),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  color: Colors.lightBlue,
                  splashColor: Colors.green,
                  onPressed: () async {

                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!usersProvider.isValidLocalForm(formKey)) return;

                    loggedUserProvider.updateWeight();

                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(),
                    child: const Text('Actualizar', style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
      );
    }
  );
}

void _showAddTaskBottomSheet2(BuildContext context) {

  UsersProvider usersProvider = Provider.of<UsersProvider>(context, listen: false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context, listen: false);

  showModalBottomSheet(
    showDragHandle: true,
    context: context, 
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Text('Altura actual: ${loggedUserProvider.height}'),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "example: 1.72",
                  labelText: "Altura",
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    try {
                      loggedUserProvider.height = double.parse(value);
                    } catch (e) {
                      print('$e NO ES UN DOUBLE');
                    }
                  }
                  else {
                    loggedUserProvider.height = 1.5;
                  }
                },
                validator: (value) {
                  if (value != null) {
                      if (value.isNotEmpty) {
                        try {
                          double.parse(value);
                          return null;
                        } catch (e) {
                          return 'Ingresa un número válido.';
                        }
                      } else {
                        return 'El campo no debe estar vacío.';
                      }
                    } else {
                      return 'El campo no debe estar vacío.';
                    }
                },
              ),
              const SizedBox(height: 15,),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                color: Colors.lightBlue,
                splashColor: Colors.green,
                onPressed: () async {
                  //Quitar teclado al terminar
                  FocusScope.of(context).unfocus();

                  if (!usersProvider.isValidLocalForm(formKey)) return;

                    loggedUserProvider.updateHeight();
                  
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(),
                  child: const Text('Actualizar', style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      );
    }
  );
}