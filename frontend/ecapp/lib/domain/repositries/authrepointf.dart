import 'package:ecapp/domain/entities/authdetaills.dart';

abstract class Authrepointf{
  Future<AuthDetails> execute({required String email, required String password});
}