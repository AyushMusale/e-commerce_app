import 'package:ecapp/data/repositires/authrepo.dart';
import 'package:ecapp/domain/entities/user.dart';

class Authusecase {
  final Authrepo _authrepo;
  Authusecase(this._authrepo);
  Future<AuthDetails> execute({required String email, required String password}){
    return _authrepo.execute(email: email, password: password);
  }
}