import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/model/product/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buy_it_app/screens/item_detail/item_detail_screen.dart'; 

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            side: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            product.productTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 53, 53, 53))
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
                  Text(
                    '€${product.productPrice.toString()}', style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
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
                    ignoreGestures: true, // To make it read-only
                  ),
                  const SizedBox(width: 10),
                  Text("(${product.productRating.productCount})"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        final isFavorite = state.favoriteItems.any((item) => item.productId == product.productId);
                        return Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.purple : Colors.grey,
                        );
                      },
                    ),
                    onPressed: () {
                      final isFavorite = BlocProvider.of<FavoritesBloc>(context).state.favoriteItems.any((item) => item.productId == product.productId);
                      if (isFavorite) {
                        BlocProvider.of<FavoritesBloc>(context).add(RemoveFromFavorites(product: product));
                      } else {
                        BlocProvider.of<FavoritesBloc>(context).add(AddToFavorites(product: product));
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Color.fromARGB(255, 238, 82, 80),),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: product));
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        final currentItem = state.cartItems.firstWhere(
                          (item) => item.productId == product.productId,
                          orElse: () => product.copyWith(quantity: 0),
                        );
                        return Text(currentItem.quantity.toString());
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.green,),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
                    },
                  ),
                ],
              ),
            ],
          ),
          leading: SizedBox(
            height: 60,
            width: 60,
            child: Image.network(product.productImage),
          ),
        ),
      ),
    );
  }
}


// // single_product.dart

// import 'package:buy_it_app/bloc/cart/cart_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_event.dart';
// import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
// import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
// import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
// import 'package:buy_it_app/model/product/product.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class SingleProduct extends StatelessWidget {
//   final Product product;
//   const SingleProduct({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       child: ListTile(
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: Colors.grey, width: 0.5),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         title: Text(
//           product.productTitle,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 53, 53, 53))
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.productDescription,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   '€${product.productPrice.toString()}', style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 10),
//                 RatingBar.builder(
//                   initialRating: product.productRating.productRating,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 20,
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {},
//                   ignoreGestures: true, // To make it read-only
//                 ),
//                 const SizedBox(width: 10),
//                 Text("(${product.productRating.productCount})"),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 IconButton(
//                   icon: BlocBuilder<FavoritesBloc, FavoritesState>(
//                     builder: (context, state) {
//                       final isFavorite = state.favoriteItems.any((item) => item.productId == product.productId);
//                       return Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.purple : Colors.grey,
//                       );
//                     },
//                   ),
//                   onPressed: () {
//                     final isFavorite = BlocProvider.of<FavoritesBloc>(context).state.favoriteItems.any((item) => item.productId == product.productId);
//                     if (isFavorite) {
//                       BlocProvider.of<FavoritesBloc>(context).add(RemoveFromFavorites(product: product));
//                     } else {
//                       BlocProvider.of<FavoritesBloc>(context).add(AddToFavorites(product: product));
//                     }
//                   },
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   icon: const Icon(Icons.remove_circle_outline, color: Color.fromARGB(255, 238, 82, 80),),
//                   onPressed: () {
//                     BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: product));
//                   },
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: BlocBuilder<CartBloc, CartState>(
//                     builder: (context, state) {
//                       final currentItem = state.cartItems.firstWhere(
//                         (item) => item.productId == product.productId,
//                         orElse: () => product.copyWith(quantity: 0),
//                       );
//                       return Text(currentItem.quantity.toString());
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add_circle_outline, color: Colors.green,),
//                   onPressed: () {
//                     BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//         leading: SizedBox(
//           height: 60,
//           width: 60,
//           child: Image.network(product.productImage),
//         ),
//       ),
//     );
//   }
// }
