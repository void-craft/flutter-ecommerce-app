import 'package:bagit/common/spacing_styles.dart';
import 'package:bagit/common/widgets/login_signup/form_divider.dart';
import 'package:bagit/common/widgets/login_signup/social_buttons.dart';
import 'package:bagit/features/authentication/screens/login/widgets/login_form.dart';
import 'package:bagit/features/authentication/screens/login/widgets/login_header.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomSpacingStyle.paddingWithAppbarHeight,
          child: Column(
            children: [
              // Logo, Title, Subtitle
              const CustomLoginHeader(),
              // Form
              const CustomLoginForm(),
              /// Divider
              CustomFormDivider(dividerText: CustomTexts.orSignInWith.capitalize!),
              const SizedBox(height: CustomSizes.spaceBtwSections),
              /// Footer
              const CustomSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

