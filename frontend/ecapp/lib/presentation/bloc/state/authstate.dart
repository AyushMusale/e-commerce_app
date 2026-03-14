

abstract class Authstate {}

class AuthstateSucces extends Authstate {
  AuthstateSucces();
}

class AuthstateFailed extends Authstate {
  String? message;
  AuthstateFailed({required this.message});
}

class AuthstatePending extends Authstate {}

class AuthstateInitial extends Authstate {}

class AuthstateAuthenticated extends Authstate {}

class AuthstateUnauthenticated extends Authstate {
  AuthstateUnauthenticated();
}
