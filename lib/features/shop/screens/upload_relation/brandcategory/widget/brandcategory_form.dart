// import 'package:bagit/features/shop/controllers/brand_controller.dart';
// import 'package:bagit/features/shop/controllers/category_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomBrandCategoryForm extends StatelessWidget {
//   const CustomBrandCategoryForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final categoryController = CategoryController.instance;
//     final brandController = BrandController.instance;

//     return Column(
//       children: [
//         /// Select Brand Dropdown
//         Obx(() {
//           return DropdownButton<String>(
//             hint: const Text('Select Brand'),
//             value: brandController.selectedBrandId.value,
//             onChanged: (value) {
//               brandController.selectedBrandId.value = value;
//             },
//             items: brandController.brands.map((brand) {
//               return DropdownMenuItem<String>(
//                 value: brand.id,
//                 child: Text(brand.title),
//               );
//             }).toList(),
//           );
//         }),
//         const SizedBox(height: 16),

//         /// Select Categories Dropdown (Allow multiple selections)
//         Obx(() {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Select Categories:'),
//               ...categoryController.categories.map((category) {
//                 return Obx(() {
//                   // Determine if this category is selected
//                   bool isSelected = categoryController.selectedCategories
//                       .any((selectedCategory) => selectedCategory.id == category.id);

//                   return CheckboxListTile(
//                     title: Text(category.name),
//                     value: isSelected,
//                     onChanged: (bool? selected) {
//                       if (selected == true) {
//                         categoryController.selectedCategories.addIf(
//                           !categoryController.selectedCategories.contains(category),
//                           category,
//                         );
//                       } else {
//                         categoryController.selectedCategories
//                             .removeWhere((cat) => cat.id == category.id);
//                       }
//                     },
//                   );
//                 });
//               }),
//             ],
//           );
//         }),
//       ],
//     );
//   }
// }
