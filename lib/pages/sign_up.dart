import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
            const Text("Sign Up", style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.teal), textAlign: TextAlign.center,),
            CreateForm(),
            const Divider(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.keyboard_backspace),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CreateForm extends StatelessWidget {
  CreateForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UsersProvider usersProvider = Provider.of<UsersProvider>(context);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget> [
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              initialValue: '',
              decoration: const InputDecoration(
                hintText: "example: Shaggy",
                labelText: "User Name",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onChanged: (value) {
                usersProvider.name = value;

                print(usersProvider.name);
                
              },
              validator: (value) {
                return value != '' ? null : 'El campo no debe estar vacío.';
              },
            ),
          ),
          const Divider(height: 15.0,),
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              initialValue: '',
              decoration: const InputDecoration(
                hintText: "example: 65.5",
                labelText: "Peso",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  try {
                    usersProvider.weight = double.parse(value);
                  } catch (e) {
                    print('$e NO ES UN PESO ACEPTABLE');
                  }
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
                  return 'El campo no debe estar vacío';
                }
              },
            ),
          ),
          const Divider(height: 15.0,),
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              initialValue: '',
              decoration: const InputDecoration(
                hintText: "example: 1.56",
                labelText: "Altura",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  try {
                    usersProvider.height = double.parse(value);
                  } catch (e) {
                    print('$e NO ES UNA ESTURA ACEPTABLE!');
                  }
                } else {
                  usersProvider.height = 0.0;
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
          ),
          const Divider(height: 15.0,),
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              initialValue: '',
              decoration: const InputDecoration(
                hintText: "example: 828",
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onChanged: (value) => usersProvider.password = value,
              validator: (value) {
                return value != '' ? null : 'El campo no debe estar vacío.';
              },
            ),
          ),
          const Divider(height: 15.0,),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.blue,
            splashColor: Colors.green,
            onPressed: usersProvider.isLoading? null: () async {
              //Quitar teclado al terminar
              FocusScope.of(context).unfocus();

              if (!usersProvider.isValidLocalForm(_formKey)) return;

              String name = usersProvider.name; 

              var found = await usersProvider.getUserByName(name);

              if (usersProvider.createOrUpdate == "create") {

                if (found) {

                  displayDialog1(context);
                  return;

                } else {

                  usersProvider.addUser();

                  displayDialog2(context);

                  usersProvider.resetUserData();

                }
              }

              usersProvider.isLoading = false;
              
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(usersProvider.isLoading ? 'Espere' : 'Sign up', style: const TextStyle(fontSize: 25, color: Colors.white),),
            ),
          ),
        ],
      )
    );
  }

  void displayDialog1(BuildContext context,) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text("ERROR"),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("El Usuario ya se encuentra registrado.", style: TextStyle(fontSize: 15),),
              SizedBox(height: 5,),
              Icon(Icons.warning_rounded, color: Colors.red, size: 60,),
              SizedBox(height: 5,)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        );
      }
    );
  }

  void displayDialog2(BuildContext context,) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text("¡REGISTRO EXITOSO!"),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Se ha creado el usuario corectamente.", style: TextStyle(fontSize: 15),),
              Icon(Icons.verified, color: Colors.green, size: 60,),
              SizedBox(height: 5,)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, 'Home'),
              child: const Text("Okay"),
            ),
          ],
        );
      }
    );
  }

}