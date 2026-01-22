import 'package:ecapp/data/models/registermodel.dart';
import 'package:ecapp/data/repositires/registerrepo.dart';

class Registerusecase {
  final Registerrepo registerrepo;
  Registerusecase(this.registerrepo);

  Future<Registermodel> execute({required String email, required String password, required String confirmpassword,required String user_role}){
    return registerrepo.execute(email: email, password: password, confirmpassword: confirmpassword, selectedrole: user_role);
  }
}