import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/screens/product_details/product_detail.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantity(product.id);
        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0
                ? CustomColors.primary
                : CustomColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(CustomSizes.cardRadiusMd),
              bottomRight: Radius.circular(CustomSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: CustomSizes.iconLg * 1.2,
            height: CustomSizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: CustomColors.white),
                    )
                  : const Icon(Iconsax.add, color: CustomColors.white),
            ),
          ),
        );
      }),
    );
  }
}
