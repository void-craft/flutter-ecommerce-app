import 'package:bagit/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/features/shop/controllers/home_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPromoSlider extends StatelessWidget {
  const CustomPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index)
                    ),
            items: banners.map((url) => CustomRoundedImage(imageUrl: url)).toList()
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  CustomCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carousalCurrentIndex.value == i
                              ? CustomColors.primary
                              : CustomColors.grey)
              ],
            ),
          ),
        )]);
  }
}
