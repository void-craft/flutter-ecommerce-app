// import 'package:bagit/common/widgets/appbar/appbar.dart';
// import 'package:bagit/common/widgets/list_tile/settings_menu_tile.dart';
// import 'package:bagit/features/personalization/screens/profile/widgets/upload_data.dart';
// import 'package:bagit/features/shop/controllers/product/product_controller.dart';
// import 'package:bagit/utils/constants/colors.dart';
// import 'package:bagit/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class UploadProductScreen extends StatelessWidget {
//   const UploadProductScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = ProductController.instance;

//     return Scaffold(
//       appBar: CustomAppBar(
//         showBackArrow: false,
//         leadingIcon: Iconsax.arrow,
//         leadingOnPressed: () async {
//           Get.back();
//         },
//         title: Text('Upload Product',
//             style: Theme.of(context).textTheme.headlineSmall),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(CustomSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Form(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Id',
//                         prefixIcon: Icon(Iconsax.tag),
//                       ),
//                       onChanged: (value) {
//                         controller.id.value = value;
//                       },
//                     ),
//                     const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Title',
//                         prefixIcon: Icon(Iconsax.book),
//                       ),
//                       onChanged: (value) {
//                         controller.title.value = value;
//                       },
//                     ),
//                     const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Stock',
//                         prefixIcon: Icon(Iconsax.box),
//                       ),
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) {
//                         controller.stock.value = int.tryParse(value) ?? 0;
//                       },
//                     ),
//                     const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Price',
//                         prefixIcon: Icon(Iconsax.coin),
//                       ),
//                       keyboardType:
//                           const TextInputType.numberWithOptions(decimal: true),
//                       onChanged: (value) {
//                         controller.price.value = double.tryParse(value) ?? 0.0;
//                       },
//                     ),
//                     const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Product Type',
//                         prefixIcon: Icon(Iconsax.category),
//                       ),
//                       onChanged: (value) {
//                         controller.productType.value = value;
//                       },
//                     ),
//                     const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                     // Thumbnail Upload
//                     CustomSettingsMenuTile(
//                       icon: Iconsax.image,
//                       title: 'Thumbnail',
//                       trailing: IconButton(
//                         icon: const Icon(Icons.upload),
//                         onPressed: () async {
//                           await controller.pickThumbnail();
//                           // Handle thumbnail selection
//                         },
//                       ),
//                       subtitle: 'Upload Product Thumbnail',
//                     ),
//                     const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                     GestureDetector(
//                       onTap: () {
//                         controller.isExpanded.toggle();
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Show Optional Fields'),
//                           Icon(controller.isExpanded.value
//                               ? Icons.expand_less
//                               : Icons.expand_more),
//                         ],
//                       ),
//                     ),
//                     if (controller.isExpanded.value) ...[
//                       const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Description (Optional)',
//                           prefixIcon: Icon(Iconsax.note),
//                         ),
//                         onChanged: (value) =>
//                             controller.description.value = value,
//                       ),
//                       const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'SKU (Optional)',
//                           prefixIcon: Icon(Iconsax.code),
//                         ),
//                         onChanged: (value) => controller.sku.value = value,
//                       ),
//                       const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Brand (Optional)',
//                           prefixIcon: Icon(Iconsax.bank),
//                         ),
//                         onChanged: (value) {
//                           controller.brand.value = value;
//                         },
//                       ),
//                       const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Category ID (Optional)',
//                           prefixIcon: Icon(Iconsax.tag),
//                         ),
//                         onChanged: (value) =>
//                             controller.categoryId.value = value,
//                       ),
//                       const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                       TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Sale Price (Optional)',
//                             prefixIcon: Icon(Iconsax.money),
//                           ),
//                           keyboardType: const TextInputType.numberWithOptions(
//                               decimal: true),
//                           onChanged: (value) => controller.salePrice.value =
//                               double.tryParse(value) ?? 0.0),
//                       const SizedBox(height: CustomSizes.spaceBtwInputFields),
//                       // Additional Images Upload
//                       CustomSettingsMenuTile(
//                         icon: Iconsax.image,
//                         title: 'Images',
//                         subtitle: 'Upload Product Images',
//                         trailing: IconButton(
//                           icon: const Icon(Icons.upload),
//                           onPressed: () async {
//                             await controller.pickImages();
//                             // Handle additional images selection
//                           },
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               const SizedBox(height: CustomSizes.spaceBtwItems),
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Get.off(const UploadDataScreen());
//                   },
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(color: CustomColors.primary),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: CustomSizes.spaceBtwItems),
//               Obx(() => controller.validateProductFields()
//                   ? SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           await controller.finishUpload();
//                         },
//                         child: const Text('Upload Product'),
//                       ),
//                     )
//                   : const SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: null,
//                         child: Text('Continue'),
//                       ),
//                     )),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
