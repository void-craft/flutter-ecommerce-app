import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:bagit/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:bagit/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:bagit/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:bagit/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:bagit/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomBottomAddToCart(),
        body: SingleChildScrollView(
            child: Column(children: [
          // -- Product Image slider
          CustomProductImageSlider(product: product),

          // Product Detail
          Padding(
              padding: const EdgeInsets.only(
                  right: CustomSizes.defaultSpace,
                  left: CustomSizes.defaultSpace,
                  bottom: CustomSizes.defaultSpace),
              child: Column(children: [
                // -- Rating & Share button
                const CustomRatingShare(),
                
                // -- Price, Title, Stock & Brand
                CustomProductMetaData(product: product),

                // -- Attribures
                if (product.productType == ProductType.variable.toString())
                  CustomProductAttributes(product: product),
                if (product.productType == ProductType.variable.toString())
                  const SizedBox(height: CustomSizes.spaceBtwSections),
                
                // -- Checkout Button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout'))),
                const SizedBox(height: CustomSizes.spaceBtwSections),

                // -- Description
                const CustomSectionHeading(
                    title: 'Description', showActionButton: false),
                const SizedBox(height: CustomSizes.spaceBtwItems),
                ReadMoreText(
                  product.description ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Less',
                  moreStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w800),
                ),
                // -- Reviews
                const Divider(),
                const SizedBox(height: CustomSizes.spaceBtwItems),
                Row(children: [
                  const CustomSectionHeading(
                      title: 'Reviews(199)', showActionButton: false),
                  IconButton(
                      icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      onPressed: () =>
                          Get.to(() => const ProductReviewScreen()))
                ]),
                const SizedBox(height: CustomSizes.spaceBtwSections)
              ]))
        ])));
  }
}
