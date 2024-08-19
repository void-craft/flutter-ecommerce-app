import 'package:bagit/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSignupForm extends StatelessWidget {
  const CustomSignupForm({
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return Form(child: Column(
      children: [
        /// First & Last name
        Row(
          children: [
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(labelText: CustomTexts.firstName, prefixIcon: Icon(Iconsax.user)),                          
              ),
            ),
            const SizedBox(width: CustomSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(labelText: CustomTexts.lastName, prefixIcon: Icon(Iconsax.user)),                          
              ),
            ),
          ],
        ),
        const SizedBox(height: CustomSizes.spaceBtwInputFields),
    
        /// Username
        TextFormField(
          expands: false,
          decoration: const InputDecoration(labelText: CustomTexts.userName, prefixIcon: Icon(Iconsax.user_edit)),                          
        ),
    
        /// Email
        TextFormField(
          decoration: const InputDecoration(labelText: CustomTexts.email, prefixIcon: Icon(Iconsax.direct)),                          
        ),
        const SizedBox(height: CustomSizes.spaceBtwInputFields),
    
        /// Phone Number
        TextFormField(
          decoration: const InputDecoration(labelText: CustomTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),                          
        ),
        const SizedBox(height: CustomSizes.spaceBtwInputFields),
    
        /// Password
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: CustomTexts.password,
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: Icon(Iconsax.eye_slash),
          ),
        ),
        const SizedBox(height: CustomSizes.spaceBtwInputFields),
    
        /// Terms & Conditions Checkbox
        const CustomTermsAndConditions(),
        const SizedBox(height: CustomSizes.spaceBtwSections),
        /// Signup Button
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text(CustomTexts.createAccount)),)
    
      ],
    ));
  }
}
