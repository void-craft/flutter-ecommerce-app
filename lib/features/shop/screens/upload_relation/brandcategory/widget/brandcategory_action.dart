import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/controllers/relation/brandcategory_controller.dart';
import 'package:flutter/material.dart';

class CustomBrandCategoryAction extends StatelessWidget {
  const CustomBrandCategoryAction({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    final brandCatController = BrandCategoryController.instance;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final selectedBrandId = brandController.selectedBrandId.value;
          final selectedCategoryIds = brandCatController.selectedCategoryIds;

          if (selectedBrandId.isNotEmpty && selectedCategoryIds.isNotEmpty) {
            try {
              await brandCatController.uploadBrandCategoryRelation();

              CustomLoaders.successSnackbar(
                  title: 'Success',
                  message:
                      'Brand and categories relation uploaded successfully');
            } catch (e) {
              CustomLoaders.errorSnackbar(
                  title: 'Error', message: 'Failed to upload relation: $e');
            }
          } else {
            CustomLoaders.errorSnackbar(
                title: 'Error',
                message:
                    'Please select both a Brand and at least one Category');
          }
        },
        child: const Text('Save Relation'),
      ),
    );
  }
}
