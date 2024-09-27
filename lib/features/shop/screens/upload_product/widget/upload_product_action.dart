import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class CustomUploadProductActions extends StatelessWidget {
  const CustomUploadProductActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Cancel Button
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Iconsax.close_circle),
            label: const Text('Cancel'),
            onPressed: () {
              controller.cancelUpload();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: CustomSizes.buttonRadius),
            ),
          ),
        ),
        const SizedBox(width: CustomSizes.spaceBtwItems),

        /// Upload Button
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.upload),
            label: const Text('Upload'),
            onPressed: () {
              if (controller.validateForm()) {
                controller.finishUpload(); 
              } else {
                CustomLoaders.errorSnackbar(title: 'Error.', message: 'Please fill in all required fields!');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: CustomSizes.buttonRadius),
            ),
          ),
        ),
      ],
    );
  }
}
