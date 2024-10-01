import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class CustomBillingAmountSection extends StatelessWidget {
  const CustomBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;

    return Column(children: [
      // -- Subtotal
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
        Text('€$subTotal', style: Theme.of(context).textTheme.bodyMedium)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),

      // -- Shipping Fee
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Shipping Cost', style: Theme.of(context).textTheme.bodyMedium),
        Text(
            '€${CustomPricingCalculator.calculateShippingCost(subTotal, 'ES')}',
            style: Theme.of(context).textTheme.labelLarge)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),

      // -- Tax
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Tax', style: Theme.of(context).textTheme.bodyMedium),
        Text('€${CustomPricingCalculator.calculateTax(subTotal, 'ES')}',
            style: Theme.of(context).textTheme.labelLarge)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),

      // -- Order Total
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
        Text('€${CustomPricingCalculator.calculateTotalPrice(subTotal, 'ES')}',
            style: Theme.of(context).textTheme.titleMedium)
      ])
    ]);
  }
}
