import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/domain/usecases/newproductusecase.dart';
import 'package:ecapp/presentation/bloc/events/newproductevent.dart';
import 'package:ecapp/presentation/bloc/state/newproductstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Newproductbloc extends Bloc<Newproductevent, Newproductstate> {
  Newproductusecase newproductusecase;
  Newproductbloc(this.newproductusecase) : super(NewproductstateInitial()) {
    on<Newproductaddrequest>((event, emit) async {
      emit(NewproductstatePending());
      try {
        final res = await newproductusecase.execute(event.product);
        if (res) {
          emit(NewproductstateSuccess(message: 'success'));
        } else {
          emit(NewproductstateFailed(message: 'failed'));
        }
      } catch (e) {
        if(e is RefreshTokenExpiredException){
          emit(NewproductstateFailed(message: "logout"));
        }
        if(e is MulterReqException){
          emit(NewproductstateFailed(message: "yes failed"));
        }
        if (e is UnauthenticatedException) {
          emit(NewproductstateFailed(message: "Unauthenticated"));
        } else {
          emit(NewproductstateFailed(message: "Something went wrong"));
        }
      }
    });
  }
}
