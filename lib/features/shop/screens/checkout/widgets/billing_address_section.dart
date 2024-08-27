import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomBillingAddressSection extends StatelessWidget {
  const CustomBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomSectionHeading(
        title: 'Shipping Address',
        buttonTitle: 'Change',
        onPressed: () {},
      ),
      Text('Void Craft', style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(width: CustomSizes.spaceBtwItems / 2),
      Row(children: [
        const Icon(Icons.phone, color: Colors.grey, size: 16),
        const SizedBox(width: CustomSizes.spaceBtwItems),
        Text('+34 123-456-789', style: Theme.of(context).textTheme.bodyMedium),
      ]),
      const SizedBox(width: CustomSizes.spaceBtwItems / 2),
      Row(
        children: [
          const Icon(Icons.phone, color: Colors.grey, size: 16),
          const SizedBox(width: CustomSizes.spaceBtwItems),
          Expanded(
              child: Text('Plaza España, 6, Oviedo, Asturias 33011, Spain',
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true))
        ]
      )
    ]);
  }
}
