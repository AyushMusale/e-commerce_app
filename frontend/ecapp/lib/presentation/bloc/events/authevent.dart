class Authevent {}

class AuthLoginevent extends Authevent{
  String email;
  String password;
  AuthLoginevent({required this.email, required this.password});
}