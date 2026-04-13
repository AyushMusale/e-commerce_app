import 'package:ecapp/data/local_data/sellerprofiledata.dart';
import 'package:ecapp/injection.dart';
import 'package:ecapp/router.dart';
import 'package:ecapp/presentation/bloc/bloc/auth_bloc.dart';
import 'package:ecapp/presentation/bloc/bloc/bankdetails.dart';
import 'package:ecapp/presentation/bloc/bloc/cartbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/customerhomebloc.dart';
import 'package:ecapp/presentation/bloc/bloc/customerprofilebloc.dart';
import 'package:ecapp/presentation/bloc/bloc/fetchproductbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/fetchsellerproductbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/orderbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/imagepickerbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/newproductbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/registerbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/searchbloc.dart';
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

  final injection = Injection();
  await injection.init();

  //bloc
  final sellerProfileBloc = SellerPRofileBloc(
    sellerProfileDB: injection.sellerProfileDB,
    sellerProfileUsecase: injection.sellerProfileUsecase,
  );
  final authbloc = Authbloc(injection.authusecase, injection.authDB)..add(AuthChecksession());
  final router = createRouter(authbloc);

  runApp(
    MainApp(
      authbloc: authbloc,
      router: router,
      injection: injection,
      sellerProfileBloc: sellerProfileBloc,
    ),
  );
}

class MainApp extends StatelessWidget {
  final Authbloc authbloc;
  final GoRouter router;
  final Injection injection;
  final SellerPRofileBloc sellerProfileBloc;

  const MainApp({
    super.key,
    required this.authbloc,
    required this.router,
    required this.injection,
    required this.sellerProfileBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authbloc),
        BlocProvider.value(value: sellerProfileBloc),

        BlocProvider(create: (_) => Registerbloc(injection.registerusecase)),
        BlocProvider(create: (_) => Imagepickerbloc()),
        BlocProvider(create: (_) => Newproductbloc(injection.newproductusecase)),
        BlocProvider(
          create:
              (_) => Customerhomebloc(
                getCustomerHomepageDataUsecase: injection.customerHomepageUsecase,
              ),
        ),
        BlocProvider(
          create:
              (_) => Fetchproductbloc(fetchproductusecase: injection.fetchproductUsecase),
        ),
        BlocProvider(create: (_) => Cartbloc(cartUsecase: injection.cartUsecase)),
        BlocProvider(
          create:
              (_) => Bankdetailsbloc(
                sellerBankdetailsusecase: injection.bankDetailsUsecase,
              ),
        ),
        BlocProvider(
          create:
              (_) => CustomerProfileBLoc(
                customerProfileUsecase: injection.customerProfileUsecase,
              ),
        ),
        BlocProvider(create: (_) => Searchbloc(searchUsecase: injection.searchUsecase)),
        BlocProvider(
          create:
              (_) => FetchSellerProductBloc(
                fetchSellerProductsUsecase: injection.fetchSellerProductsUsecase,
              ),
        ),
        BlocProvider(create: (_) => OrderBloc(orderusecase: injection.orderUsecase)),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
