import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/widgets/custom_app_bar.dart'; // Import CustomAppBar

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Use CustomAppBar
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = state.cartItems[index];
              return ListTile(
                leading: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.network(cartItem.productImage),
                ),
                title: Text(
                  cartItem.productTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price: €${cartItem.productPrice}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: cartItem));
                          },
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(IncreaseQuantity(product: cartItem));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(
                      RemoveFromCart(product: cartItem),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_event.dart';
// import 'package:buy_it_app/bloc/cart/cart_state.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.pink,
//         title: const Text('Your Cart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//       ),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, state) {
//           if (state.cartItems.isEmpty) {
//             return const Center(child: Text('Your cart is empty.'));
//           }
//           return ListView.builder(
//             itemCount: state.cartItems.length,
//             itemBuilder: (context, index) {
//               final cartItem = state.cartItems[index];
//               return ListTile(
//                 leading: SizedBox(
//                   height: 70,
//                   width: 70,
//                   child: Image.network(cartItem.productImage),
//                 ),
//                 title: Text(
//                   cartItem.productTitle,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Price: €${cartItem.productPrice}',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.remove_circle_outline),
//                           onPressed: () {
//                             BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: cartItem));
//                           },
//                         ),
//                         Text('${cartItem.quantity}'),
//                         IconButton(
//                           icon: const Icon(Icons.add_circle_outline),
//                           onPressed: () {
//                             BlocProvider.of<CartBloc>(context).add(IncreaseQuantity(product: cartItem));
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     BlocProvider.of<CartBloc>(context).add(
//                       RemoveFromCart(product: cartItem),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
