import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class CustomProductImageSlider extends StatelessWidget {
  const CustomProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return CustomCurvedEdgesWidget(
        child: Container(
            color: dark ? CustomColors.darkerGrey : CustomColors.light,
            child: Stack(children: [
              // --- Main Large Image
              const SizedBox(
                  height: 400,
                  child: Padding(
                    padding:
                        EdgeInsets.all(CustomSizes.productImageRadius * 2),
                    child: Center(
                        child: Image(
                            image: AssetImage(CustomImages.productImage1))),
                  )),
              // --- Image Slider
              Positioned(
                  right: 0,
                  bottom: 30,
                  left: CustomSizes.defaultSpace,
                  child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (_, __) => const SizedBox(
                              width: CustomSizes.spaceBtwItems),
                          itemBuilder: (_, index) => CustomRoundedImage(                            
                              width: 80,
                              backgroundColor: dark
                                  ? CustomColors.dark
                                  : CustomColors.white,
                              border: Border.all(color: CustomColors.primary),
                              padding: const EdgeInsets.all(CustomSizes.sm),
                              imageUrl: CustomImages.productImage3)))),
              // -- AppBar Icons
              CustomAppBar(
                showBackArrow: true,
                actions: [
                  CustomCircularIcon(
                    backgroundColor: Colors.black.withOpacity(0.1),
                    icon: Iconsax.heart5,
                    color: Colors.red
                  )
                ],
              )
            ])));
  }
}
