import 'package:bloc_flutter_project/features/cart/ui/cart.dart';
import 'package:bloc_flutter_project/features/home/bloc/home_bloc.dart';
import 'package:bloc_flutter_project/features/home/ui/product_tile_widget.dart';
import 'package:bloc_flutter_project/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homebloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homebloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homebloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          } else if (state is HomeNavigateToWishlistPageActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wishlist()));
          } else if (state is HomeProductItemWCartedPageActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("items added into cart")));
          } else if (state is HomeProductItemWishListPageActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("items added into wishlist")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case HomeLoadedSuccess:
              final succesState = state as HomeLoadedSuccess;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: const Text("Kul GroceryApp"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homebloc.add(HomeWishlistButtonNavigate());
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homebloc.add(HomeCartButtonNavigate());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined)),
                  ],
                ),
                body: ListView.builder(
                    itemCount: succesState.products.length,
                    itemBuilder: ((context, index) {
                      return ProductTileWidget(
                          homeBloc: homebloc,
                          productDataModel: succesState.products[index]);
                    })),
              );
            case HomeErrorState:
              return const Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
            default:
              return const SizedBox();
          }
        });
  }
}
