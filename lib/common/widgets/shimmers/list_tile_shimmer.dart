import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomListTileShimmer extends StatelessWidget {
  const CustomListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            CustomShimmerEffect(
              width: 50,
              height: 50,
              radius: 50,
            ),
            SizedBox(width: CustomSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerEffect(width: 100, height: 15),
                SizedBox(height: CustomSizes.spaceBtwItems / 2),
                CustomShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        ),
      ],
    );
  }
}
