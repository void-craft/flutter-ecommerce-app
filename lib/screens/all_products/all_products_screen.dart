import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:buy_it_app/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/widgets/sort_options.dart'; // Make sure to import the sort widget

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<AllProductsBloc>(context);
    bloc.add(FetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        actions: const [
          SortOptionsWidget(), // Add sort options to the app bar
        ],
      ),
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = state.allProducts;

          if (products.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleProduct(product: products[index]),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


// // ignore_for_file: avoid_print

// import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
// import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
// import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
// import 'package:buy_it_app/model/product/product.dart';
// import 'package:buy_it_app/widgets/single_product.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AllProducts extends StatefulWidget {
//   const AllProducts({super.key});

//   @override
//   State<AllProducts> createState() => _AllProductsState();
// }

// class _AllProductsState extends State<AllProducts> {
//   @override
//   void initState() {
//     final bloc = BlocProvider.of<AllProductsBloc>(context);
//     bloc.add(FetchAllProducts());
//     super.initState();
//   }

//   Widget getBody(List<Product> product) {
//     print('Building body with products: $product'); // Debug print
//     return ListView.builder(
//       itemCount: product.length,
//       itemBuilder: (BuildContext context, int index) {
//         return SingleProduct(product: product[index]);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllProductsBloc, AllProductsState>(
//       builder: (context, state) {
//         print('BlocBuilder state: $state'); // Debug print
//         return state.loading
//             ? const Center(child: CircularProgressIndicator())
//             : getBody(state.allProducts ?? []);
//       },
//     );
//   }
// }
