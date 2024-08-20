import 'package:bagit/features/authentication/screens/password/reset_password.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(CustomSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // - Heading
            Text(CustomTexts.forgotPassword, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: CustomSizes.spaceBtwItems),
            Text(CustomTexts.forgotPasswordSubtitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: CustomSizes.spaceBtwItems * 2),

            // Text field
            TextFormField(
              decoration: const InputDecoration(labelText: CustomTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
            ),
            const SizedBox(height: CustomSizes.spaceBtwItems),

            // -- Submit form
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.off(() => const ResetPassword()), child: const Text(CustomTexts.submit))),
          ],
        ),
      ),
    );
  }
}
