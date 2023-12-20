import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_project/data/cart_items.dart';
import 'package:bloc_flutter_project/data/grocery_data.dart';
import 'package:bloc_flutter_project/data/wishlilst_items.dart';
import 'package:bloc_flutter_project/features/home/models/home_produuct_data.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigate>(homeWishlistButtonNavigate);
    on<HomeCartButtonNavigate>(homeCartButtonNavigate);
  }
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccess(
        products: GroceryData.groceryProduct
            .map((e) => ProductDataModel(
                  id: e["id"] ?? "",
                  name: e["name"] ?? "",
                  description: e["description"] ?? "",
                  imageUrl: e["imageUrl"] ?? "",
                  price: e["price"] ?? "",
                ))
            .toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print("WishlistButton Clicked");
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishListPageActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      event, Emitter<HomeState> emit) {
    print("Add to cart Button clicked");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemWCartedPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigate(
      HomeWishlistButtonNavigate event, Emitter<HomeState> emit) {
    print("WishList  Button Clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigate(event, Emitter<HomeState> emit) {
    print("cart  Button Clicked");
    emit(HomeNavigateToCartPageActionState());
  }
}
