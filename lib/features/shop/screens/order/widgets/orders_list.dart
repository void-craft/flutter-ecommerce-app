import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomOrderListItems extends StatelessWidget {
  const CustomOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (_, __) =>
            const SizedBox(height: CustomSizes.spaceBtwItems),
        itemBuilder: (_, index) => CustomRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(CustomSizes.md),
            backgroundColor: dark ? CustomColors.dark : CustomColors.light,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // -- Row 1
              Row(children: [
                // Icon
                const Icon(Iconsax.ship),
                const SizedBox(width: CustomSizes.spaceBtwItems / 2),

                // Status & Date
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('Processing',
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: CustomColors.primary, fontWeightDelta: 1)),
                      Text('12 Dec, 2024',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ])),
                // -- Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.arrow_right_34,
                        size: CustomSizes.iconSm))
              ]),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              //// -- Row 2 -- ////
              Row(children: [
                Expanded(
                    child: Row(children: [
                  // Icon
                  const Icon(Iconsax.tag),
                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),

                  // Status & Date
                  Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Order',
                            style: Theme.of(context).textTheme.labelMedium!),
                        Text('[#12345]',
                            style: Theme.of(context).textTheme.titleMedium)
                      ]))
                ])),
                // -- Row 3
                Expanded(
                    child: Row(children: [
                  // Icon
                  const Icon(Iconsax.calendar),
                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),

                  // Status & Date
                  Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Shipping Date',
                            style: Theme.of(context).textTheme.labelMedium!),
                        Text('13 Dec 2024',
                            style: Theme.of(context).textTheme.titleMedium),
                      ]))
                ]))
              ])
            ])));
  }
}
