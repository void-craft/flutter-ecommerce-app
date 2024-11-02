import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/controllers/relation/productcategory_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCategoryForm extends StatelessWidget {
  const CustomProductCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final prodCatController = Get.put(ProductCategoryController());
    final categoryController = CategoryController.instance;

    return Form(
      key: prodCatController.uploadFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scrollable Product List
          Container(
            height: 200,
            padding: const EdgeInsets.all(CustomSizes.sm),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(CustomSizes.md),
            ),
            child: Obx(() {
              if (prodCatController.filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    'No Products Available!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
              return ListView.builder(
                itemCount: prodCatController.filteredProducts.length,
                itemBuilder: (_, index) {
                  final product = prodCatController.filteredProducts[index];
                  return Obx(() => ListTile(
                        title: Text(product.id, style: Theme.of(context).textTheme.bodyMedium),
                        onTap: () => prodCatController.selectProduct(product.id),
                        selected: prodCatController.selectedProductId.value == product.id,
                        selectedTileColor: CustomColors.primary,
                      ));
                },
              );
            }),
          ),

          SizedBox(height: CustomSizes.defaultSpace),

          // Category Checklist (only shown when a product is selected)
          Obx(() {
            if (prodCatController.selectedProductId.isEmpty) {
              return Container();
            }
            return Container(
              padding: const EdgeInsets.all(CustomSizes.sm),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(CustomSizes.md),
              ),
              child: Column(
                children: [
                  for (var category in categoryController.featuredCategories)
                    CheckboxListTile(
                      title: Text(
                        category.id,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: prodCatController.selectedCategoryIds.contains(category.id),
                      onChanged: (isSelected) {
                        prodCatController.toggleCategorySelection(category.id);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                ],
              ),
            );
          }),
          SizedBox(height: CustomSizes.defaultSpace),
        ],
      ),
    );
  }
}
