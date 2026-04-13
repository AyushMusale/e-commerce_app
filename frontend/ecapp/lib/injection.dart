import 'package:ecapp/data/local_data/local_data.dart';
import 'package:ecapp/data/local_data/sellerprofiledb.dart';
import 'package:ecapp/data/network/authclient.dart';
import 'package:ecapp/data/network/authservice.dart';
import 'package:ecapp/data/repositires/authrepo.dart';
import 'package:ecapp/data/repositires/cartrepo.dart';
import 'package:ecapp/data/repositires/customerhomepagereppo.dart';
import 'package:ecapp/data/repositires/customerprofilerepo.dart';
import 'package:ecapp/data/repositires/fetchproductrepo.dart';
import 'package:ecapp/data/repositires/fetchsellerproducts.dart';
import 'package:ecapp/data/repositires/orderrepo.dart';
import 'package:ecapp/data/repositires/newproductrepo.dart';
import 'package:ecapp/data/repositires/registerrepo.dart';
import 'package:ecapp/data/repositires/searchrepo.dart';
import 'package:ecapp/data/repositires/sellerbankdetailsrepo.dart';
import 'package:ecapp/data/repositires/sellerprofilerepo.dart';
import 'package:ecapp/domain/usecases/orderusecase.dart';
import 'package:ecapp/domain/usecases/authusecase.dart';
import 'package:ecapp/domain/usecases/bankdetailsusecase.dart';
import 'package:ecapp/domain/usecases/cartusecase.dart';
import 'package:ecapp/domain/usecases/customerhomepageusecase.dart';
import 'package:ecapp/domain/usecases/customerprofileusecase.dart';
import 'package:ecapp/domain/usecases/fetchproductusecase.dart';
import 'package:ecapp/domain/usecases/fetchsellerproductsusecase.dart';
import 'package:ecapp/domain/usecases/newproductusecase.dart';
import 'package:ecapp/domain/usecases/registerusecase.dart';
import 'package:ecapp/domain/usecases/searchusecase.dart';
import 'package:ecapp/domain/usecases/sellerprofileusecase.dart';

class Injection {
  late final AuthDB authDB;
  late final SellerProfileDB sellerProfileDB;

  late final AuthService authService;
  late final AuthClient authClient;

  // repos
  late final Authrepo authrepo;
  late final Registerrepo registerrepo;
  late final Newproductrepo newProductrepo;
  late final SellerProfileRepo sellerProfileRepo;
  late final GetCustomerHomepageDataRepo homepageRepo;
  late final FetchproductRepo fetchproductRepo;
  late final CartRepo cartRepo;
  late final Sellerbankdetailsrepo bankRepo;
  late final CustomerProfileRepo customerProfileRepo;
  late final SearchRepo searchRepo;
  late final FetchSellerProductsRepo fetchSellerProductsRepo;
  late final CreateOrderRepo orderRepo;

  // usecases
  late final Authusecase authusecase;
  late final Registerusecase registerusecase;
  late final Newproductusecase newproductusecase;
  late final SellerProfileUsecase sellerProfileUsecase;
  late final GetCustomerHomepageDataUsecase customerHomepageUsecase;
  late final Fetchproductusecase fetchproductUsecase;
  late final CartUsecase cartUsecase;
  late final SellerBankdetailsusecase bankDetailsUsecase;
  late final CustomerProfileUsecase customerProfileUsecase;
  late final SearchUsecase searchUsecase;
  late final FetchSellerProductsUsecase fetchSellerProductsUsecase;
  late final Orderusecase orderUsecase;

  Future<void> init() async {
    // DB
    authDB = AuthDB();
    sellerProfileDB = SellerProfileDB();

    // services
    authService = AuthService(authDB);
    authClient = AuthClient(authService);

    // repos
    authrepo = Authrepo(authDB);
    registerrepo = Registerrepo();
    newProductrepo = Newproductrepo(authDB: authDB, authClient: authClient);
    sellerProfileRepo = SellerProfileRepo(
      client: authClient,
      sellerProfileDB: sellerProfileDB,
    );
    homepageRepo = GetCustomerHomepageDataRepo(client: authClient);
    fetchproductRepo = FetchproductRepo(client: authClient);
    cartRepo = CartRepo(clinet: authClient);
    bankRepo = Sellerbankdetailsrepo(client: authClient);
    customerProfileRepo = CustomerProfileRepo(client: authClient);
    searchRepo = SearchRepo(client: authClient);
    fetchSellerProductsRepo = FetchSellerProductsRepo(client: authClient);
    orderRepo = CreateOrderRepo(client: authClient);

    // usecases
    authusecase = Authusecase(authrepo);
    registerusecase = Registerusecase(registerrepo);
    newproductusecase = Newproductusecase(newProductrepo);
    sellerProfileUsecase = SellerProfileUsecase(
      sellerProfileRepo: sellerProfileRepo,
    );
    customerHomepageUsecase = GetCustomerHomepageDataUsecase(
      getCustomerHomepageDataRepo: homepageRepo,
    );
    fetchproductUsecase = Fetchproductusecase(
      fetchproductRepo: fetchproductRepo,
    );
    cartUsecase = CartUsecase(cartRepo: cartRepo);
    bankDetailsUsecase = SellerBankdetailsusecase(sellerbankdetailsrepo: bankRepo);
    customerProfileUsecase = CustomerProfileUsecase(
      customerProfileRepo: customerProfileRepo,
    );
    searchUsecase = SearchUsecase(searchRepo: searchRepo);
    fetchSellerProductsUsecase = FetchSellerProductsUsecase(
      fetchSellerProductsRepo: fetchSellerProductsRepo,
    );
    orderUsecase = Orderusecase(createOrderRepo: orderRepo);
  }
}
