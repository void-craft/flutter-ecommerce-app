import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart'; // Import CartBloc
import 'package:buy_it_app/repositories/all_products_repo/all_products_actions.dart';
import 'package:buy_it_app/repositories/cart_repo/cart_repository.dart';
import 'package:buy_it_app/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    final allProductsAction = AllProductsActions();
    final cartRepository = CartRepositoryImpl(); // Create an instance of your CartRepository

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => allProductsAction),
        RepositoryProvider(create: (_) => cartRepository), // Add CartRepository
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AllProductsBloc(productActions: allProductsAction)),
          BlocProvider(create: (_) => CartBloc()), // Add CartBloc
        ],
        child: const AllProducts(),
      ),
    );
  }
}


// import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
// import 'package:buy_it_app/repositories/all_products_repo/all_products_actions.dart';
// import 'package:buy_it_app/screens/all_products/all_products.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BaseApp extends StatefulWidget {
//   const BaseApp({super.key});

//   @override
//   State<BaseApp> createState() => _BaseAppState();
// }

// class _BaseAppState extends State<BaseApp> {
//   @override
//   Widget build(BuildContext context) {
//     final allProductsAction = AllProductsActions();
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider(create: (_) => allProductsAction),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (_) => AllProductsBloc(productActions: allProductsAction)),
//         ],
//         child: const AllProducts(),
//       ),
//     );
//   }
// }
