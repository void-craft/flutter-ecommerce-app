import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/features/shop/controllers/product/images_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// DONE
class CustomProductImageSlider extends StatelessWidget {
  const CustomProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return CustomCurvedEdgesWidget(
        child: Container(
            color: dark ? CustomColors.darkerGrey : CustomColors.light,
            child: Stack(children: [
              // --- Main Large Image
              SizedBox(
                  height: 400,
                  child: Padding(
                      padding: const EdgeInsets.all(
                          CustomSizes.productImageRadius * 2),
                      child: Center(child: Obx(() {
                        final image = controller.selectedProductImage.value;
                        return GestureDetector(
                          onTap: () => controller.showEnlargedImage(image),
                          child: CachedNetworkImage(
                              imageUrl: image,
                              progressIndicatorBuilder: (_, __,
                                      downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: CustomColors.primary)),
                        );
                      })))),
              // --- Image Slider
              Positioned(
                  right: 0,
                  bottom: 30,
                  left: CustomSizes.defaultSpace,
                  child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: CustomSizes.spaceBtwItems),
                          itemBuilder: (_, index) => Obx(() {
                                final imageSelected =
                                    controller.selectedProductImage.value ==
                                        images[index];
                                return CustomRoundedImage(
                                  width: 80,
                                  isNetworkImage: true,
                                  imageUrl: images[index],
                                  backgroundColor: dark
                                      ? CustomColors.dark
                                      : CustomColors.white,
                                  onPressed: () => controller
                                      .selectedProductImage
                                      .value = images[index],
                                  border: Border.all(
                                      color: imageSelected
                                          ? CustomColors.primary
                                          : Colors.transparent),
                                  padding: const EdgeInsets.all(CustomSizes.sm),
                                );
                              })))),
              // -- AppBar Icons
              CustomAppBar(
                showBackArrow: true,
                actions: [
                  CustomCircularIcon(
                      backgroundColor: Colors.black.withOpacity(0.1),
                      icon: Iconsax.heart5,
                      color: Colors.red)
                ],
              )
            ])));
  }
}
