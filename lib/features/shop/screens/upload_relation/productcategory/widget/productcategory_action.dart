import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCategoryAction extends StatelessWidget {
  const CustomProductCategoryAction({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = CategoryController.instance;
    final ProductController productController = ProductController.instance;

    return ElevatedButton(
      onPressed: () {
        if (productController.selectedProductId.value != null &&
            categoryController.selectedCategoryId.value != null) {
          // Call the method to upload the relation
          print('Uploading relation between Product: ${productController.selectedProductId.value} and Category: ${categoryController.selectedCategoryId.value}');
          // Example: await productController.uploadProductCategoryRelation(
          //     productController.selectedProductId.value!,
          //     categoryController.selectedCategoryId.value!);
        } else {
          Get.snackbar('Error', 'Please select both a product and a category');
        }
      },
      child: const Text('Upload Relation'),
    );
  }
}
