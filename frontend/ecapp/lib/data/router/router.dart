import 'package:ecapp/presentation/pages/customer_pages/homepage.dart';
import 'package:ecapp/presentation/pages/customer_pages/navigationpage.dart';
import 'package:ecapp/presentation/pages/loginpage.dart';
import 'package:ecapp/presentation/pages/signuppage.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
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
  ],
);
