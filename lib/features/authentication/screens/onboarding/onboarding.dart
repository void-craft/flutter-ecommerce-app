import 'package:bagit/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:bagit/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:bagit/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:bagit/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bagit/features/authentication/controllers/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
        body: Stack(children: [
      // Scrollable page
      PageView(
        controller: controller.pageController,
        onPageChanged: controller.updatePageIndicator,      
        children: const [
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
          ]
        ),

      // Skip onboarding
      const OnboardingSkip(),
      
      // Smooth page indicator
      const OnboardingNavigation(),
      
      // Circular button
      const OnboardingNextButton()
    ]));
  }
}


