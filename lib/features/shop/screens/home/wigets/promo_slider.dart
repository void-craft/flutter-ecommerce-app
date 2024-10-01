import 'package:bagit/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:bagit/features/shop/controllers/banner_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPromoSlider extends StatelessWidget {
  const CustomPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      // Loader
      if (controller.isLoading.value) {
        return const CustomShimmerEffect(width: double.infinity, height: 190);
      }
      // No data found
      if (controller.banners.isEmpty) {
        return const Center(child: Text('No Data Found!'));
      } else {
        return Column(children: [
          CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)),
              items: controller.banners
                  .map((banner) => CustomRoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ))
                  .toList()),
          const SizedBox(height: CustomSizes.spaceBtwItems),
          Center(
              child: Obx(() => Row(mainAxisSize: MainAxisSize.min, children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      CustomCircularContainer(
                          width: 20,
                          height: 4,
                          margin: const EdgeInsets.only(right: 10),
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? CustomColors.primary
                                  : CustomColors.grey)
                  ])))
        ]);
      }
    });
  }
}
