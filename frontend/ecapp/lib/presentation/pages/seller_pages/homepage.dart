import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/bloc/state/authstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SellerHomepage extends StatefulWidget {
  const SellerHomepage({super.key});

  @override
  State<SellerHomepage> createState() => _SellerHomepageState();
}

class _SellerHomepageState extends State<SellerHomepage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Authbloc, Authstate>(
      builder: (context, state) {

        if(state is AuthstateUnauthenticated){
          context.pushReplacementNamed('login');
        }
        return Scaffold(
          appBar: AppBar(
            leading: TextButton(onPressed: () {
              context.read<Authbloc>().add(LogoutEvent());
            }, child: Text("Logout")),
          ),
          body: Center(child: Text("Welcome to the Home page")),
        );
      },
    );
  }
}
