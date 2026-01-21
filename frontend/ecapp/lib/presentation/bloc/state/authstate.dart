import 'package:ecapp/domain/entities/user.dart';

abstract class Authstate {}

class AuthstateSucces extends Authstate{
  AuthDetails authUser;
  AuthstateSucces({required this.authUser});
}
class AuthstateFailed extends Authstate{
  String? message;
  AuthstateFailed({required this.message});
}
class AuthstatePending extends Authstate{}
class AuthstateInitial extends Authstate{}