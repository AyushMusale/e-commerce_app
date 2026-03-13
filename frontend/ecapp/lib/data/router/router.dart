
import 'package:ecapp/presentation/bloc/bloc/authBloc.dart';
import 'package:ecapp/presentation/bloc/state/authstate.dart';
import 'package:ecapp/presentation/pages/customer_pages/homepage.dart';
import 'package:ecapp/presentation/pages/customer_pages/navigationpage.dart';
import 'package:ecapp/presentation/pages/loginpage.dart';
import 'package:ecapp/presentation/pages/seller_pages/navigationpage.dart';
import 'package:ecapp/presentation/pages/seller_pages/productformpage.dart';
import 'package:ecapp/presentation/pages/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  redirect: (BuildContext context, GoRouterState state) {
    final Authstate authstate =context.read<Authbloc>().state;
    final currentpath = state.matchedLocation;
    if(authstate is AuthstateSucces){
      if(currentpath == '/login' || currentpath == '/signup'){
        return "/seller/navgationpage";
      }
    }
    else{
      if(currentpath != '/login' && currentpath != '/signup'){
        return '/login';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'loginpage',
      builder: (context, state) => const Loginpage(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signuppage',
      builder: (context, state) => const Signuppage(),
    ),
    GoRoute(
      path: '/home',
      name: 'customerhomepage',
      builder: (context, state) => const CustomerHomepage(),
    ),
    GoRoute(
      path: '/seller/home',
      name: 'sellerhomepage',
      builder: (context, state) => const CustomerHomepage(),
    ),
    GoRoute(
      path: '/navgationpage',
      name: 'customernavigationpage',
      builder: (context, state) => const CustomerNavigationpage(),
    ),
    GoRoute(
      path: '/seller/navgationpage',
      name: 'sellernavigationpage',
      builder: (context, state) => const SellerNavigationpage(),
    ),
    GoRoute(
      path: '/seller/productformpage',
      name: 'productformpage',
      builder: (context, state) => const Productformpage(),
    ),
  ],
);
