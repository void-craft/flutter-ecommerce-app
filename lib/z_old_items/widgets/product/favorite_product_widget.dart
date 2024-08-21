// import 'package:bagit/bloc/cart/cart_bloc.dart';
// import 'package:bagit/bloc/cart/cart_state.dart';
// import 'package:bagit/bloc/favorites/favorites_bloc.dart';
// import 'package:bagit/bloc/favorites/favorites_event.dart';
// import 'package:bagit/bloc/favorites/favorites_state.dart';
// import 'package:bagit/model/product/product.dart';
// import 'package:bagit/screens/item_detail/item_detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class FavoriteProduct extends StatelessWidget {
//   final Product product;

//   const FavoriteProduct({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ItemDetailScreen(product: product),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Row(
//             children: [
//               // Fixed-size image container
//               Container(
//                 width: 100,
//                 height: 100,
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: Image.network(
//                     product.productImage,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               // Content
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product.productTitle,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           RatingBar.builder(
//                             initialRating: product.productRating.productRating,
//                             minRating: 1,
//                             direction: Axis.horizontal,
//                             allowHalfRating: true,
//                             itemCount: 5,
//                             itemSize: 16,
//                             itemBuilder: (context, _) => const Icon(
//                               Icons.star,
//                               color: Colors.amber,
//                             ),
//                             onRatingUpdate: (rating) {},
//                             ignoreGestures: true,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             "(${product.productRating.productCount})",
//                             style: const TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '€${product.productPrice.toString()}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           BlocBuilder<FavoritesBloc, FavoritesState>(
//                             builder: (context, favoritesState) {
//                               final isFavorite = favoritesState.favoriteItems.any(
//                                 (item) => item.productId == product.productId,
//                               );
//                               return IconButton(
//                                 icon: Icon(
//                                   isFavorite ? Icons.favorite : Icons.favorite_border,
//                                   color: isFavorite ? Colors.purple : Colors.grey,
//                                 ),
//                                 onPressed: () {
//                                   if (isFavorite) {
//                                     BlocProvider.of<FavoritesBloc>(context).add(
//                                       RemoveFromFavorites(product: product),
//                                     );
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('${product.productTitle} removed from favorites')),
//                                     );
//                                   } else {
//                                     BlocProvider.of<FavoritesBloc>(context).add(
//                                       AddToFavorites(product: product),
//                                     );
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('${product.productTitle} added to favorites')),
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       // Conditionally display "Move To Cart" button
//                       BlocBuilder<CartBloc, CartState>(
//                         builder: (context, cartState) {
//                           final isInCart = cartState.cartItems.any(
//                             (item) => item.productId == product.productId,
//                           );

//                           return Visibility(
//                             visible: !isInCart,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: Colors.green,
//                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 BlocProvider.of<FavoritesBloc>(context).add(MoveToCartEvent(product: product));
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('${product.productTitle} moved to cart')),
//                                 );
//                               },
//                               child: const Text("Move To Cart"),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
// // import 'package:buy_it_app/bloc/cart/cart_state.dart';
// // import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
// // import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
// // import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
// // import 'package:buy_it_app/model/product/product.dart';
// // import 'package:buy_it_app/screens/item_detail/item_detail_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// // class FavoriteProduct extends StatelessWidget {
// //   final Product product;

// //   const FavoriteProduct({super.key, required this.product});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => ItemDetailScreen(product: product),
// //           ),
// //         );
// //       },
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //         child: Card(
// //           shape: RoundedRectangleBorder(
// //             side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
// //             borderRadius: BorderRadius.circular(5),
// //           ),
// //           child: Row(
// //             children: [
// //               // Fixed-size image container
// //               Container(
// //                 width: 100, // Fixed width for image container
// //                 height: 100, // Fixed height for image container
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Center(
// //                   child: Image.network(
// //                     product.productImage,
// //                     fit: BoxFit.contain, // Ensures the whole image is visible
// //                   ),
// //                 ),
// //               ),
// //               // Content
// //               Expanded(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         product.productTitle,
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: const TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 16,
// //                           color: Colors.black,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Row(
// //                         children: [
// //                           RatingBar.builder(
// //                             initialRating: product.productRating.productRating,
// //                             minRating: 1,
// //                             direction: Axis.horizontal,
// //                             allowHalfRating: true,
// //                             itemCount: 5,
// //                             itemSize: 16,
// //                             itemBuilder: (context, _) => const Icon(
// //                               Icons.star,
// //                               color: Colors.amber,
// //                             ),
// //                             onRatingUpdate: (rating) {},
// //                             ignoreGestures: true, // To make it read-only
// //                           ),
// //                           const SizedBox(width: 4),
// //                           Text(
// //                             "(${product.productRating.productCount})",
// //                             style: const TextStyle(
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Row(
// //                         children: [
// //                           Text(
// //                             '€${product.productPrice.toString()}',
// //                             style: const TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 8),
// //                           BlocBuilder<FavoritesBloc, FavoritesState>(
// //                             builder: (context, favoritesState) {
// //                               final isFavorite = favoritesState.favoriteItems.any(
// //                                 (item) => item.productId == product.productId,
// //                               );
// //                               return IconButton(
// //                                 icon: Icon(
// //                                   isFavorite ? Icons.favorite : Icons.favorite_border,
// //                                   color: isFavorite ? Colors.purple : Colors.grey,
// //                                 ),
// //                                 onPressed: () {
// //                                   if (isFavorite) {
// //                                     BlocProvider.of<FavoritesBloc>(context).add(
// //                                       RemoveFromFavorites(product: product),
// //                                     );
// //                                     ScaffoldMessenger.of(context).showSnackBar(
// //                                       SnackBar(content: Text('${product.productTitle} removed from favorites')),
// //                                     );
// //                                   } else {
// //                                     BlocProvider.of<FavoritesBloc>(context).add(
// //                                       AddToFavorites(product: product),
// //                                     );
// //                                     ScaffoldMessenger.of(context).showSnackBar(
// //                                       SnackBar(content: Text('${product.productTitle} added to favorites')),
// //                                     );
// //                                   }
// //                                 },
// //                               );
// //                             },
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 8),
// //                       // Conditionally display "Move To Cart" button
// //                       BlocBuilder<CartBloc, CartState>(
// //                         builder: (context, cartState) {
// //                           final isInCart = cartState.cartItems.any(
// //                             (item) => item.productId == product.productId,
// //                           );

// //                           return Visibility(
// //                             visible: !isInCart, // Show button only if not in cart
// //                             child: ElevatedButton(
// //                               style: ElevatedButton.styleFrom(
// //                                 foregroundColor: Colors.white,
// //                                 backgroundColor: Colors.green, // Button color
// //                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                 ),
// //                               ),
// //                               onPressed: () {
// //                                 BlocProvider.of<FavoritesBloc>(context).add(MoveToCartEvent(product: product));
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(content: Text('${product.productTitle} moved to cart')),
// //                                 );
// //                               },
// //                               child: const Text("Move To Cart"),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
