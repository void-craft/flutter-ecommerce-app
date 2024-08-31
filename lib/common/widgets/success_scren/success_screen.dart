import 'package:bagit/common/spacing_styles.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed});

  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: CustomSpacingStyle.paddingWithAppbarHeight * 2,
                child: Column(children: [
                  // Image
                  Image(
                    image: AssetImage(image),
                    width: CustomHelperFunctions.screenWidth() * 0.6,
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  /// Title & Subtitle
                  Text(title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: onPressed,
                          child: const Text(CustomTexts.customContinue))),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                ]))));
  }
}
