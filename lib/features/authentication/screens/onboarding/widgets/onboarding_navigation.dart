import 'package:bagit/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/device/device_utility.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingNavigation extends StatelessWidget {
  const OnboardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: CustomDeviceUtils.getBottomNaviagationBarHeight() + 25,
      left: CustomSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(activeDotColor: dark ? CustomColors.light : CustomColors.dark, dotHeight: 6),
        ),
    );
  }
}