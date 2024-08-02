import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/model/product/product.dart';
import 'package:buy_it_app/screens/item_detail/item_detail_screen.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        shape: BeveledRectangleBorder(
          side: const BorderSide(color: Colors.blue, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
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
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Quantity : "),
                const SizedBox(width: 10),
                Text(product.quantity.toString()),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(IncreaseQuantity(product: product));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: product));
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(product: product),
            ),
          );
        },
        trailing: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            final isFavorite = state.favoriteItems.contains(product);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                BlocProvider.of<FavoritesBloc>(context).add(
                  isFavorite ? RemoveFromFavorites(product: product) : AddToFavorites(product: product),
                );
              },
            );
          },
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_event.dart';
// import 'package:buy_it_app/bloc/cart/cart_state.dart';
// import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart'; // Import FavoritesBloc
// import 'package:buy_it_app/bloc/favorites/favorites_event.dart'; // Import FavoritesEvent
// import 'package:buy_it_app/bloc/favorites/favorites_state.dart'; // Import FavoritesState
// import 'package:buy_it_app/model/product/product.dart';

// class SingleProduct extends StatelessWidget {
//   final Product product;
//   const SingleProduct({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       child: ListTile(
//         shape: BeveledRectangleBorder(
//           side: const BorderSide(color: Colors.blue, width: 0.5),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         title: Text(
//           product.productTitle,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
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
//                 const Text("Price : "),
//                 const SizedBox(width: 10),
//                 Text(product.productPrice.toString()),
//                 const SizedBox(width: 10),
//                 const Text("Rating : "),
//                 const SizedBox(width: 10),
//                 Text(product.productRating.productRating.toString()),
//               ],
//             ),
//             BlocBuilder<CartBloc, CartState>(
//               builder: (context, state) {
//                 final isInCart = state.cartItems.contains(product);
//                 return Row(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                       ),
//                       child: const Text('Add to Cart'),
//                     ),
//                     if (isInCart)
//                       TextButton(
//                         onPressed: () {
//                           BlocProvider.of<CartBloc>(context).add(RemoveFromCart(product: product));
//                         },
//                         child: const Text('Remove from Cart'),
//                       ),
//                     IconButton(
//                       icon: BlocBuilder<FavoritesBloc, FavoritesState>(
//                         builder: (context, state) {
//                           final isFavorite = state.favoriteItems.contains(product);
//                           return Icon(
//                             isFavorite ? Icons.favorite : Icons.favorite_border,
//                             color: isFavorite ? Colors.red : Colors.grey,
//                           );
//                         },
//                       ),
//                       onPressed: () {
//                         BlocProvider.of<FavoritesBloc>(context).add(
//                           BlocProvider.of<FavoritesBloc>(context).state.favoriteItems.contains(product)
//                             ? RemoveFromFavorites(product: product)
//                             : AddToFavorites(product: product),
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//         leading: SizedBox(
//           height: 70,
//           width: 70,
//           child: Image.network(product.productImage),
//         ),
//       ),
//     );
//   }
// }
