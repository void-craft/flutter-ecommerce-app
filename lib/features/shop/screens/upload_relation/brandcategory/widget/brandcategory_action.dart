// import 'package:bagit/features/shop/controllers/brand_controller.dart';
// import 'package:bagit/features/shop/controllers/category_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomBrandCategoryAction extends StatelessWidget {
//   const CustomBrandCategoryAction({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CategoryController categoryController = CategoryController.instance;
//     final BrandController brandController = BrandController.instance;

//     return ElevatedButton(
//       onPressed: () {
//         if (brandController.selectedBrandId.value != null &&
//             categoryController.selectedCategoryId.value != null) {
//           // Call the method to upload the relation
//           print('Uploading relation between Brand: ${brandController.selectedBrandId.value} and Category: ${categoryController.selectedCategoryId.value}');
//           // Example: await brandController.uploadBrandCategoryRelation(
//           //     brandController.selectedBrandId.value!,
//           //     categoryController.selectedCategoryId.value!);
//         } else {
//           Get.snackbar('Error', 'Please select both a brand and a category');
//         }
//       },
//       child: const Text('Upload Relation'),
//     );
//   }
// }
