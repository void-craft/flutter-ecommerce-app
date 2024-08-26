import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/products/ratings/rating_indicator.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          const CircleAvatar(
              backgroundImage: AssetImage(CustomImages.reviewUser1)),
          const SizedBox(width: CustomSizes.spaceBtwItems),
          Text('John Doe', style: Theme.of(context).textTheme.titleLarge)
        ]),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems),

      // -- Review
      Row(children: [
        const CustomRatingBarIndicator(rating: 4),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        Text('01 Aug, 2024', style: Theme.of(context).textTheme.bodyMedium)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems),
      const ReadMoreText(
        'Purchasing the products I needed was easy because of the simple to use interface of the app. I would totally recommend this product and the app.',
        trimLines: 1,
        trimMode: TrimMode.Line,
        trimExpandedText: ' show less',
        trimCollapsedText: ' show more',
        moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: CustomColors.primary),
        lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: CustomColors.primary),
      ),
      const SizedBox(height: CustomSizes.spaceBtwItems),
      // -- Company Review
      CustomRoundedContainer(
          backgroundColor: dark ? CustomColors.darkerGrey : CustomColors.grey,
          child: Padding(
              padding: const EdgeInsets.all(CustomSizes.md),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("T's Store",
                          style: Theme.of(context).textTheme.titleMedium),
                      Text("02 Aug, 2024",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ]),
                const SizedBox(height: CustomSizes.spaceBtwItems),
                const ReadMoreText(
                  'Purchasing the products I needed was easy because of the simple to use interface of the app. I would totally recommend this product and the app.',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary),
                )
              ]))),
      const SizedBox(height: CustomSizes.spaceBtwSections)
    ]);
  }
}
