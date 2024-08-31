import 'package:bagit/features/authentication/controllers/login/login_controller.dart';
import 'package:bagit/features/authentication/screens/password/forgot_password.dart';
import 'package:bagit/features/authentication/screens/signup/signup.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
        key: controller.loginFormKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CustomSizes.spaceBtwSections),
            child: Column(children: [
              /// Email
              TextFormField(
                  controller: controller.email,
                  validator: (value) => CustomValidator.validateEmail(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: CustomTexts.email)),
              const SizedBox(height: CustomSizes.spaceBtwInputFields),

              /// Password
              Obx(() => TextFormField(
                  validator: (value) => CustomValidator.validatePassword(value),
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      labelText: CustomTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye))))),
              const SizedBox(height: CustomSizes.spaceBtwInputFields / 2),

              //Remember Me & Forget Password
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  /// Remember me
                  Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.value =
                          !controller.rememberMe.value)),
                  const Text(CustomTexts.rememberMe)
                ]),

                // Forgot password
                TextButton(
                    onPressed: () => Get.to(() => const ForgotPassword()),
                    child: const Text(CustomTexts.forgotPassword))
              ]),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              /// Signin button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.emailAndPasswordSignIn(),
                      child: const Text(CustomTexts.signIn))),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              /// Create account button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(CustomTexts.createAccount)),
              )
            ])));
  }
}
