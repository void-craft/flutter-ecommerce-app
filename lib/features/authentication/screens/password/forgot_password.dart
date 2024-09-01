import 'package:bagit/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(CustomSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // - Heading
              Text(CustomTexts.forgotPassword,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: CustomSizes.spaceBtwItems),
              Text(CustomTexts.forgotPasswordSubtitle,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: CustomSizes.spaceBtwItems * 2),

              // Text field
              Form(
                  key: controller.forgetPasswordFormKey,
                  child: TextFormField(
                      controller: controller.email,
                      validator: CustomValidator.validateEmail,
                      decoration: const InputDecoration(
                          labelText: CustomTexts.email,
                          prefixIcon: Icon(Iconsax.direct_right)))),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // -- Submit form
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.sendPasswordResetEmail(),
                      child: const Text(CustomTexts.submit)))
            ])));
  }
}
