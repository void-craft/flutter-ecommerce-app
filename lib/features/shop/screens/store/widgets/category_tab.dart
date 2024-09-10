import 'package:bagit/common/widgets/brand/brand_showcase.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomCategoryTab extends StatelessWidget {
  const CustomCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
              padding: const EdgeInsets.all(CustomSizes.defaultSpace),
              child: Column(children: [
                // -- Brands
                const CustomBrandShowcase(images: [
                  CustomImages.productImage3,
                  CustomImages.productImage2,
                  CustomImages.productImage1
                ]),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                // -- Products
                CustomSectionHeading(title: 'You might like', onPressed: () {}),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                CustomGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) =>
                        CustomProductCardVertical(product: ProductModel.empty())),
                const SizedBox(height: CustomSizes.spaceBtwItems)
              ]))
        ]);
  }
}
