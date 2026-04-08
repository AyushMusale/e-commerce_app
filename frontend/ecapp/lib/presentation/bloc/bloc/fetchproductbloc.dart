import 'package:ecapp/domain/usecases/fetchproductusecase.dart';
import 'package:ecapp/presentation/bloc/events/fetchproductevent.dart';
import 'package:ecapp/presentation/bloc/state/fetchproductstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Fetchproductbloc extends Bloc<Fetchproductevent, Fetchproductstate> {
  final Fetchproductusecase fetchproductusecase;
  Fetchproductbloc({required this.fetchproductusecase})
    : super(FetchproductInitialstate()) {
      on<FetchproductDataevent>((event,emit)async{
        try{emit(FetchproductLoadingstate());
        final res = await fetchproductusecase.execute(event.id);
        emit(FetchproductSuccessstate(product: res));}
        catch(e){
          emit(FetchproductFailurestate(message: e.toString()));
        }
      });
    }
}
