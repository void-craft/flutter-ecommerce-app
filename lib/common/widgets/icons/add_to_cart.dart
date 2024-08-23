import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAddToCart extends StatelessWidget {
  const CustomAddToCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
          color: dark ? CustomColors.dark : CustomColors.black,
          borderRadius: const BorderRadius.only(
              topLeft:
                  Radius.circular(CustomSizes.cardRadiusMd),
              bottomRight: Radius.circular(
                  CustomSizes.productImageRadius))),
      child: SizedBox(
          width: CustomSizes.iconLg * 1.2,
          height: CustomSizes.iconLg * 1.2,
          child: Center(
              child: Icon(Iconsax.add,
                  color: dark ? CustomColors.light : CustomColors.white))),
    );
  }
}