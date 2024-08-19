import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomTermsAndConditions extends StatelessWidget {
  const CustomTermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24, height: 24, child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(width: CustomSizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: CustomTexts.iAgreeTo, style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: CustomTexts.privacyPolicy, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? CustomColors.white : CustomColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? CustomColors.white : CustomColors.primary,
              )),
              TextSpan(text: CustomTexts.and, style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: CustomTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? CustomColors.white : CustomColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? CustomColors.white : CustomColors.primary,
              )),
              ]),
              ),
        )
      ],
    );
  }
}
