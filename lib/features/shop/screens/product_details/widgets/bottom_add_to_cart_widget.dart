import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomAddToCart extends StatelessWidget {
  const CustomBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);

    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomSizes.defaultSpace,
            vertical: CustomSizes.defaultSpace / 2),
        decoration: BoxDecoration(
            color: dark ? CustomColors.darkGrey : CustomColors.light,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(CustomSizes.cardRadiusLg),
                topRight: Radius.circular(CustomSizes.cardRadiusLg))),
        child: Obx(() =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                // Minus Icon
                CustomCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: CustomColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: CustomColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: CustomSizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: CustomSizes.spaceBtwItems),
                // Plus Icon
                CustomCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: CustomColors.black,
                  width: 40,
                  height: 40,
                  color: CustomColors.white,
                  onPressed: () => controller.productQuantityInCart += 1,
                )
              ]),
              ElevatedButton(
                  onPressed: controller.productQuantityInCart.value < 1
                      ? null
                      : () => controller.addToCart(product),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(CustomSizes.md),
                      backgroundColor: CustomColors.black,
                      side: const BorderSide(color: CustomColors.black)),
                  child: const Text('Add to Cart'))
            ])));
  }
}
