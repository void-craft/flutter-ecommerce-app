import 'package:bagit/features/personalization/controllers/user_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReauthenticateLoginForm extends StatelessWidget {
  const ReauthenticateLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
        appBar: AppBar(title: const Text('Reauthenticate User')),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Form(
                    key: controller.reAuthFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email
                          TextFormField(
                              controller: controller.verifyEmail,
                              validator: CustomValidator.validateEmail,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.direct_right),
                                  labelText: CustomTexts.email)),
                          const SizedBox(
                              height: CustomSizes.spaceBtwInputFields),

                          // Password
                          Obx(() => TextFormField(
                              obscureText: controller.hidePassword.value,
                              controller: controller.verifyPassword,
                              validator: (value) =>
                                  CustomValidator.validateEmptyText(
                                      'Password', value),
                              decoration: InputDecoration(
                                  labelText: CustomTexts.password,
                                  prefixIcon:
                                      const Icon(Iconsax.password_check),
                                  suffixIcon: IconButton(
                                      onPressed: () =>
                                          controller.hidePassword.value =
                                              !controller.hidePassword.value,
                                      icon: const Icon(Iconsax.eye_slash)))))
                        ])))));
  }
}
