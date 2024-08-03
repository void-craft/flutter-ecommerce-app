// sort_options_widget.dart

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
        String selectedOption = 'Price Low'; // Default selection
        if (state.sortByPrice != null) {
          selectedOption = state.sortByPrice! ? 'Price Low' : 'Price High';
        } else if (state.sortByRating != null) {
          selectedOption = state.sortByRating! ? 'Rating Low' : 'Rating High';
        }

        return SegmentedButton<String>(
          segments: const [
            ButtonSegment(
              value: 'Price Low',
              label: Row(
                children: [
                  Icon(Icons.arrow_upward, size: 16),
                  SizedBox(width: 8),
                  Text('Price Low'),
                ],
              ),
            ),
            ButtonSegment(
              value: 'Price High',
              label: Row(
                children: [
                  Icon(Icons.arrow_downward, size: 16),
                  SizedBox(width: 8),
                  Text('Price High'),
                ],
              ),
            ),
            ButtonSegment(
              value: 'Rating Low',
              label: Row(
                children: [
                  Icon(Icons.arrow_upward, size: 16),
                  SizedBox(width: 8),
                  Text('Rating Low'),
                ],
              ),
            ),
            ButtonSegment(
              value: 'Rating High',
              label: Row(
                children: [
                  Icon(Icons.arrow_downward, size: 16),
                  SizedBox(width: 8),
                  Text('Rating High'),
                ],
              ),
            ),
          ],
          selected: {selectedOption},
          onSelectionChanged: (Set<String> selection) {
            if (selection.isEmpty) return;

            final selectedOption = selection.first;
            if (selectedOption == 'Price Low') {
              context.read<AllProductsBloc>().add(const SortProductsByPrice(ascending: true));
            } else if (selectedOption == 'Price High') {
              context.read<AllProductsBloc>().add(const SortProductsByPrice(ascending: false));
            } else if (selectedOption == 'Rating Low') {
              context.read<AllProductsBloc>().add(const SortProductsByRating(ascending: true));
            } else if (selectedOption == 'Rating High') {
              context.read<AllProductsBloc>().add(const SortProductsByRating(ascending: false));
            }
          },
          emptySelectionAllowed: false,
        );
      },
    );
  }
}
