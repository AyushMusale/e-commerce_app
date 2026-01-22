import 'package:ecapp/data/local_data/local_data.dart';
import 'package:ecapp/data/repositires/authrepo.dart';
import 'package:ecapp/data/repositires/registerrepo.dart';
import 'package:ecapp/data/router/router.dart';
import 'package:ecapp/domain/usecases/authusecase.dart';
import 'package:ecapp/domain/usecases/registerusecase.dart';
import 'package:ecapp/presentation/bloc/bloc/authBloc.dart';
import 'package:ecapp/presentation/bloc/bloc/registerbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authDb');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
  AuthDB authDB = AuthDB();
  Authrepo authrepo = Authrepo(authDB);
  Authusecase authusecase = Authusecase(authrepo);
  Registerrepo registerrepo = Registerrepo();
  Registerusecase registerusecase = Registerusecase(registerrepo);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Authbloc(authusecase),
          child: Container(),
        ),
        BlocProvider(create: (_)=>Registerbloc(registerusecase))
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
