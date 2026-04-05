import 'package:ecapp/data/local_data/local_data.dart';
import 'package:ecapp/data/local_data/sellerprofiledata.dart';
import 'package:ecapp/data/local_data/sellerprofiledb.dart';
import 'package:ecapp/data/network/authclient.dart';
import 'package:ecapp/data/network/authservice.dart';
import 'package:ecapp/data/repositires/authrepo.dart';
import 'package:ecapp/data/repositires/customerhomepagereppo.dart';
import 'package:ecapp/data/repositires/newproductrepo.dart';
import 'package:ecapp/data/repositires/registerrepo.dart';
import 'package:ecapp/data/repositires/sellerprofilerepo.dart';
import 'package:ecapp/data/router/router.dart';
import 'package:ecapp/domain/usecases/authusecase.dart';
import 'package:ecapp/domain/usecases/customerhomepageusecase.dart';
import 'package:ecapp/domain/usecases/newproductusecase.dart';
import 'package:ecapp/domain/usecases/registerusecase.dart';
import 'package:ecapp/domain/usecases/sellerprofileusecase.dart';
import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/bloc/customerhomebloc.dart';
import 'package:ecapp/presentation/bloc/bloc/imagepickerbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/newproductbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/registerbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/sellerprofile.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SellerProfileAdapter());
  await Hive.openBox<SellerProfile>('sellerProfileDB');
  await Hive.openBox('authDb');

  //DB
  final authDB = AuthDB();
  final sellerProfileDB = SellerProfileDB();

  //services && client
  final authService = AuthService(authDB);
  final authClient = AuthClient(authService);

  //repo
  final authrepo = Authrepo(authDB);
  final registerrepo = Registerrepo();
  final newProductrepo = Newproductrepo(authDB: authDB, authClient: authClient);
  final sellerProfilerepo = SellerProfileRepo(
    client: authClient,
    sellerProfileDB: sellerProfileDB,
  );
  final getCustomerHomepageDataRepo = GetCustomerHomepageDataRepo(
    client: authClient,
  );

  //usecase
  final authusecase = Authusecase(authrepo);
  final registerusecase = Registerusecase(registerrepo);
  final newProductuseccase = Newproductusecase(newProductrepo);
  final sellerProfileusecase = SellerProfileUsecase(
    sellerProfileRepo: sellerProfilerepo,
  );
  final getcustomerHomeDatausecase = GetCustomerHomepageDataUsecase(
    getCustomerHomepageDataRepo: getCustomerHomepageDataRepo,
  );

  //bloc
  final sellerProfileBloc = SellerPRofileBloc(
    sellerProfileDB: sellerProfileDB,
    sellerProfileUsecase: sellerProfileusecase,
  );
  final authbloc = Authbloc(authusecase, authDB)..add(AuthChecksession());
  final router = createRouter(authbloc);

  runApp(
    MainApp(
      authbloc: authbloc,
      router: router,
      registerusecase: registerusecase,
      newproductusecase: newProductuseccase,
      sellerPRofileBloc: sellerProfileBloc,
      getCustomerHomepageDataUsecase: getcustomerHomeDatausecase ,
    ),
  );
}

class MainApp extends StatelessWidget {
  final Authbloc authbloc;
  final SellerPRofileBloc sellerPRofileBloc;
  final GoRouter router;
  final Registerusecase registerusecase;
  final Newproductusecase newproductusecase;
  final GetCustomerHomepageDataUsecase getCustomerHomepageDataUsecase;

  const MainApp({
    super.key,
    required this.authbloc,
    required this.router,
    required this.registerusecase,
    required this.newproductusecase,
    required this.sellerPRofileBloc,
    required this.getCustomerHomepageDataUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authbloc),
        BlocProvider.value(value: sellerPRofileBloc),

        BlocProvider(create: (_) => Registerbloc(registerusecase)),
        BlocProvider(create: (_) => Imagepickerbloc()),
        BlocProvider(create: (_) => Newproductbloc(newproductusecase)),
        BlocProvider(create: (_) => Customerhomebloc(getCustomerHomepageDataUsecase: getCustomerHomepageDataUsecase)),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
