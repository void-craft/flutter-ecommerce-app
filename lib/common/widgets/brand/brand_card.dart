import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class CustomBrandCard extends StatelessWidget {
  const CustomBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = CustomHelperFunctions.isDarkMode(context);
    return GestureDetector(
        onTap: onTap,

        // Container Design
        child: CustomRoundedContainer(
            padding: const EdgeInsets.all(
                CustomSizes.sm),
            showBorder: showBorder,
            backgroundColor: Colors.transparent,
            child: Row(children: [
              // - Icon
              Flexible(
                child: CustomCircularImage(
                    isNetworkImage: false,
                    image: CustomImages.clothesIcon,
                    backgroundColor:
                        Colors.transparent,
                    overlayColor:
                        isDark ? CustomColors.white : CustomColors.black),
              ),
              const SizedBox(
                  width:
                      CustomSizes.spaceBtwItems /
                          2),
          
              // -- Text
              Expanded(
                child: Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const CustomBrandTitleTextVerifiedIcon(
                          title: 'VShoes',
                          brandTextSize:
                              TextSizes.large),
                      Text(
                        '256 Products',
                        overflow:
                            TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium,
                      )
                    ]),
              )
            ])));
  }
}
