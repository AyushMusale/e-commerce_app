import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/state/authstate.dart';
import 'package:ecapp/presentation/pages/customer_pages/homepage.dart';
import 'package:ecapp/presentation/pages/customer_pages/navigationpage.dart';
import 'package:ecapp/presentation/pages/customer_pages/productpage.dart';
import 'package:ecapp/presentation/pages/loginpage.dart';
import 'package:ecapp/presentation/pages/seller_pages/navigationpage.dart';
import 'package:ecapp/presentation/pages/seller_pages/productformpage.dart';
import 'package:ecapp/presentation/pages/seller_pages/profilepage.dart';
import 'package:ecapp/presentation/pages/signuppage.dart';
import 'package:ecapp/utils/gorouterstreamnotifier.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(Authbloc authbloc) => GoRouter(
  initialLocation: '/login',
  refreshListenable: GoRouterRefreshStream(authbloc.stream),
  redirect: (BuildContext context, GoRouterState state) {
    final Authstate authstate = authbloc.state;
    final currentpath = state.matchedLocation;
    if (authstate is AuthstateInitial) return null;
    if (authstate is AuthstateSucces) {
      if (authstate.userRole == 'seller') {
        if (currentpath == '/login' || currentpath == '/signup') {
          return "/seller/navigationpage";
        }
      } else {
        if (currentpath == '/login' || currentpath == '/signup') {
          return '/customer/navigationpage';
        }
      }
    } else {
      if (currentpath != '/login' && currentpath != '/signup') {
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
      path: '/customer/home',
      name: 'customerhomepage',
      builder: (context, state) => const CustomerHomepage(),
    ),
    GoRoute(
      path: '/seller/home',
      name: 'sellerhomepage',
      builder: (context, state) => const CustomerHomepage(),
    ),
    GoRoute(
      path: '/customer/navigationpage',
      name: 'customernavigationpage',
      builder: (context, state) => const CustomerNavigationpage(),
    ),
    GoRoute(
      path: '/customer/product/:id',
      name: 'customerproductpage',
      builder: (context, state) {
        final  id = state.pathParameters['id']!;
        return Productpage(id: id,);},
    ),
    GoRoute(
      path: '/seller/navigationpage',
      name: 'sellernavigationpage',
      builder: (context, state) => const SellerNavigationpage(),
    ),
    GoRoute(
      path: '/seller/productformpage',
      name: 'productformpage',
      builder: (context, state) => const Productformpage(),
    ),
    GoRoute(
      path: '/seller/profile',
      name: "sellerprofilepage",
      builder: (context, state) => const SellerProfilepage(),
    ),
  ],
);
