import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/models/cartitems.dart';
import 'package:ecapp/domain/usecases/cartusecase.dart';
import 'package:ecapp/presentation/bloc/events/cartevent.dart';
import 'package:ecapp/presentation/bloc/state/cartstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cartbloc extends Bloc<Cartevent, CartState> {
  CartUsecase cartUsecase;
  Cartbloc({required this.cartUsecase}) : super(CartInititalState()) {
    on<AddToCartevent>((event, emit) async {
      try {
        final currentCart = state.cart;
        emit(state.copyWith(isLoading: true));
        final items = List<CartItem>.from(currentCart.cartItems);
        final index = items.indexWhere((i) => i.product.id == event.product.id);
        if (index != -1) {
          items[index] = items[index].copyWith(
            quantity: items[index].quantity + event.quantity,
          );
        } else {
          items.add(CartItem(product: event.product, quantity: event.quantity));
        }
        final updatedCart = currentCart.copyWith(cartItems: items);
        emit(
          state.copyWith(
            cart: updatedCart,
            isLoading: false,
            message: "${event.product.name} added",
          ),
        );
        final res = await cartUsecase.updateCart(updatedCart);
        if (res == 'Success') {
        } else {
          emit(CartState(cart: state.cart, error: true, message: 'failed'));
        }
      } catch (e) {
        if (e == UnauthenticatedException()) {
          emit(
            CartState(
              cart: state.cart,
              error: true,
              message: 'unauthenticated',
            ),
          );
        } else {
          emit(CartState(cart: state.cart, error: true, message: e.toString()));
        }
      }
    });

    on<RemoveFromCartevent>((event, emit) async {
      try {
        final currentCart = state.cart;
        emit(state.copyWith(isLoading: true));
        final items = List<CartItem>.from(currentCart.cartItems);
        final index = items.indexWhere((i) => i.product.id == event.product.id);
        if (index != -1) {
          if (items[index].quantity == 1) {
            items.removeAt(index);
          } else {
            items[index] = items[index].copyWith(
              quantity: items[index].quantity - 1,
            );
          }
        }
        final updatedCart = currentCart.copyWith(cartItems: items);
        emit(
          state.copyWith(
            cart: updatedCart,
            isLoading: false,
            message: "${event.product.name} removed",
            error: false,
          ),
        );

        final res = await cartUsecase.updateCart(updatedCart);
        if (res == 'Success') {
        } else {
          emit(CartState(cart: state.cart, error: true, message: 'failed'));
        }
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            CartState(
              cart: state.cart,
              error: true,
              message: 'unauthenticated',
            ),
          );
        } else {
          emit(CartState(cart: state.cart, error: true, message: e.toString()));
        }
      }
    });

    on<GetCartEvent>((event, emit) async {
      emit(CartState(cart: state.cart, isLoading: true));
      try {
        final cart = await cartUsecase.getCart();
        emit(CartState(cart: cart, isLoading: false, message: 'success'));
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            CartState(
              cart: state.cart,
              error: true,
              message: 'unauthenticated',
            ),
          );
        } else {
          emit(CartState(cart: state.cart, error: true, message: e.toString()));
        }
      }
    });

    on<DeleteFromCartEvent>((event, emit) async{
      emit(CartState(cart: state.cart, isLoading: true));
        final updatedItems = state.cart.cartItems.where((item)=>item.product.id != event.id).toList();
        final optimisticCart = state.cart.copyWith(cartItems: updatedItems);
        emit(CartState(cart: optimisticCart, isLoading: false,error: false,message: 'Deleted'));
      try {
        final cart = await cartUsecase.deletefromCart(event.id);
        emit(CartState(cart: cart, isLoading: false,error: false,message: 'Deleted'));
      } catch (e) {
        if (e is UnauthenticatedException) {
          emit(
            CartState(
              cart: state.cart,
              error: true,
              message: 'unauthenticated',
            ),
          );
        } else {
          emit(CartState(cart: state.cart, error: true, message: e.toString()));
        }
      }
    });
  }
}
