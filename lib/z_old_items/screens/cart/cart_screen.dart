// import 'package:bagit/bloc/cart/cart_bloc.dart';
// import 'package:bagit/bloc/cart/cart_state.dart';
// import 'package:bagit/model/product/product.dart';
// // import 'package:bagit/screens/address_screen/address_screen.dart';
// import 'package:bagit/widgets/product/cart_product_widget.dart';
// import 'package:bagit/widgets/appbar/custom_appbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   CartScreenState createState() => CartScreenState();
// }

// class CartScreenState extends State<CartScreen> {
//   final Map<Product, bool> _selectedItems = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         showBackButton: true,
//         isTitleCentered: false,
//         title: "Cart",
//       ),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, cartState) {
//           if (cartState.cartItems.isEmpty) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 20),
//                   Text(
//                     'Your cart is empty :(',
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           double totalAmount = 0.0;
//           for (var item in cartState.cartItems) {
//             if (_selectedItems[item] ?? false) {
//               totalAmount += item.productPrice * item.quantity;
//             }
//           }

//           return Column(
//             children: [
//               ListTile(
//                 leading: Checkbox(
//                   value: _selectedItems.length == cartState.cartItems.length,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       if (value == true) {
//                         for (var item in cartState.cartItems) {
//                           _selectedItems[item] = true;
//                         }
//                       } else {
//                         _selectedItems.clear();
//                       }
//                     });
//                   },
//                 ),
//                 title: const Text('Select All'),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: cartState.cartItems.length,
//                   itemBuilder: (context, index) {
//                     final cartItem = cartState.cartItems[index];
//                     return CartProductWidget(
//                       product: cartItem,
//                       isSelected: _selectedItems[cartItem] ?? false,
//                       onSelect: (bool? value) {
//                         setState(() {
//                           _selectedItems[cartItem] = value ?? false;
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Total: €${totalAmount.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Navigator.push(
//                       // context,
//                       // MaterialPageRoute(
//                         // builder: (context) => AddressEntryScreen(totalAmount: totalAmount),
//                       // ),
//                     // );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: Colors.blue, // White text color
//                     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text('Checkout'),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
