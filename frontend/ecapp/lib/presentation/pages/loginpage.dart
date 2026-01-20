import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/textfield.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
   // final dw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log-in",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: dh * 0.04,
                ),
              ),
              SizedBox(height: dh * 0.01),
              InputTextfieldState(logo: 'email', passwordfield: false),
              SizedBox(height: dh * 0.01),
              InputTextfieldState(logo: 'password', passwordfield: true),
              SizedBox(height: dh * 0.01),
              SizedBox(
                height: dh * 0.05,
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: dh * 0.025),
                  ),
                ),
              ),
              SizedBox(height: dh * 0.015),
              GestureDetector(
                onTap: (){
                  context.pushNamed('signuppage');
                },
                child: Text(
                  'Dont have an account? SignUP',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
