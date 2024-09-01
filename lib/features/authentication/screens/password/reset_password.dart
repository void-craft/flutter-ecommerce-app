import 'package:bagit/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:bagit/features/authentication/screens/login/login.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(CupertinoIcons.clear))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  // Image
                  Image(
                    image: const AssetImage(
                        CustomImages.deliveredEmailIllustration),
                    width: CustomHelperFunctions.screenWidth() * 0.6,
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  /// Email, Title & Subtitle
                  Text(email,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(CustomTexts.changeYourPasswordTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(CustomTexts.changePasswordSubtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // Buttons
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.offAll(() => const LoginScreen()),
                          child: const Text(CustomTexts.done))),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () => ForgetPasswordController.instance
                              .resendPasswordResetEmail(email),
                          child: const Text(CustomTexts.resendEmail)))
                ]))));
  }
}
