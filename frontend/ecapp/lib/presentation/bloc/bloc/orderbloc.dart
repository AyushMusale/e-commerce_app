import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/domain/usecases/orderusecase.dart';
import 'package:ecapp/presentation/bloc/events/orderevent.dart';
import 'package:ecapp/presentation/bloc/state/orderstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<Orderevent, Orderstate> {
  final Orderusecase orderusecase;

  OrderBloc({required this.orderusecase}) : super(OrderInitialState()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<VerifyOrderEvent>(_onVerifyOrder);
  }

  Future<void> _onCreateOrder(
    CreateOrderEvent event,
    Emitter<Orderstate> emit,
  ) async {
    emit(CreateOrderState(isLoading: true, message: 'loading', error: false));
   // await Future.delayed(Duration(seconds: 5));
    try {
      final order = await orderusecase.createOrder();
      emit(
        CreateOrderState(
          order: order,
          isLoading: false,
          message: 'success',
          error: false,
        ),
      );
    } catch (e) {
      if (e is UnauthenticatedException) {
        emit(
          CreateOrderState(
            isLoading: false,
            error: true,
            message: 'unauthenticated',
          ),
        );
      } else if (e is NoDataException) {
        emit(
          CreateOrderState(
            isLoading: false,
            error: false,
            message: e.exception,
          ),
        );
      } else {
        emit(
          CreateOrderState(
            isLoading: false,
            error: true,
            message: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> _onVerifyOrder(
    VerifyOrderEvent event,
    Emitter<Orderstate> emit,
  ) async {
    emit(VerifyOrderState(isLoading: true, message: 'loading', error: false));
    try {
      final verified = await orderusecase.verifyOrder(event.order);
      emit(
        VerifyOrderState(
          verifiedOrder: verified,
          isLoading: false,
          message: 'success',
          error: false,
        ),
      );
    } catch (e) {
      if (e is UnauthenticatedException) {
        emit(
          VerifyOrderState(
            isLoading: false,
            error: true,
            message: 'unauthenticated',
          ),
        );
      } else if (e is NoDataException) {
        emit(
          VerifyOrderState(
            isLoading: false,
            error: false,
            message: e.exception,
          ),
        );
      } else {
        emit(
          VerifyOrderState(
            isLoading: false,
            error: true,
            message: e.toString(),
          ),
        );
      }
    }
  }
}
