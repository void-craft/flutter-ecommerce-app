import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:flutter/material.dart';

class CustomBrandShimmer extends StatelessWidget {
  const CustomBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CustomGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const CustomShimmerEffect(width: 300, height: 80));
  }
}