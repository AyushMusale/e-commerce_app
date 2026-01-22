class RegisterEvent {}
class RegisterReqEvent extends RegisterEvent {
  String email;
  String password;
  String confirmpassword;
  String userRole;
  RegisterReqEvent({required this.email, required this.password,required this.confirmpassword, required this.userRole});
}