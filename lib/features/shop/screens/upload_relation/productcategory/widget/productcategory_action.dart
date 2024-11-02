import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/features/shop/controllers/relation/productcategory_controller.dart';

class CustomProductCategoryAction extends StatelessWidget {
  const CustomProductCategoryAction({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final prodCatController = ProductCategoryController.instance;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final selectedProductId = productController.selectedProductId.value;
          final selectedCategoryIds = prodCatController.selectedCategoryIds;

          if (selectedProductId.isNotEmpty && selectedCategoryIds.isNotEmpty) {
            try {
              await prodCatController.uploadProductCategoryRelation();

              CustomLoaders.successSnackbar(
                  title: 'Success',
                  message:
                      'Product and categories relation uploaded successfully');
            } catch (e) {
              CustomLoaders.errorSnackbar(
                  title: 'Error', message: 'Failed to upload relation: $e');
            }
          } else {
            CustomLoaders.errorSnackbar(
                title: 'Error',
                message:
                    'Please select both a product and at least one category');
          }
        },
        child: const Text('Save Relation'),
      ),
    );
  }
}
