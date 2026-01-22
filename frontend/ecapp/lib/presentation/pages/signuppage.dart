import 'package:ecapp/presentation/bloc/bloc/registerbloc.dart';
import 'package:ecapp/presentation/bloc/events/registerevent.dart';
import 'package:ecapp/presentation/bloc/state/registerstate.dart';
import 'package:ecapp/presentation/widgets/radiobutton.dart';
import 'package:ecapp/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  String selectedRole = "customer";
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController confirmpasswordcontroller = TextEditingController();
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;
    return BlocConsumer<Registerbloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterStateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Account Created",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              duration: Duration(seconds: 2),
            ),
          );
          context.pushNamed('loginpage');
        }
        if (state is RegisterStateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterStatePending) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
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
                  InputTextfieldState(
                    logo: 'email',
                    passwordfield: false,
                    controller: emailcontroller,
                  ),
                  SizedBox(height: dh * 0.01),
                  InputTextfieldState(
                    logo: 'password',
                    passwordfield: true,
                    controller: passwordcontroller,
                  ),
                  SizedBox(height: dh * 0.01),
                  InputTextfieldState(
                    logo: 'Confirm your password',
                    passwordfield: true,
                    controller: confirmpasswordcontroller,
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
                        backgroundColor: WidgetStateProperty.all(
                          Colors.blueAccent,
                        ),
                      ),
                      onPressed: () {
                        context.read<Registerbloc>().add(
                          RegisterReqEvent(
                            email: emailcontroller.text.trim(),
                            password: passwordcontroller.text.trim(),
                            confirmpassword:
                                confirmpasswordcontroller.text.trim(),
                            userRole: selectedRole,
                          ),
                        );
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: dh * 0.025,
                        ),
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
      },
    );
  }
}
