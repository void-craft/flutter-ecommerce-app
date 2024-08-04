import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortOptionsWidget extends StatelessWidget {
  const SortOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsBloc, AllProductsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                context.read<AllProductsBloc>().add(ToggleSortByPrice());
              },
              icon: const Icon(Icons.sort),
              label: Text(
                state.sortByPrice == true ? 'Price: High to Low' : 'Price: Low to High',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            TextButton.icon(
              onPressed: () {
                context.read<AllProductsBloc>().add(ToggleSortByRating());
              },
              icon: const Icon(Icons.star_border),
              label: Text(
                state.sortByRating == true ? 'Rating: High to Low' : 'Rating: Low to High',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
