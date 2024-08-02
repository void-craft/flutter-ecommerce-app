import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:buy_it_app/model/product/product.dart';
import 'package:buy_it_app/widgets/single_product.dart';
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
    final bloc = BlocProvider.of<AllProductsBloc>(context);
    bloc.add(FetchAllProducts());
    super.initState();
  }

  Widget getBody(List<Product> product) {
    print('Building body with products: $product'); // Debug print
    return ListView.builder(
        itemCount: product.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(product: product[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink,
          title: const Text("Buy It - Your Shopping App",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white)),
        ),
        body: BlocBuilder<AllProductsBloc, AllProductsState>(
            builder: (context, state) {
          print('BlocBuilder state: $state'); // Debug print
          return state.loading
              ? const Center(child: CircularProgressIndicator())
              : getBody(state.allProducts ?? []);
        }));
  }
}


