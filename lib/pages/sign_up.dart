import 'package:flutter/material.dart';
import 'package:pantheon/pages/all.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:pantheon/widgets/sign_up_form.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            //const SignUpForm(),
            _CreateForm(),
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

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    usersProvider.resetUserData();
    return Form(
      key: usersProvider.formKeyUsers,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget> [
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              initialValue: usersProvider.name,
              decoration: const InputDecoration(
                //border: OutlineInputBorder(),
                hintText: "example: Shaggy",
                labelText: "User Name",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onChanged: (value) => usersProvider.name = value,
              validator: (value) {
                return value != '' ? null : 'The field must not be empty';
              },
            ),
          ),
          const Divider(height: 15.0,),
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              //initialValue: usersProvider.weight.toString(),
              decoration: const InputDecoration(
                //border: OutlineInputBorder(),
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
                  usersProvider.weight = double.parse(value);
                } else {
                  usersProvider.weight = 0.0;
                }
              },
              validator: (value) {
                return value != '' ? null : 'The field must not be empty';
              },
            ),
          ),
          const Divider(height: 15.0,),
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              //initialValue: usersProvider.weight.toString(),
              decoration: const InputDecoration(
                //border: OutlineInputBorder(),
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
                  usersProvider.height = double.parse(value);
                } else {
                  usersProvider.height = 0.0;
                }
              },
              validator: (value) {
                return value != '' ? null : 'The field must not be empty';
              },
            ),
          ),
          const Divider(height: 15.0,),
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              initialValue: usersProvider.password,
              decoration: const InputDecoration(
                //border: OutlineInputBorder(),
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
                return value != '' ? null : 'The field must not be empty';
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

              if (!usersProvider.isValidForm()) return;
              print(usersProvider.getUserByName(usersProvider.name));
              if (usersProvider.createOrUpdate == "create") {
                if (usersProvider.getUserByName(usersProvider.name) == true) {
                  displayDialog(context);
                  return;
                } else {
                  //usersProvider.addUser();
                  final route = MaterialPageRoute(
                    builder: (context) => const NavigationExample()
                  );
                  //Navigator.push(context, route);
                }
              }
              
              usersProvider.resetUserData();

              usersProvider.isLoading = true;
              
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

  void displayDialog(BuildContext context) {
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

}