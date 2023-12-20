import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_project/data/cart_items.dart';
import 'package:bloc_flutter_project/features/home/models/home_produuct_data.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitailEvent);
    on<CartRemoveFromEvent>(cartRemoveFromEvent);
  }

  FutureOr<void> cartInitailEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromEvent(
      CartRemoveFromEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
