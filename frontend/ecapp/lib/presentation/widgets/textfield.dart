import 'package:flutter/material.dart';

class InputTextfieldState extends StatefulWidget {
  final String logo;
  final bool passwordfield;
  const InputTextfieldState({super.key, required this.logo, required this.passwordfield});

  @override
  State<InputTextfieldState> createState() => _InputTextfieldStateState();
}

class _InputTextfieldStateState extends State<InputTextfieldState> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final bool isEmail = widget.logo == 'email';
    return TextField(
      obscureText: isEmail ? false: obscurePassword,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: isEmail ? Icon(Icons.email_outlined) : Icon(Icons.lock),
        prefixIconColor: Colors.black,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 47, 121, 251),
            width: 2,
          ),
        ),

        hintText: widget.logo.toUpperCase(),

        suffixIcon: isEmail ? null:    IconButton(
          icon : obscurePassword ?  Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
          onPressed: (){
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        ),
      ),
    );
  }
}
