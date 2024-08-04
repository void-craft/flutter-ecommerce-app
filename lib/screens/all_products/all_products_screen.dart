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
