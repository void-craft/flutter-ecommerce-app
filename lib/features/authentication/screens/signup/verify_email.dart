import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                icon: const Icon(CupertinoIcons.clear))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  /// Image
                  Image(
                    image: const AssetImage(
                        CustomImages.deliveredEmailIllustration),
                    width: CustomHelperFunctions.screenWidth() * 0.6,
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  /// Title & Subtitle
                  Text(CustomTexts.confirmEmail,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(email ?? '',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(CustomTexts.confirmEmailSubtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  /// Buttons
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              controller.checkEmailVerificationStatus(),
                          child: const Text(CustomTexts.customContinue))),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () => controller.sendEmailVerification(),
                          child: const Text(CustomTexts.resendEmail))),
                ]))));
  }
}
