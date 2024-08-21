// import 'package:bagit/bloc/favorites/favorites_bloc.dart';
// import 'package:bagit/bloc/favorites/favorites_state.dart';
// import 'package:bagit/screens/favorites/favorites_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FavoritesSummary extends StatelessWidget {
//   const FavoritesSummary({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavoritesBloc, FavoritesState>(
//       builder: (context, state) {
//         return IconButton(
//           icon: Stack(
//             children: [
//               const Icon(
//                 Icons.favorite,
//                 color: Colors.white,
//                 size: 30,
//               ),
//               if (state.favoriteItems.isNotEmpty)
//                 Positioned(
//                   left: 14,
//                   bottom: 12,
//                   child: Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       color: Colors.purple,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 16,
//                       minHeight: 16,
//                     ),
//                     child: Text(
//                       '${state.favoriteItems.length}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const FavoritesScreen(),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
