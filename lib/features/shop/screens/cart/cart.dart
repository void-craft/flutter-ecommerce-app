import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/products/cart/add_remove_button.dart';
import 'package:bagit/common/widgets/products/cart/cart_item.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: true,
            title:
                Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
        body: Padding(
            padding: const EdgeInsets.all(CustomSizes.defaultSpace),
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: CustomSizes.spaceBtwSections),
                itemBuilder: (_, index) => const Column(children: [
                      CustomCartItem(),
                      SizedBox(height: CustomSizes.spaceBtwItems),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              // -- Extra Space
                              SizedBox(width: 70),
                              // -- Add Remove Buttons
                              CustomProductQuanityWithAddRemoveButtons(),
                            ]),
                            CustomProductPrice(price: '14.99')
                          ])
                    ]))),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: ElevatedButton(
              onPressed: () {}, child: const Text('Checkout €200.0')),
        ));
  }
}
