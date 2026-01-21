import 'package:hive/hive.dart';

class AuthDB{
  void store(String token){
    final box = Hive.box('authDB');
    box.put('token', token);
  }
}