import 'package:bagit/common/widgets/chips/choice_chips.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomProductAttributes extends StatelessWidget {
  const CustomProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Column(children: [
      // -- Selected Attribute Pricing & Description
      CustomRoundedContainer(
          padding: const EdgeInsets.all(CustomSizes.md),
          backgroundColor: dark ? CustomColors.darkerGrey : CustomColors.grey,
          child: Column(children: [
            // -- Title, Price and Stock status
            Row(children: [
              const CustomSectionHeading(
                  title: 'Variation', showActionButton: false),
              const SizedBox(width: CustomSizes.spaceBtwItems),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const CustomProductTitleText(
                      title: 'Price : ', smallSize: true),
                  const SizedBox(width: CustomSizes.spaceBtwItems),
                  // -- Actual Price
                  Text(
                    '€12.99',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .apply(decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(width: CustomSizes.spaceBtwItems),

                  // -- Sale Price
                  Text('€10.99', style: Theme.of(context).textTheme.titleSmall!)
                ]),
                // -- Stock
                Row(children: [
                  const CustomProductTitleText(
                      title: 'Stock : ', smallSize: true),
                  const SizedBox(width: CustomSizes.spaceBtwItems),
                  Text('In Stock',
                      style: Theme.of(context).textTheme.titleMedium)
                ])
              ])
            ]),
            // - Variation Description
            const CustomProductTitleText(
              title:
                  'Product description gives detailed description of the item upto 4 lines.',
              smallSize: true,
              maxLines: 4,
            )
          ])),
      const SizedBox(height: CustomSizes.spaceBtwItems),

      // -- Attributes
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSectionHeading(title: 'Colors', showActionButton: false),
        const SizedBox(height: CustomSizes.spaceBtwItems / 2),
        Wrap(
          spacing: 8,
          children: [
            CustomChoiceChip(text: 'Green', selected: false, onSelected: (value){}),
            CustomChoiceChip(text: 'Blue', selected: true, onSelected: (value){}),
            CustomChoiceChip(text: 'Yellow', selected: false, onSelected: (value){})
          ],
        )
      ]),
      const SizedBox(height: CustomSizes.spaceBtwSections / 2)
      ,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSectionHeading(title: 'Sizes', showActionButton: false),
        const SizedBox(height: CustomSizes.spaceBtwItems / 2),
        Wrap(
          spacing: 8,
          children: [
            CustomChoiceChip(text: 'EU 38', selected: false, onSelected: (value){}),
            CustomChoiceChip(text: 'EU 39', selected: true, onSelected: (value){}),
            CustomChoiceChip(text: 'EU 40', selected: false, onSelected: (value){})
          ],
        )
      ]),
    ]);
  }
}
