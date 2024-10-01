import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:flutter/material.dart';

class CustomVerticalProductShimmer extends StatelessWidget {
  const CustomVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CustomGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
            width: 180,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Image
              CustomShimmerEffect(width: 180, height: 180),
              SizedBox(height: CustomSizes.spaceBtwItems),

              // Text
              CustomShimmerEffect(width: 160, height: 15),
              SizedBox(height: CustomSizes.spaceBtwItems / 2),
              CustomShimmerEffect(width: 10, height: 15)
            ])));
  }
}
