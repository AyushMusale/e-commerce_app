import 'package:ecapp/presentation/widgets/radiobutton.dart';
import 'package:ecapp/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  String selectedRole = "customer";
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: dh * 0.05,
                ),
              ),
              SizedBox(height: dh * 0.01),
              InputTextfieldState(logo: 'email', passwordfield: false),
              SizedBox(height: dh * 0.01),
              InputTextfieldState(logo: 'password', passwordfield: true),
              SizedBox(height: dh * 0.01),
              InputTextfieldState(
                logo: 'Confirm your password',
                passwordfield: true,
              ),
              SizedBox(height: dh * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radiobutton(
                    ontap: () {
                      setState(() {
                        selectedRole = 'customer';
                      });
                    },
                    isSelected: selectedRole == "customer",
                    title: "Customer",
                  ),
                  Radiobutton(
                    ontap: () {
                      setState(() {
                        selectedRole = 'seller';
                      });
                    },
                    isSelected: selectedRole == 'seller',
                    title: 'Seller',
                  ),
                ],
              ),
              SizedBox(height: dh * 0.015),
              SizedBox(
                height: dh * 0.05,
                width: dw,
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
              GestureDetector(
                onTap: () {
                  context.pushNamed('loginpage');
                },
                child: Text(
                  "Already have an account? Login",
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
