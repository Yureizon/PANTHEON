import 'package:flutter/material.dart';
import 'package:pantheon/providers.dart/users_provider.dart';
import 'package:pantheon/widgets/input_text.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //GlobalKey<FormState> _formkey = GlobalKey();

  _submit(){
    //final isLogin = _formkey.currentState?.validate();
    //print('IsLoginn Form $isLogin');
  }

  @override
  Widget build(BuildContext context) {
    final UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    return Form(
      key: usersProvider.formKeyUsers,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget> [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: usersProvider.name,
            decoration: const InputDecoration(
              //border: OutlineInputBorder(),
              hintText: "example: Shaggy",
              labelText: "User Name",
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            onChanged: (value) => usersProvider.name = value,
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
          ),
          const Divider(height: 15.0,),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            initialValue: usersProvider.password,
            decoration: const InputDecoration(
              //border: OutlineInputBorder(),
              hintText: "example: 828",
              labelText: "Password",
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            onChanged: (value) => usersProvider.name = value,
            validator: (value) {
              return value != '' ? null : 'The field must not be empty';
            },
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

              if (usersProvider.createOrUpdate == "create") {
                usersProvider.addUser();
              } else {
                usersProvider.updateUser();
              }
              
              usersProvider.resetUserData();

              usersProvider.isLoading = false;

              //actualOptionProvider.selectedOption = 0;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(usersProvider.isLoading ? 'Espere' : 'Sign up', style: const TextStyle(color: Colors.white),),
            ),
          ),
        ],
      )
    );
  }
}