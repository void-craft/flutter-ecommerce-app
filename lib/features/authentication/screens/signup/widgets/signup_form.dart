import 'package:bagit/features/authentication/controllers/signup/signup_controller.dart';
import 'package:bagit/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomSignupForm extends StatelessWidget {
  const CustomSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(children: [
          /// First & Last name
          Row(children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value) =>
                    CustomValidator.validateEmptyText('firstName', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: CustomTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(width: CustomSizes.spaceBtwInputFields),
            Expanded(
                child: TextFormField(
              controller: controller.lastName,
              validator: (value) =>
                  CustomValidator.validateEmptyText('lastName', value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: CustomTexts.lastName,
                  prefixIcon: Icon(Iconsax.user)),
            ))
          ]),
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                CustomValidator.validateEmptyText('userName', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: CustomTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => CustomValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: CustomTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => CustomValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: CustomTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
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
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          /// Terms & Conditions Checkbox
          const CustomTermsAndConditions(),
          const SizedBox(height: CustomSizes.spaceBtwSections),

          /// Signup Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(CustomTexts.createAccount)))
        ]));
  }
}
