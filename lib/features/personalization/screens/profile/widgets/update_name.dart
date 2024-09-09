import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/personalization/controllers/update_name_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: true,
            title: Text('Update Name',
                style: Theme.of(context).textTheme.headlineSmall)),
        body: Padding(
            padding: const EdgeInsets.all(CustomSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // --- Headings
              Text('For easier verification, use your real name.',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Text field and button
              Form(
                  key: controller.updateUserNameFormKey,
                  child: Column(children: [
                    TextFormField(
                        controller: controller.firstName,
                        validator: (value) => CustomValidator.validateEmptyText(
                            'First Name', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: CustomTexts.firstName,
                            prefixIcon: Icon(Iconsax.user))),
                    const SizedBox(height: CustomSizes.spaceBtwInputFields),
                    TextFormField(
                        controller: controller.firstSurname,
                        validator: (value) => CustomValidator.validateEmptyText(
                            'First Surname', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: CustomTexts.firstSurname,
                            prefixIcon: Icon(Iconsax.user))),
                    const SizedBox(height: CustomSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastSurname,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return CustomValidator.validateEmptyText(
                              'Last Surname', value);
                        }
                        return null;
                      },
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: CustomTexts.lastSurname,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    )
                  ])),
              const SizedBox(height: CustomSizes.spaceBtwSections),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.updateUserName(),
                      child: const Text('Save')))
            ])));
  }
}
