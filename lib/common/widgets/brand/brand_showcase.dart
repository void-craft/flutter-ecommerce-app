import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomBrandShowcase extends StatelessWidget {
  const CustomBrandShowcase({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedContainer(
      showBorder: true,
      borderColor: CustomColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(CustomSizes.md),
      margin: const EdgeInsets.only(bottom: CustomSizes.spaceBtwItems),
      child: Column(
        children: [
          // Brand with product count
          CustomBrandCard(showBorder: false, brand: BrandModel.empty()),

          // Brand's top 3 products
          Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList()

              // Expanded(
              //   child: CustomRoundedContainer(
              //     height: 100,
              //     backgroundColor: CustomHelperFunctions.isDarkMode(context)
              //         ? CustomColors.darkerGrey
              //         : CustomColors.light,
              //     margin: const EdgeInsets.only(right: CustomSizes.sm),
              //     padding: const EdgeInsets.all(CustomSizes.md),
              //     child: const Image(
              //         fit: BoxFit.contain,
              //         image: AssetImage(CustomImages.productImage3)),
              //   ),
              // ),

              )
        ],
      ),
    );
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
      child: Image(
          fit: BoxFit.contain, image: AssetImage(image)),
    ));
  }
}
