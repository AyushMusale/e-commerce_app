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
  ],
);
