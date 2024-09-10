import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/screens/all_products/all_products.dart';
import 'package:bagit/features/shop/screens/store/widgets/category_brands.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCategoryTab extends StatelessWidget {
  const CustomCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
              padding: const EdgeInsets.all(CustomSizes.defaultSpace),
              child: Column(children: [
                // -- Brands
                CategoryBrands(category: category),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                // -- Products
                FutureBuilder(
                    future:
                        controller.getCategoryProducts(categoryId: category.id),
                    builder: (context, snapshot) {
                      // Helper funcation: handle loader, no record or error message
                      final response =
                          CustomCloudHelperFunctions.checkMultipleRecordState(
                              snapshot: snapshot,
                              loader: const CustomVerticalProductShimmer());
                      if (response != null) return response;

                      // Record found!
                      final products = snapshot.data!;

                      return Column(children: [
                        CustomSectionHeading(
                            title: 'You might like',
                            onPressed: () => Get.to(AllProductsScreen(
                                  title: category.name,
                                  futureMethod: controller.getCategoryProducts(
                                      categoryId: category.id, limit: -1),
                                ))),
                        const SizedBox(height: CustomSizes.spaceBtwItems),
                        CustomGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) =>
                                CustomProductCardVertical(
                                    product: products[index]))
                      ]);
                    })
              ]))
        ]);
  }
}
