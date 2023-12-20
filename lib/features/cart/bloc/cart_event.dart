part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromEvent extends CartEvent {
  final ProductDataModel productDataModel;

  CartRemoveFromEvent({required this.productDataModel});
}
