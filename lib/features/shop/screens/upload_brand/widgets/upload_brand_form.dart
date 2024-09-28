import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class CustomUploadBrandForm extends StatelessWidget {
  const CustomUploadBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Form(
      key: controller.uploadFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Brand ID Field (Required)
          _buildTextField(
            label: 'Brand ID',
            icon: Iconsax.tag,
            validator: (value) =>
                CustomValidator.validateEmptyText('Brand ID', value),
            onChanged: (value) => controller.id.value = value,
          ),

          /// Brand Name Field (Required)
          _buildTextField(
            label: 'Brand Name',
            icon: Iconsax.tag,
            validator: (value) =>
                CustomValidator.validateEmptyText('Brand Name', value),
            onChanged: (value) => controller.name.value = value,
          ),

          /// Brand Image Upload (Required)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Iconsax.image),
              Text('Brand Image', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: CustomSizes.spaceBtwItems * 4),
              IconButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    controller.image.value = pickedFile.path;
                  }
                },
                icon: const Icon(Icons.upload), // Upload icon
                tooltip: 'Upload Brand Image',
              ),
            ],
          ),
          Obx(() {
            if (controller.image.value.isNotEmpty) {
              return Padding(
                padding:
                    const EdgeInsets.only(top: CustomSizes.spaceBtwItems / 2),
                child:
                    Text('Image Selected! ${controller.brandImagePath.value}'),
              );
            }
            return const SizedBox.shrink();
          }),

          /// Products Count (Non-editable)
          // Text('Products Count: ${controller.productsCount.value}',
              // style: Theme.of(context).textTheme.bodyMedium),

          // Optional Fields Header
          const SizedBox(height: CustomSizes.spaceBtwInputFields),
          Text('Optional Fields',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          // Add optional fields here if necessary
          /// Is Featured Selection (Yes/No Radio Buttons)
          Text('Is Featured', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: CustomSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() => Radio<bool>(
                    value: true,
                    groupValue: controller.isFeatured.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.isFeatured.value = value;
                      }
                    },
                  )),
              const Text('Yes'),
              Obx(() => Radio<bool>(
                    value: false,
                    groupValue: controller.isFeatured.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.isFeatured.value = value;
                      }
                    },
                  )),
              const Text('No'),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method to build text fields with validation
  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CustomSizes.spaceBtwInputFields),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
