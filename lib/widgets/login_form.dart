import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {

  String _email = "";
  String _password = "";
  
  @override
  Widget build(BuildContext context) {

    final UsersProvider usersProvider = Provider.of<UsersProvider>(context);

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
              initialValue: '',
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
              keyboardType: TextInputType.visiblePassword,
              initialValue: '',
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
                if (!usersProvider.isValidForm()) return;
                usersProvider.resetUserData();

                usersProvider.isLoading = false;
                Navigator.pushNamed(context, "Navigation");
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
}