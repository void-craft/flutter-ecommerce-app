import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/screens/brand/brand_products.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBrandShowcase extends StatelessWidget {
  const CustomBrandShowcase(
      {super.key, required this.images, required this.brand});

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.to(() => BrandProductsScreen(brand: brand)),
        child: CustomRoundedContainer(
            showBorder: true,
            borderColor: CustomColors.darkGrey,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(CustomSizes.md),
            margin: const EdgeInsets.only(bottom: CustomSizes.spaceBtwItems),
            child: Column(children: [
              // Brand with product count
              CustomBrandCard(showBorder: false, brand: brand),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Brand's top 3 products
              Row(
                  children: images
                      .map(
                          (image) => brandTopProductImageWidget(image, context))
                      .toList())
            ])));
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: CustomRoundedContainer(
          height: 100,
          padding: const EdgeInsets.all(CustomSizes.md),
          margin: const EdgeInsets.only(right: CustomSizes.sm),
          backgroundColor: CustomHelperFunctions.isDarkMode(context)
              ? CustomColors.darkerGrey
              : CustomColors.light,
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const CustomShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
    );
  }
}
