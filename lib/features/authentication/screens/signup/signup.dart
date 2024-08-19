import 'package:bagit/common/widgets/login_signup/form_divider.dart';
import 'package:bagit/common/widgets/login_signup/social_buttons.dart';
import 'package:bagit/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              /// Title
              Text(CustomTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              /// Forms
              const CustomSignupForm(),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              /// Divider
              CustomFormDivider(dividerText: CustomTexts.orSignInWith.capitalize!),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              /// Social buttons
              const CustomSocialButtons()
            ],
          ),
        ),
      )
    );
  }
}
