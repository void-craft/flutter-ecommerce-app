import 'package:bagit/features/authentication/screens/password/forgot_password.dart';
import 'package:bagit/features/authentication/screens/signup/signup.dart';
import 'package:bagit/navigation_menu.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding:
          const EdgeInsets.symmetric(vertical: CustomSizes.spaceBtwSections),
      child: Column(
        children: [
          /// Email
          TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: CustomTexts.email)),
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          /// Password
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: CustomTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(height: CustomSizes.spaceBtwInputFields / 2),

          //Remember Me & Forget Password
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                /// Remember me
                Checkbox(value: true, onChanged: (value) {}),
                const Text(CustomTexts.rememberMe)
              ],
            ),

            // Forgot password
            TextButton(
                onPressed: () => Get.to(() => const ForgotPassword()), child: const Text(CustomTexts.forgotPassword))
          ]),
          const SizedBox(height: CustomSizes.spaceBtwSections),

          /// Signin button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu()), child: const Text(CustomTexts.signIn))),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          /// Create account button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(CustomTexts.createAccount)),)
        ],
      ),
    ));
  }
}
