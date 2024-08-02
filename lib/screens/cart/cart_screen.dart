import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/widgets/single_product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }
          return ListView.builder(
            itemCount: state.cart.length,
            itemBuilder: (context, index) {
              return SingleProduct(product: state.cart[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(ClearCart());
        },
        child: Icon(Icons.clear_all),
      ),
    );
  }
}
