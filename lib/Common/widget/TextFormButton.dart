import 'package:flutter/material.dart';
class TextFormButton extends StatelessWidget {
  var controller=TextEditingController();
  var hint;
  Icon icon;
  bool obscureText;
  final String valid;
  var TextInputType;


   TextFormButton({super.key,required this.controller,required this.hint,required this.icon,required this.obscureText, required this.valid, this.TextInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     controller: controller,
    obscureText:obscureText,
      keyboardType:TextInputType ,
      // Add a validator for the email
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $valid';
        }
        return null;
      },




      decoration: InputDecoration(
        hintText: hint,
           prefixIcon: icon,
      ),


    );
  }
}
