import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:buy_it_app/widgets/single_product.dart';
import 'package:buy_it_app/widgets/sort_options_widget.dart'; // Import the updated sort widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0), // Add padding around the SortOptionsWidget
            child: SortOptionsWidget(),
          ),
          Expanded(
            child: BlocBuilder<AllProductsBloc, AllProductsState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = state.allProducts;

                if (products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

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
            ),
          ),
        ],
      ),
    );
  }
}
