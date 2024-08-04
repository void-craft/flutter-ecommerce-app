import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortOptionsWidget extends StatelessWidget {
  const SortOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 52, 152, 219); // Bright blue
    const secondaryColor = Color(0xFF2ecc71); // Bright green
    const onPrimaryColor = Color(0xFFFFFFFF); // White

    return BlocBuilder<AllProductsBloc, AllProductsState>(
      builder: (context, state) {
        final isPriceActive = state.sortByPrice != null;
        final isRatingActive = state.sortByRating != null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AllProductsBloc>().add(ToggleSortByPrice());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPriceActive ? primaryColor : secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                state.sortByPrice == true ? 'Price High' : 'Price Low',
                style: const TextStyle(
                  color: onPrimaryColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                context.read<AllProductsBloc>().add(ToggleSortByRating());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isRatingActive ? primaryColor : secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                state.sortByRating == true ? 'Rating High' : 'Rating Low',
                style: const TextStyle(
                  color: onPrimaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
