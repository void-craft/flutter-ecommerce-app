import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomAddToCart extends StatelessWidget {
  const CustomBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context); 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSizes.defaultSpace, vertical: CustomSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? CustomColors.darkGrey : CustomColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CustomSizes.cardRadiusLg),
          topRight: Radius.circular(CustomSizes.cardRadiusLg)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Minus Icon
              const CustomCircularIcon(icon: Iconsax.minus,
              backgroundColor: CustomColors.darkGrey,
              width: 40,
              height: 40,
              color: CustomColors.white,
              ),
              const SizedBox(width: CustomSizes.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: CustomSizes.spaceBtwItems),
              // Plus Icon
              const CustomCircularIcon(icon: Iconsax.minus,
              backgroundColor: CustomColors.black,
              width: 40,
              height: 40,
              color: CustomColors.white,
              )
            ]
          ),
          ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(CustomSizes.md),
              backgroundColor: CustomColors.black,
              side: const BorderSide(color: CustomColors.black)
            ),
            child: const Text('Add to Cart'))
        ],
      ),
    );
  }
}