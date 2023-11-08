import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:pantheon/widgets/input_text.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

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
          InputText(
            hint: "Email Address",
            label: "Email Address",
            keyboard: TextInputType.emailAddress,
            icon: const Icon(Icons.verified_user),
            onChanged: (value){
              if (value.isNotEmpty) {
                  _email = value;
                } else {
                  _email = '';
                }
            },
            validator: (value){
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          const Divider(height: 15.0,),
          InputText(
              hint: "Password",
              label: "Password",
              obsecure: true,
              icon: const Icon(Icons.lock_outline),
              onChanged: (value){
                if (value.isNotEmpty) {
                  _password = value;
                } else {
                  _password = '';
                }
              },
              validator: (value){
                return value != '' ? null : 'The field must not be empty';
              },
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