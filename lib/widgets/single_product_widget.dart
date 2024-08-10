import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/model/product/product.dart';
import 'package:buy_it_app/screens/item_detail/item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  final bool isFavorite;

  const SingleProduct({super.key, required this.product, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(product: product),
            ),
          );
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          leading: SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              product.productImage,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            product.productTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: product.productRating.productRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                    ignoreGestures: true,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "(${product.productRating.productCount})",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '€${product.productPrice.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.purple : Colors.grey,
                    ),
                    onPressed: () {
                      final isCurrentlyFavorite = BlocProvider.of<FavoritesBloc>(context).state.favoriteItems.any((item) => item.productId == product.productId);
                      if (isCurrentlyFavorite) {
                        BlocProvider.of<FavoritesBloc>(context).add(RemoveFromFavorites(product: product));
                      } else {
                        BlocProvider.of<FavoritesBloc>(context).add(AddToFavorites(product: product));
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: product));
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        final currentItem = state.cartItems.firstWhere(
                          (item) => item.productId == product.productId,
                          orElse: () => product.copyWith(quantity: 0),
                        );
                        return Text(
                          currentItem.quantity.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
