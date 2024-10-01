import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:flutter/material.dart';

class CustomCategoryShimmer extends StatelessWidget {
  const CustomCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: itemCount,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) =>
                const SizedBox(width: CustomSizes.spaceBtwItems),
            itemBuilder: (_, __) {
              return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    CustomShimmerEffect(width: 55, height: 55, radius: 55),
                    SizedBox(height: CustomSizes.spaceBtwItems / 2),
                    // Text
                    CustomShimmerEffect(width: 55, height: 8),
                  ]);
            }));
  }
}
