import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(children: const [
        OnboardingPage(
            image: CustomImages.onboardingImage1,
            title: CustomTexts.onBoardingTitlel,
            subtitle: CustomTexts.onBoardingSubtitlel),
        OnboardingPage(
            image: CustomImages.onboardingImage2,
            title: CustomTexts.onBoardingTitle2,
            subtitle: CustomTexts.onBoardingSubtitle2),
        OnboardingPage(
            image: CustomImages.onboardingImage3,
            title: CustomTexts.onBoardingTitle3,
            subtitle: CustomTexts.onBoardingSubtitle3)
      ]),
    ]));
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CustomSizes.defaultSpace),
      child: Column(children: [
        Image(
          width: CustomHelperFunctions.screenWidth() * 0.8,
          height: CustomHelperFunctions.screenHeight() * 0.6,
          image: AssetImage(image),
        ),
        Text(title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        Text(subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center)
      ]),
    );
  }
}
