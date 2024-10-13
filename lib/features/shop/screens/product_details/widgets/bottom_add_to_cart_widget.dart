import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomAddToCart extends StatefulWidget {
  const CustomBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  State<CustomBottomAddToCart> createState() => _CustomBottomAddToCartState();
}

class _CustomBottomAddToCartState extends State<CustomBottomAddToCart> {
  final CartController controller = CartController.instance;
  RxInt readyToAddQuantity = 0.obs;

  @override
  void initState() {
    super.initState();
    // Load saved quantity from Firebase when initializing
    controller.getSelectedQuantityFromFirebase(widget.product.id).then((savedQuantity) {
      readyToAddQuantity.value = savedQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSizes.defaultSpace,
        vertical: CustomSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? CustomColors.darkGrey : CustomColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CustomSizes.cardRadiusLg),
          topRight: Radius.circular(CustomSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: CustomColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: CustomColors.white,
                  onPressed: () {
                    if (readyToAddQuantity.value > 0) {
                      readyToAddQuantity.value -= 1;
                      controller.saveSelectedQuantityToFirebase(widget.product.id, readyToAddQuantity.value);
                    }
                  },
                ),
                const SizedBox(width: CustomSizes.spaceBtwItems),
                Text(
                  readyToAddQuantity.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: CustomSizes.spaceBtwItems),
                CustomCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: CustomColors.black,
                  width: 40,
                  height: 40,
                  color: CustomColors.white,
                  onPressed: () {
                    readyToAddQuantity.value += 1;
                    controller.saveSelectedQuantityToFirebase(widget.product.id, readyToAddQuantity.value);
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: readyToAddQuantity.value < 1
                  ? null
                  : () {
                      controller.addToCart(widget.product, readyToAddQuantity.value);
                      readyToAddQuantity.value = 0;
                      controller.saveSelectedQuantityToFirebase(widget.product.id, 0);
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(CustomSizes.md),
                backgroundColor: CustomColors.black,
                side: const BorderSide(color: CustomColors.black),
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
