import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomBillingPaymentSection extends StatelessWidget {
  const CustomBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        CustomSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: (){}),
        const SizedBox(height: CustomSizes.spaceBtwItems / 2),
        Row(
          children: [
            CustomRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? CustomColors.light : CustomColors.light,
              padding: const EdgeInsets.all(CustomSizes.sm),
              child: const Image(image: AssetImage(CustomImages.paypal), fit: BoxFit.contain)
            ),
            const SizedBox(width: CustomSizes.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge)
          ],
        )
      ],
    );
  }
}