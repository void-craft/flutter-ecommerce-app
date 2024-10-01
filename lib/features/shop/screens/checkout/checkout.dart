import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/common/widgets/products/cart/coupon_widget.dart';
import 'package:bagit/features/shop/controllers/order_controller.dart';
import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:bagit/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:bagit/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:bagit/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:bagit/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount =
        CustomPricingCalculator.calculateTotalPrice(subTotal, 'ES');
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: true,
            title: Text('Order Review',
                style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  // -- Items in Cart
                  const CustomCartItems(showAddRemoveButtons: false),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  // -- Coupon TextField
                  const CustomCouponCode(),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  // -- Billing Section
                  CustomRoundedContainer(
                      showBorder: true,
                      padding: const EdgeInsets.all(CustomSizes.md),
                      backgroundColor:
                          dark ? CustomColors.dark : CustomColors.white,
                      child: const Column(children: [
                        // -- Pricing
                        CustomBillingAmountSection(),
                        SizedBox(height: CustomSizes.spaceBtwItems),

                        // -- Divider
                        Divider(),
                        SizedBox(height: CustomSizes.spaceBtwItems),

                        // -- Payment Address
                        CustomBillingPaymentSection(),
                        SizedBox(height: CustomSizes.spaceBtwItems),

                        // -- Address
                        CustomBillingAddressSection()
                      ]))
                ]))),
        // -- Checkout Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: ElevatedButton(
              onPressed: () => subTotal > 0
                  ? () => orderController.processOrder(totalAmount)
                  : () => CustomLoaders.warningSnackbar(
                      title: 'Empty Cart',
                      message: 'Add items to the cart to proceed.'),
              child: Text('Checkout €$totalAmount')),
        ));
  }
}
