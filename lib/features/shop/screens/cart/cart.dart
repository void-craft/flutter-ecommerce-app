import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/loaders/animation_loader.dart';
import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:bagit/features/shop/screens/checkout/checkout.dart';
import 'package:bagit/navigation_menu.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    
    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: true,
            title:
                Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
        body: Obx(() {
          // Nothing found widget
          final emptyWidget = CustomAnimationLoaderWidget(
              text: 'Cart is empty!',
              animation: CustomImages.lottieGhostIllustration,
              showAction: true,
              actionText: 'Let\'s fill it',
              onActionPressed: () => Get.off(() => const NavigationMenu()));

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(CustomSizes.defaultSpace),
                    // -- Items in Cart
                    child: CustomCartItems()));
          }
        }),
        // -- Checkout Button
        bottomNavigationBar: controller.cartItems.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const CheckoutScreen()),
                    child: Obx(() => Text(
                        'Checkout €${controller.totalCartPrice}')))));
  }
}
