import 'package:flutter/material.dart';
import 'package:pantheon/models.dart/generalUser_model.dart';
import 'package:pantheon/providers.dart/logged_user_provider.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    final LoggedUserProvider loggedUserProvider = Provider.of<LoggedUserProvider>(context);

    return Form(
      key: usersProvider.formKeyUsers2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget> [
          Container(
            color: Colors.white54,
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
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
              onChanged: (value) {
                usersProvider.name = value;

                print(usersProvider.name);
                
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
              obscureText: true,
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
              color: Colors.green,
              splashColor: Colors.indigo,
              onPressed: usersProvider.isLoading? null: () async {
                //Quitar teclado al terminar
                FocusScope.of(context).unfocus();
                
                usersProvider.loadUsers();
                if (!usersProvider.isValidForm2()) return;
                String name = usersProvider.name;
                String password = usersProvider.password;
                var found = await usersProvider.validateUser(name, password);

                loggedUserProvider.clear();

                if (found) {
                  Future<dynamic> sies = usersProvider.getSesion(name);

                  print('*** viene TRY CACH ***');
                  try{
                    loggedUserProvider.id = await sies.then((dynamic value) {
                      // Convertir el valor dinámico a int
                      return int.parse(value.toString());
                    });
                  } catch (e) {
                    print('Error al obtener el resultado: $e');
                  }
                  print('*** FIN!! TRY CACH ***');
                  int temp = loggedUserProvider.id!;
                  GeneralUser user = await usersProvider.getUserInfo(temp);
                  print('*** e: $user ***');
                  print('*** e: ${user.id}, ${user.name}, ${user.weight}, ${user.height}, ${user.rol}  ***');
                  loggedUserProvider.isLogged(user.id, user.name, user.password, user.weight, user.height, user.rol);
                  Navigator.pushNamed(context, "Navigation");

                } else {
                  displayDialog1(context);
                }

                //usersProvider.getTodo();

                //usersProvider.resetUserData();
                //usersProvider.getTodo();

                usersProvider.isLoading = false;
                
                //actualOptionProvider.selectedOption = 0;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(usersProvider.isLoading ? 'Espere' : 'Sign In', style: const TextStyle(fontSize: 25, color: Colors.white),),
              ),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("New here?", style: TextStyle(color: Colors.white),),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "SignUp");
                  }, 
                  child: const Text("Sign Up", style: TextStyle(color: Colors.blue),)
                )
              ],
            )
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
          title: const Text("ALERT"),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("El Usuario y/o Contraseña es incorrecto.", style: TextStyle(fontSize: 15),),
              SizedBox(height: 5,),
              Icon(Icons.warning_rounded, color: Colors.pink, size: 60,),
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