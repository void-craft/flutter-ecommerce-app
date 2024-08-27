import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomBillingAmountSection extends StatelessWidget {
  const CustomBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // -- Subtotal
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
        Text('€34.99', style: Theme.of(context).textTheme.bodyMedium)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),

      // -- Shipping Fee
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Shipping Cost', style: Theme.of(context).textTheme.bodyMedium),
        Text('€4.99', style: Theme.of(context).textTheme.labelLarge)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),

      // -- Tax
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Tax', style: Theme.of(context).textTheme.bodyMedium),
        Text('€3.99', style: Theme.of(context).textTheme.labelLarge)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),

      // -- Order Total
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
        Text('€49.99', style: Theme.of(context).textTheme.titleMedium)
      ])
    ]);
  }
}
