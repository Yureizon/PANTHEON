import 'package:flutter/material.dart';
import 'package:pantheon/pages/new_training.dart';
import 'package:pantheon/pages/workout_list.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    usersProvider.loadUsers;

    LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);

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
              child: Text('Información Basica || id del usuario en sesión:${loggedUserProvider.id}', style: TextStyle(fontSize: 18),),
            ),
            const InfoCard(index: 0),
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
            //_listUsers(),
          ],
        ),
        /*floatingActionButton: IconButton(
        onPressed: () async {
          usersProvider.loadUsers();
        }, 
        icon: const Icon(Icons.restart_alt),
        iconSize: 40,
        tooltip: "Refresh List",
        splashColor: Colors.green,
      ),*/
      )
    );
  }
}

class _listUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    final users = usersProvider.users;

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.person),
        title: Text(users[index].name),
        subtitle: Text(users[index].password),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {

  final int index;
  
  const InfoCard({Key? key,
    required this.index,
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

    UsersProvider usersProvider = Provider.of<UsersProvider>(context);

    LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);

    final users = usersProvider.users;
    final double imc = calcularIMC(loggedUserProvider.weight!, loggedUserProvider.height!);

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        //splashColor: Colors.blue,
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
  final users = usersProvider.users;
  showModalBottomSheet(
    showDragHandle: true,
    context: context, 
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
         child: Form(
            key: usersProvider.formKeyUsers3,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text('Peso actual: ${users[0].weight}'),
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
                      usersProvider.weight = double.parse(value);
                    }
                    else {
                      usersProvider.weight = 0.0;
                    }
                  },
                  validator: (value) {
                    return value != '' ? null : 'The field must not be empty';
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

                    if (!usersProvider.isValidForm()) return;
                    usersProvider.name = usersProvider.name;
                    usersProvider.password = usersProvider.password;
                    usersProvider.height = usersProvider.height;
                    usersProvider.updateUser();
                    usersProvider.isLoading = false;
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(usersProvider.isLoading ? 'Espere' : 'Actualizar', style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
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
  final users = usersProvider.users;
  showModalBottomSheet(
    showDragHandle: true,
    context: context, 
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: usersProvider.formKeyUsers,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Text('Altura actual: ${users[0].weight}'),
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
                    usersProvider.height = double.parse(value);
                  }
                  else {
                    usersProvider.height = 1.5;
                  }
                },
                validator: (value) {
                  return value != '' ? null : 'The field must not be empty';
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

                  if (!usersProvider.isValidForm()) return;
                  usersProvider.name = usersProvider.name;
                  usersProvider.password = usersProvider.password;
                  usersProvider.weight = usersProvider.weight;
                  usersProvider.updateUser();
                  usersProvider.isLoading = false;
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(),
                  child: Text(usersProvider.isLoading ? 'Espere' : 'Actualizar', style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      );
    }
  );
}