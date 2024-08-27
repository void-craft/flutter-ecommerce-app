import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // -- Image
      CustomRoundedImage(
          imageUrl: CustomImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(CustomSizes.sm),
          backgroundColor:
              CustomHelperFunctions.isDarkMode(context)
                  ? CustomColors.darkerGrey
                  : CustomColors.light),
      const SizedBox(width: CustomSizes.spaceBtwItems),
    
      // -- Title, Price & Size
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomBrandTitleTextVerifiedIcon(title: "V-Shoes"),
          const Flexible(child: CustomProductTitleText(title: "Pink Casual shoes")),
          // -- Attributes
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Color', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: 'Green', style: Theme.of(context).textTheme.bodyLarge),
                TextSpan(text: 'Size', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: 'EU39', style: Theme.of(context).textTheme.bodyLarge),
              ]
            )
          )
    ])
    ]);
  }
}
