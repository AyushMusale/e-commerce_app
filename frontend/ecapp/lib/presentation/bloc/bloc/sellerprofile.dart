import 'package:ecapp/data/local_data/sellerprofiledb.dart';
import 'package:ecapp/domain/usecases/sellerprofileusecase.dart';
import 'package:ecapp/presentation/bloc/events/sellerprofileevent.dart';
import 'package:ecapp/presentation/bloc/state/profilestate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerPRofileBloc
    extends Bloc<SellerProfileEvent, SellerProfilestate> {
  SellerProfileDB sellerProfileDB;
  SellerProfileUsecase sellerProfileUsecase;
  SellerPRofileBloc({
    required this.sellerProfileDB,
    required this.sellerProfileUsecase,
  }) : super(SellerProfileInitialState()) {
    on<SellerCreateProfileEvent>((event, emit) async {
      emit(SellerProfilePendingState());
      final res = await sellerProfileUsecase.execute(event.sellerProfile);
      if (res == 'success') {
        emit(SellerProfileSuccessState(message: 'Profile Saved'));
      } else {
        emit(SellerProfileFailureState(message: res));
      }
    });

    on<SellerProfileGetDataEvent>((event, emit) {
      final profile = sellerProfileDB.getProfile();

      if (profile != null) {
        emit(SellerProfileLoadedState(sellerProfile: profile  ,message: "Loaded from DB"));
      } else {
        emit(SellerProfileInitialState());
      }
    });
  }
}
