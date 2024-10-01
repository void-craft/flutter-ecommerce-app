import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomBoxesShimmer extends StatelessWidget {
  const CustomBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomShimmerEffect(width: 150, height: 110),
            ),
            SizedBox(width: CustomSizes.spaceBtwItems),
            Expanded(
              child: CustomShimmerEffect(width: 150, height: 210),
            ),
            SizedBox(width: CustomSizes.spaceBtwItems),
            Expanded(
              child: CustomShimmerEffect(width: 150, height: 110),
            ),
          ],
        ),
      ],
    );
  }
}
