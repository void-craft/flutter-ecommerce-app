import 'package:bagit/common/widgets/products/cart/add_remove_button.dart';
import 'package:bagit/common/widgets/products/cart/cart_item.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomCartItems extends StatelessWidget {
  const CustomCartItems({
    super.key, this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 2,
        separatorBuilder: (_, __) =>
            const SizedBox(height: CustomSizes.spaceBtwSections),
        itemBuilder: (_, index) => Column(children: [

              // -- Cart Item
              const CustomCartItem(),
              if (showAddRemoveButtons) const SizedBox(height: CustomSizes.spaceBtwItems),

              // -- Add & Remove button row with Total price
              if (showAddRemoveButtons)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      // -- Extra Space
                      SizedBox(width: 70),
                      // -- Add Remove Buttons
                      CustomProductQuanityWithAddRemoveButtons(),
                    ]),
                    // -- Total Price
                    CustomProductPrice(price: '14.99')
                  ])
            ]));
  }
}
