import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/screens/brand/brand_products.dart';
import 'package:bagit/features/shop/screens/brand/widget/brand_shimmer.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final brandController = BrandController.instance;
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
                  Obx(() {
                    if (brandController.isLoading.value) return const CustomBrandShimmer();
                    if (brandController.allBrands.isEmpty) {
                      return Center(
                        child: Text('No Data Found!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: Colors.white)),
                      );
                    }
                    return CustomGridLayout(
                        itemCount: brandController.allBrands.length,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          final brand = brandController.allBrands[index];
                          return CustomBrandCard(
                              showBorder: true,
                              brand: brand,
                              onTap: () => Get.to(() => BrandProductsScreen(brand: brand)));
                        });
                  })
                ]))));
  }
}
