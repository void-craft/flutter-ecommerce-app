import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomProductQuanityWithAddRemoveButtons extends StatelessWidget {
  const CustomProductQuanityWithAddRemoveButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        // Add Remove Buttons
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomCircularIcon(
            icon: Iconsax.minus,
            width: 32,
            height: 32,
            size: CustomSizes.md,
            color: CustomHelperFunctions.isDarkMode(context)
                ? CustomColors.white
                : CustomColors.black,
            backgroundColor: CustomHelperFunctions.isDarkMode(context)
                ? CustomColors.darkerGrey
                : CustomColors.light,
          ),
          const SizedBox(width: CustomSizes.spaceBtwItems),
          Text('2', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(width: CustomSizes.spaceBtwItems),
          const CustomCircularIcon(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: CustomSizes.md,
            color: CustomColors.white,
            backgroundColor: CustomColors.primary,
          )
        ]);
  }
}
