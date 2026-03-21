import 'package:ecapp/data/local_data/local_data.dart';
import 'package:ecapp/data/network/authclient.dart';
import 'package:ecapp/data/network/authservice.dart';
import 'package:ecapp/data/repositires/authrepo.dart';
import 'package:ecapp/data/repositires/newproductrepo.dart';
import 'package:ecapp/data/repositires/registerrepo.dart';
import 'package:ecapp/data/router/router.dart';
import 'package:ecapp/domain/usecases/authusecase.dart';
import 'package:ecapp/domain/usecases/newproductusecase.dart';
import 'package:ecapp/domain/usecases/registerusecase.dart';
import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/bloc/imagepickerbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/newproductbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/registerbloc.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authDb');

  final authDB = AuthDB();
  final authService = AuthService(authDB);
  final authClient = AuthClient(authService);
  final authrepo = Authrepo(authDB);
  final authusecase = Authusecase(authrepo);
  final registerrepo = Registerrepo();
  final registerusecase = Registerusecase(registerrepo);
  final authbloc = Authbloc(authusecase, authDB)..add(AuthChecksession());
  final newProductrepo = Newproductrepo(authDB: authDB, authClient: authClient);
  final newProductuseccase = Newproductusecase(newProductrepo);
  final router = createRouter(authbloc);

  runApp(MainApp(
    authbloc: authbloc,
    router: router,
    registerusecase: registerusecase,
    newproductusecase: newProductuseccase,
  ));
}

class MainApp extends StatelessWidget {
  final Authbloc authbloc;
  final GoRouter router;
  final Registerusecase registerusecase;
  final Newproductusecase newproductusecase;

  const MainApp({
    super.key,
    required this.authbloc,
    required this.router,
    required this.registerusecase,
    required this.newproductusecase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authbloc),
        BlocProvider(create: (_) => Registerbloc(registerusecase)),
        BlocProvider(create: (_) => Imagepickerbloc()),
        BlocProvider(create: (_)=> Newproductbloc(newproductusecase)),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}