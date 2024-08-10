import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/repositories/all_products_repo/all_products_actions.dart';
import 'package:buy_it_app/screens/all_products/all_products_screen.dart';
import 'package:buy_it_app/screens/favorites/favorites_screen.dart';
import 'package:buy_it_app/widgets/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final allProductsAction = AllProductsActions();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => allProductsAction),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  AllProductsBloc(productActions: allProductsAction)),
          BlocProvider(create: (_) => CartBloc()),
          BlocProvider(
            create: (context) =>
                FavoritesBloc(cartBloc: BlocProvider.of<CartBloc>(context)),
            child: const FavoritesScreen(),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Products',
              showBackButton: false,
            ),
            body: AllProducts(),
          ),
        ),
      ),
    );
  }
}
