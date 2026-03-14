import 'package:ecapp/domain/entities/user.dart';

abstract class Authrepointf{
  Future<AuthDetails> execute({required String email, required String password});
}