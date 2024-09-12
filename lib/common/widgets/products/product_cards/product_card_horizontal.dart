import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/icons/add_to_cart.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomProductCardHorizontal extends StatelessWidget {
  const CustomProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    final dark = CustomHelperFunctions.isDarkMode(context);

    return Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomSizes.productImageRadius),
          color: dark ? CustomColors.darkerGrey : CustomColors.softGrey,
        ),
        child: Row(children: [
          // -- Thumbnail
          CustomRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(CustomSizes.sm),
              backgroundColor: dark ? CustomColors.dark : CustomColors.white,
              child: Stack(children: [
                // -- Thumbnail Image
                SizedBox(
                    height: 120,
                    width: 120,
                    child: CustomRoundedImage(
                        imageUrl: product.thumbnail,
                        applyImageRadius: true,
                        isNetworkImage: true)),
                // -- Sale Tag
                if (salePercentage != null)
                  Positioned(
                      top: 10,
                      child: CustomRoundedContainer(
                          radius: CustomSizes.sm,
                          backgroundColor:
                              CustomColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: CustomSizes.sm,
                            vertical: CustomSizes.xs,
                          ),
                          child: Text('$salePercentage%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: CustomColors.black)))),

                // - Favorite icon button
                Positioned(
                    top: 0,
                    right: 0,
                    child: CustomFavoriteIcon(productId: product.id))
              ])),
          // -- Details
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: CustomSizes.sm,
                    left: CustomSizes.sm,
                    right: CustomSizes.sm,
                    bottom: CustomSizes.sm,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // -- Title and Brand
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomProductTitleText(
                                title: product.title,
                                smallSize: true,
                              ),
                              const SizedBox(
                                  height: CustomSizes.spaceBtwItems / 2),
                              CustomBrandTitleTextVerifiedIcon(
                                  title: product.brand!.name)
                            ]),
                        const Spacer(),
                        // -- Price and Add to Cart
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // -- Pricing
                              Flexible(
                                  child: Column(children: [
                                if (product.productType ==
                                        ProductType.single.toString() &&
                                    product.salePrice > 0)
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: CustomSizes.sm),
                                      child: Text(product.price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .apply(
                                                  decoration: TextDecoration
                                                      .lineThrough))),
                                // Price, show sole price as main price if sale exist.
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: CustomSizes.sm),
                                    child: CustomProductPrice(
                                        price: controller
                                            .getProductPrice(product)))
                              ])),

                              // -- Add to cart
                              const CustomAddToCart()
                            ])
                      ])))
        ]));
  }
}
