import 'package:ecapp/domain/usecases/registerusecase.dart';
import 'package:ecapp/presentation/bloc/events/registerevent.dart';
import 'package:ecapp/presentation/bloc/state/registerstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registerbloc extends Bloc<RegisterEvent, RegisterState> {
  final Registerusecase registerusecase;
  Registerbloc(this.registerusecase) : super(RegisterStateInitial()) {
    on<RegisterReqEvent>((event, emit) async {
      emit(RegisterStatePending());
      if(event.email == ''){
        emit(RegisterStateFailed(message: "Please Enter your Email"));
        return;
      }
      if (event.password != event.confirmpassword) {
        emit(RegisterStateFailed(message: "Please Re-enter the same password"));
        return;
      }
      try {
        await registerusecase.execute(
          email: event.email,
          password: event.password,
          confirmpassword: event.confirmpassword,
          user_role: event.userRole,
        );
        emit(RegisterStateSuccess());
      } catch (e) {
        emit(RegisterStateFailed(message: e.toString().replaceFirst('Exception: ', "")));
      }
    });
  }
}
