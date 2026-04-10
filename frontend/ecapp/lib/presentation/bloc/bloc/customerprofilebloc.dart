import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/domain/usecases/customerprofileusecase.dart';
import 'package:ecapp/presentation/bloc/events/customerprofileevent.dart';
import 'package:ecapp/presentation/bloc/state/customerprofilestate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProfileBLoc
    extends Bloc<CustomerProfileEvent, CustomerProfileState> {
  CustomerProfileUsecase customerProfileUsecase;
  CustomerProfileBLoc({required this.customerProfileUsecase})
    : super(CustomerProfileInitialState()) {
    on<StoreCustomerProfileEvent>((event, emit) async {
      emit(
        CustomerProfileState(
          isLoading: true,
          isError: false,
          message: 'loading',
        ),
      );
      try {
        final profile = event.profile();
        final res = await customerProfileUsecase.storeCustomerProfile(profile);

        if (res == 'success') {
          emit(
            CustomerProfileState(
              isLoading: false,
              isError: true,
              message: 'Profile Saved',
            ),
          );
        }
        emit(
          CustomerProfileState(isLoading: false, isError: true, message: res),
        );
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            CustomerProfileState(
              isLoading: false,
              isError: true,
              message: 'unauthenticated',
            ),
          );
        } else {
          emit(
            CustomerProfileState(
              isLoading: false,
              isError: true,
              message: e.toString(),
            ),
          );
        }
      }
    });

    on<GetCustomerProfileEvent>((event, emit) async {
      emit(
        CustomerProfileState(
          isLoading: true,
          isError: false,
          message: 'loading',
        ),
      );
      try {
        final profile = await customerProfileUsecase.getCustomerProfile();
        emit(
          CustomerProfileState(
            customerProfile: profile,
            isLoading: false,
            isError: false,
            message: '',
          ),
        );
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            CustomerProfileState(
              isLoading: false,
              isError: true,
              message: 'unauthenticated',
            ),
          );
        } else if (e is NoDataException) {
          emit(
            CustomerProfileState(
              isLoading: false,
              isError: false,
              message: 'no data',
            ),
          );
        } else {
          emit(
            CustomerProfileState(
              isLoading: false,
              isError: true,
              message: e.toString(),
            ),
          );
        }
      }
    });
  }
}
