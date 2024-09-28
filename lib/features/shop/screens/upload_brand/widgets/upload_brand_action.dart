import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUploadBrandActions extends StatelessWidget {
  const CustomUploadBrandActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// Cancel Button as a Text Link
        TextButton(
          onPressed: () {
            controller.cancelUpload();
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: CustomSizes.spaceBtwItems),

        ElevatedButton(
          onPressed: () {
            if (controller.validateForm()) {
              controller.uploadBrand(); 
            } else {
              CustomLoaders.errorSnackbar(title: 'Error.', message: 'Please fill in all required fields!');
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: CustomSizes.buttonRadius),
            minimumSize: const Size(double.infinity), // Ensure it takes full width
          ),
          child: const Text('Upload'),
        ),
      ],
    );
  }
}


// import 'package:bagit/common/widgets/loaders/loaders.dart';
// import 'package:bagit/features/shop/controllers/brand_controller.dart';
// import 'package:bagit/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:get/get.dart';

// class CustomUploadBrandActions extends StatelessWidget {
//   const CustomUploadBrandActions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = BrandController.instance;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         /// Cancel Button
//         Flexible(
//           child: ElevatedButton.icon(
//             icon: const Icon(Iconsax.close_circle),
//             label: const Text('Cancel'),
//             onPressed: () {
//               controller.cancelUpload();
//               Get.back();
//             },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: CustomSizes.buttonRadius),
//             ),
//           ),
//         ),
//         const SizedBox(width: CustomSizes.spaceBtwItems),

//         /// Upload Button
//         Expanded(
//           child: ElevatedButton.icon(
//             icon: const Icon(Icons.upload),
//             label: const Text('Upload'),
//             onPressed: () {
//               if (controller.validateForm()) {
//                 controller.uploadBrand(); 
//               } else {
//                 CustomLoaders.errorSnackbar(title: 'Error.', message: 'Please fill in all required fields!');
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: CustomSizes.buttonRadius),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }