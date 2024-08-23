import 'package:bagit/common/styles/shadows.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/icons/add_to_cart.dart';
import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomProductCardVertical extends StatelessWidget {
  const CustomProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return GestureDetector(
        onTap: () {},
        child: Container(
            width: 180,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              boxShadow: [CustomShadowStyle.verticalProductShadow],
              borderRadius:
                  BorderRadius.circular(CustomSizes.productImageRadius),
              color: dark ? CustomColors.darkerGrey : CustomColors.softGrey,
            ),
            child: Column(children: [
              // - Thumbnail, wishlist button, discount tag
              CustomRoundedContainer(
                  height: 136,
                  padding: const EdgeInsets.all(CustomSizes.sm),
                  backgroundColor:
                      dark ? CustomColors.dark : CustomColors.light,
                  child: Stack(children: [
                    // - Thumbnail
                    const CustomRoundedImage(
                        height: CustomSizes.productImageSize,
                        imageUrl: CustomImages.productImage1,
                        applyImageRadius: true),

                    // - On sale tag
                    Positioned(
                      top: 10,
                      child: CustomRoundedContainer(
                        radius: CustomSizes.sm,
                        backgroundColor:
                            CustomColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomSizes.sm,
                            vertical: CustomSizes.xs),
                        child: Text('25%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: CustomColors.black)),
                      ),
                    ),

                    // - Favorite icon button
                    const Positioned(
                        top: 0,
                        right: 0,
                        child: CustomCircularIcon(
                            icon: Iconsax.heart5,
                            color: Colors.red,
                            backgroundColor: Colors.transparent))
                  ])),
              const SizedBox(height: CustomSizes.spaceBtwItems / 2),

              // -- Product Details
              Padding(
                padding: const EdgeInsets.only(left: CustomSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomProductTitleText(
                        title: 'Pink Casual Shoes', smallSize: true),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        Text('VShoes',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(width: CustomSizes.xs),
                        const Icon(Iconsax.verify5,
                            color: CustomColors.primary,
                            size: CustomSizes.iconxs)
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // -- Price
                        Padding(
                          padding: EdgeInsets.only(left: CustomSizes.sm),
                          child: CustomProductPrice(price: '14.99'),
                        ),
                        // -- Add to cart button
                        CustomAddToCart(),
                      ],
                    )
            ])));
    // );
  }
}
