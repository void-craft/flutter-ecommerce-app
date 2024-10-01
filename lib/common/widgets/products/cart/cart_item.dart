import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/features/shop/models/cart_item_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // -- Image
      CustomRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(CustomSizes.sm),
          backgroundColor: CustomHelperFunctions.isDarkMode(context)
              ? CustomColors.darkerGrey
              : CustomColors.light),
      const SizedBox(width: CustomSizes.spaceBtwItems),

      // -- Title, Price & Size
      Expanded(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            CustomBrandTitleTextVerifiedIcon(title: cartItem.brandName ?? ''),
            Flexible(
                child:
                    CustomProductTitleText(title: cartItem.title, maxLines: 1)),
            // -- Attributes
            Text.rich(TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map((e) => TextSpan(children: [
                          TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: ' ${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge)
                        ]))
                    .toList()))
          ]))
    ]);
  }
}
