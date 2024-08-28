import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/screens/brand/brand_products.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text('Brands'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  // Heading
                  const CustomSectionHeading(
                      title: 'Brands', showActionButton: false),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // -- Brands
                  CustomGridLayout(
                      itemCount: 10,
                      mainAxisExtent: 80,
                      itemBuilder: (context, index) => CustomBrandCard(
                          showBorder: true,
                          onTap: () =>
                              Get.to(() => const BrandProductsScreen())))
                ]))));
  }
}
