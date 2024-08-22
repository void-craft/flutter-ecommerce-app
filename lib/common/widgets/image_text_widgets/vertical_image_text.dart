import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomVerticalImageText extends StatelessWidget {
  const CustomVerticalImageText({
    super.key, required this.image, required this.title, this.textColor = CustomColors.white, this.backgroundColor = CustomColors.white, this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: CustomSizes.spaceBtwItems),
        child: Column(
          children: [
            // Circular icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(CustomSizes.sm),
              decoration: BoxDecoration(
                  color: backgroundColor ?? (dark ? CustomColors.black : CustomColors.white),
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Center(
                child: Image(image: AssetImage(image), fit: BoxFit.cover, color: dark ? CustomColors.dark : CustomColors.light),
              ),
            ),
            
            // -- Text
            const SizedBox(height: CustomSizes.spaceBtwItems / 2),
            SizedBox(width: 55, child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis))
            ],
          ),
        ),
    );
    }
}