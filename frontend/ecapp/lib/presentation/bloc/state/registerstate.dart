class RegisterState {}

class RegisterStateSuccess extends RegisterState{}
class RegisterStateFailed extends RegisterState{
  String message;
  RegisterStateFailed({required this.message});
}
class RegisterStatePending extends RegisterState{}
class RegisterStateInitial extends RegisterState{}
