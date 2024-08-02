import 'package:buy_it_app/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print('Rendering SingleProduct: $product'); // Debug print
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        shape: BeveledRectangleBorder(
            side: const BorderSide(color: Colors.blue, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        title: Text(
          product.productTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.productDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Price : "),
                const SizedBox(width: 10),
                Text(product.productPrice.toString()),
                const SizedBox(width: 10),
                const Text("Rating : "),
                const SizedBox(width: 10),
                Text(product.productRating.productRating.toString()),
              ],
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final isInCart = state.cartItems.contains(product);
                final itemCount = state.cartItems.where((item) => item == product).length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange, // Change to your desired color
                            foregroundColor: Colors.white, // Change the text color to white
                          ),
                          child: const Text('Add to Cart'),
                        ),
                        if (isInCart)
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context).add(RemoveFromCart(product: product));
                            },
                            child: const Text('Remove from Cart'),
                          ),
                      ],
                    ),
                    if (isInCart)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('Quantity in cart: $itemCount'),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        leading: SizedBox(
          height: 70,
          width: 70,
          child: Image.network(product.productImage),
        ),
      ),
    );
  }
}
