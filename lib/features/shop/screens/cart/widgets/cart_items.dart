import 'package:bagit/common/widgets/products/cart/add_remove_button.dart';
import 'package:bagit/common/widgets/products/cart/cart_item.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCartItems extends StatelessWidget {
  const CustomCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: CustomSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
              final item = cartController.cartItems[index];
              return Column(children: [
                // -- Cart Item
                CustomCartItem(cartItem: item),
                if (showAddRemoveButtons)
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                // -- Add & Remove button row with Total price
                if (showAddRemoveButtons)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          // -- Extra Space
                          const SizedBox(width: 70),

                          // -- Add Remove Buttons
                          CustomProductQuanityWithAddRemoveButtons(
                              quantity: item.quantity,
                              add: () => cartController.addOneToCart(item),
                              remove: () => cartController.removeOneFromCart(item)),
                        ]),
                        // -- Total Price
                        CustomProductPrice(
                            price:
                                (item.price * item.quantity).toStringAsFixed(1))
                      ])
              ]);
            })));
  }
}
