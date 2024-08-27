import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:bagit/features/shop/screens/checkout/checkout.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: true,
            title:
                Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
        body: const Padding(
            padding: EdgeInsets.all(CustomSizes.defaultSpace),
            // -- Items in Cart
            child: CustomCartItems()
        ),
        // -- Checkout Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: ElevatedButton(
              onPressed: () => Get.to(() => const CheckoutScreen()), child: const Text('Checkout €200.0')),
        ));
  }
}
