import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomVerticalImageText extends StatelessWidget {
  const CustomVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = CustomColors.white,
    this.onTap,
    this.backgroundColor,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

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
            CustomCircularImage(
              padding: CustomSizes.sm * 1.4,
              image: image,
              isNetworkImage: isNetworkImage,
              fit: BoxFit.fitWidth,
              backgroundColor: backgroundColor ?? (dark ? CustomColors.black : CustomColors.white),
            ),

            // -- Text
            const SizedBox(height: CustomSizes.spaceBtwItems / 2),
            SizedBox(
                width: 55,
                child: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
      ),
    );
  }
}
