import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  
  final String label;
  final String hint;
  final Icon icon;
  final TextInputType keyboard;
  final bool obsecure;
  final void Function(String data) onChanged;
  final String? Function(String? data) validator;

  const InputText({Key? key,
  this.label = "",
  this.hint = "",
  this.icon =  const Icon(Icons.ac_unit),
  this.keyboard = TextInputType.text,
  this.obsecure = false,
  required this.onChanged,
  required this.validator
  })
   : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: TextFormField(
        keyboardType: keyboard,
        obscureText: obsecure,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          //fillColor: Colors.white,
          //focusColor: Colors.white,
          //hoverColor: Colors.white,
          hintText: hint,
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white,
            //foreground: Paint()..color = Colors.white,
            //backgroundColor: Colors.white,
            //background: Paint()..color = Colors.amber,
            fontSize: 25.0
          ),
          suffixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ),
      ),
    );
  }
}