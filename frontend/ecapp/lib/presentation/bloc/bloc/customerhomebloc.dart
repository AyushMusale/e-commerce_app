import 'package:ecapp/data/models/homedata.dart';
import 'package:ecapp/domain/usecases/customerhomepageusecase.dart';
import 'package:ecapp/presentation/bloc/events/customerhomeevent.dart';
import 'package:ecapp/presentation/bloc/state/customerhomestate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Customerhomebloc extends Bloc<Customerhomeevent, Customerhomestate> {
  final GetCustomerHomepageDataUsecase getCustomerHomepageDataUsecase;
  Customerhomebloc({required this.getCustomerHomepageDataUsecase})
    : super(CustomerhomeInitialstate()) {
    on<getCustomerDataEvent>((event, emit) async {
      emit(CustomerhomePendingstate());
      try{
        Homedata homedata = await getCustomerHomepageDataUsecase.execute();
        emit(CustomerhomeSuccessstate(homedata: homedata));
      }catch(e){
        emit(CustomerhomeFailurestate(message: e.toString()));
      }
    });
  }
}
