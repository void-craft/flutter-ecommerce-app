import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:bagit/common/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/screens/all_products/all_products.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(category.name),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(CustomSizes.defaultSpace),
            child: Column(children: [
              // -- Banner -- //
              const CustomRoundedImage(
                  width: double.infinity,
                  imageUrl: CustomImages.promoBanner4,
                  applyImageRadius: true),
              const SizedBox(height: CustomSizes.spaceBtwSections),
              // -- Sub-Categories -- //
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    // Handle loader, no record, or error message
                    const loader = CustomHorizontalProductShimmer();
                    final widget =
                        CustomCloudHelperFunctions.checkMultipleRecordState(
                            snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    // Record found ****
                    final subCategories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];

                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                final widget = CustomCloudHelperFunctions
                                    .checkMultipleRecordState(
                                        snapshot: snapshot);
                                if (widget != null) return widget;

                                // Record found
                                final products = snapshot.data!;

                                return Column(children: [
                                  // -- Heading -- //
                                  CustomSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () =>
                                          Get.to(() => AllProductsScreen(
                                                title: subCategory.name,
                                                futureMethod: controller
                                                    .getCategoryProducts(
                                                        categoryId:
                                                            subCategory.id,
                                                        limit: -1),
                                              ))),
                                  const SizedBox(
                                      height: CustomSizes.spaceBtwItems / 2),
                                  SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                  width: CustomSizes
                                                      .spaceBtwItems),
                                          itemBuilder: (context, index) =>
                                              CustomProductCardHorizontal(
                                                  product: products[index]))),
                                  const SizedBox(
                                      height: CustomSizes.spaceBtwSections)
                                ]);
                              });
                        });
                  })
            ])));
  }
}
