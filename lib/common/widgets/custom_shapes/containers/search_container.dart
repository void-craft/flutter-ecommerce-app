import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/device/device_utility.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class CustomSearchContainer extends StatelessWidget {
  const CustomSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: CustomSizes.defaultSpace),
        child: Container(
          width: CustomDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(CustomSizes.md),
          decoration: BoxDecoration(
              color: showBackground ? dark ? CustomColors.dark : CustomColors.light : Colors.transparent,
              borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
              border: showBorder ? Border.all(color: CustomColors.grey) : null),
          child: Row(
            children: [
              Icon(icon,
                  color: CustomColors.darkerGrey),
              const SizedBox(width: CustomSizes.spaceBtwItems),
              Text(text ,
                  style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
    );
  }
}
