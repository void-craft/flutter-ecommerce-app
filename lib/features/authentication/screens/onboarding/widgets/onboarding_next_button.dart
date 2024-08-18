import 'package:bagit/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/device/device_utility.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Positioned(
        right: CustomSizes.defaultSpace,
        bottom: CustomDeviceUtils.getBottomNaviagationBarHeight(),
        child: ElevatedButton(
          onPressed: () => OnboardingController.instance.nextPage(),
          style:  ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? CustomColors.primary : Colors.black),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}