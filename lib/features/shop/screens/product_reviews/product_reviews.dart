import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/products/ratings/rating_indicator.dart';
import 'package:bagit/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:bagit/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // -- AppBar
        appBar: const CustomAppBar(
            title: Text('Ratings & Reviews'), showBackArrow: true),
        // -- Body
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Ratings and reviews are from verified buyers."),
                      const SizedBox(height: CustomSizes.spaceBtwItems),

                      // -- Overall Product Ratings
                      const CustomOverallProductRating(),
                      const CustomRatingBarIndicator(rating: 3.5),
                      Text("12,611", style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: CustomSizes.spaceBtwSections),

                      // -- User Reviews List
                      const UserReviewCard(),
                      const UserReviewCard(),
                      const UserReviewCard(),
                    ]))));
  }
}

