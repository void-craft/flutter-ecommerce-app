import 'package:bagit/features/authentication/controllers/onboarding_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: CustomDeviceUtils.getAppBarHeight(),
        right: CustomSizes.defaultSpace,
        child: TextButton(
          onPressed: () => OnboardingController.instance.skipPage(),
          child: const Text('Skip'),
        ));
  }
}
