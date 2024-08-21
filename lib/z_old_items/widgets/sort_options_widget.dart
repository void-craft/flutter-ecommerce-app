// import 'package:bagit/old_items/bloc/all_products/all_products_bloc.dart';
// import 'package:bagit/old_items/bloc/all_products/all_products_event.dart';
// import 'package:bagit/old_items/bloc/all_products/all_products_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SortOptionsWidget extends StatelessWidget {
//   const SortOptionsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllProductsBloc, AllProductsState>(
//       builder: (context, state) {
//         final sortByPrice = state.sortByPrice ?? false;
//         final sortByRating = state.sortByRating ?? false;

//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton.icon(
//               onPressed: () {
//                 context.read<AllProductsBloc>().add(ToggleSortByPrice());
//               },
//               icon: Icon(
//                 sortByPrice ? Icons.arrow_downward : Icons.arrow_upward,
//               ),
//               label: const Text(
//                 'Price',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.black,
//               ),
//             ),
//             const SizedBox(width: 16),
//             TextButton.icon(
//               onPressed: () {
//                 context.read<AllProductsBloc>().add(ToggleSortByRating());
//               },
//               icon: Icon(
//                 sortByRating ? Icons.arrow_downward : Icons.arrow_upward,
//               ),
//               label: const Text(
//                 'Rating',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.black,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
