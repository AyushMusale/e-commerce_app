import 'package:ecapp/domain/usecases/authusecase.dart';
import 'package:ecapp/presentation/bloc/events/authevent.dart';
import 'package:ecapp/presentation/bloc/state/authstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authbloc extends Bloc<Authevent, Authstate> {
  final Authusecase _authusecase;
  Authbloc(this._authusecase) : super(AuthstateInitial()){
    on<AuthLoginevent>((event, emit) async{
      emit(AuthstatePending());
       try {
        final user = await _authusecase.execute(email: event.email, password: event.password);
        emit(AuthstateSucces(authUser: user));
       }
      catch(e){
          emit(AuthstateFailed(message: e.toString()));
      }
    });
   }
}