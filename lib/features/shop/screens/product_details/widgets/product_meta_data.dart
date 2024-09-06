import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomProductMetaData extends StatelessWidget {
  const CustomProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = CustomHelperFunctions.isDarkMode(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // -- Price & Sale Price
      Row(children: [
        // -- Sale Tag
        CustomRoundedContainer(
          radius: CustomSizes.sm,
          backgroundColor: CustomColors.secondary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(
              horizontal: CustomSizes.sm, vertical: CustomSizes.xs),
          child: Text('25%',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: CustomColors.black)),
        ),
        const SizedBox(width: CustomSizes.spaceBtwItems),

        // -- Price
        Text('€250',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .apply(decoration: TextDecoration.lineThrough)),
        const SizedBox(width: CustomSizes.spaceBtwItems),
        const CustomProductPrice(price: '250', isLarge: true)
      ]),

      // -- Title
      const CustomProductTitleText(title: 'Pink Casual Shoes'),
      const SizedBox(height: CustomSizes.spaceBtwItems / 1.5),

      // -- Stock Status
      Row(
        children: [
          const CustomProductTitleText(title: 'Status'),
          const SizedBox(width: CustomSizes.spaceBtwItems),
          Text('In Stock', style: Theme.of(context).textTheme.titleMedium)
        ]
      ),
      const SizedBox(height: CustomSizes.spaceBtwItems / 1.5),

      // -- Brand
      Row(children: [
        CustomCircularImage(
          image: CustomImages.shoesIcon,
          width: 32,
          height: 32,
          overlayColor: darkMode ? CustomColors.white : CustomColors.black,
        ),
        const CustomBrandTitleTextVerifiedIcon(
            title: 'VShoes', brandTextSize: TextSizes.medium),
      ])
    ]);
  }
}
