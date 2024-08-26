import 'package:bagit/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';


class CustomOverallProductRating extends StatelessWidget {
  const CustomOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 3,
          child: Text('4.8',
              style:
                  Theme.of(context).textTheme.displayLarge)),
      const Expanded(
          flex: 7,
          child: Column(children: [
            CustomRatingProgressIndicator(
                text: '5', value: 1.0),
            CustomRatingProgressIndicator(
                text: '4', value: 0.8),
            CustomRatingProgressIndicator(
                text: '3', value: 0.6),
            CustomRatingProgressIndicator(
                text: '2', value: 0.4),
            CustomRatingProgressIndicator(
                text: '1', value: 0.2),
          ]))
    ]);
  }
}
