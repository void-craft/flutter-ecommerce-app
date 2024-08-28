import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/icons/add_to_cart.dart';
import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomProductCardHorizontal extends StatelessWidget {
  const CustomProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSizes.productImageRadius),
        color: dark ? CustomColors.darkerGrey : CustomColors.softGrey,
      ),
      child: Row(
        children: [
          // -- Thumbnail
          CustomRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(CustomSizes.sm),
            backgroundColor: dark ? CustomColors.dark : CustomColors.white,
            child: Stack(
              children: [
                // -- Thumbnail Image
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: CustomRoundedImage(
                    imageUrl: CustomImages.productImage1,
                    applyImageRadius: true,
                  ),
                ),
                // -- Sale Tag
                Positioned(
                  top: 10,
                  child: CustomRoundedContainer(
                    radius: CustomSizes.sm,
                    backgroundColor: CustomColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: CustomSizes.sm,
                      vertical: CustomSizes.xs,
                    ),
                    child: Text(
                      '25%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: CustomColors.black),
                    ),
                  ),
                ),
                // - Favorite icon button
                const Positioned(
                  top: 0,
                  right: 0,
                  child: CustomCircularIcon(
                    icon: Iconsax.heart5,
                    color: Colors.red,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          // -- Details
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(
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
                        title: 'Pink Casual Shoes',
                        smallSize: true,
                      ),
                      SizedBox(height: CustomSizes.spaceBtwItems / 2),
                      CustomBrandTitleTextVerifiedIcon(title: 'V-Shoes'),
                    ],
                  ),
                  Spacer(),
                  // -- Price and Add to Cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // -- Pricing
                      Flexible(child: CustomProductPrice(price: '14.99')),

                      // -- Add to cart
                      CustomAddToCart(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
