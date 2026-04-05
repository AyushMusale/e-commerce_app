import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/bloc/customerhomebloc.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/bloc/events/customerhomeevent.dart';
import 'package:ecapp/presentation/bloc/state/authstate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final dh = MediaQuery.of(context).size.height;
    // final dw = MediaQuery.of(context).size.width;
    return BlocConsumer<Authbloc, Authstate>(
      listener: (context, state) {
        if (state is AuthstateSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Successfull login",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              duration: Duration(seconds: 2),
            ),
          );
          if(state.userRole == 'seller'){
          context.pushReplacementNamed("sellernavigationpage");
          }
          else{
            context.read<Customerhomebloc>().add(getCustomerDataEvent());
            context.pushReplacementNamed('customernavigationpage');
          }
        }
        if (state is AuthstateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message!,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthstatePending) {
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
                    "Log-in",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: dh * 0.04,
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
                  SizedBox(
                    height: dh * 0.05,
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.blueAccent,
                        ),
                      ),
                      onPressed: () {
                        context.read<Authbloc>().add(
                          AuthLoginevent(
                            email: emailcontroller.text.trim(),
                            password: passwordcontroller.text.trim(),
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
                  SizedBox(height: dh * 0.015),
                  GestureDetector(
                    onTap: () {
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
      },
    );
  }
}
