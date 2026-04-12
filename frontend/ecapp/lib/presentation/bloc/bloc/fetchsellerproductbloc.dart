import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/domain/usecases/fetchsellerproductsusecase.dart';
import 'package:ecapp/presentation/bloc/events/fetchsellerproductevent.dart';
import 'package:ecapp/presentation/bloc/state/fetchsellerproductstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchSellerProductBloc
    extends Bloc<FetchSellerProductEvent, FetchSellerProductState> {
  final FetchSellerProductsUsecase fetchSellerProductsUsecase;

  FetchSellerProductBloc({required this.fetchSellerProductsUsecase})
    : super(FetchSellerProductInitialState()) {
    on<GetSellerProductsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: false, message: 'loading'));
      try {
        final products = await fetchSellerProductsUsecase.execute();
        emit(
          state.copyWith(
            products: products,
            isLoading: false,
            error: false,
            message: 'success',
          ),
        );
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            state.copyWith(
              isLoading: false,
              error: true,
              message: 'unauthenticated',
            ),
          );
        } else if (e is NoDataException) {
          emit(state.copyWith(isLoading: false, error: false, message: 'no data'));
        } else {
          emit(
            state.copyWith(isLoading: false, error: true, message: e.toString()),
          );
        }
      }
    });
  }
}
