import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/controllers/relation/brandcategory_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBrandCategoryForm extends StatelessWidget {
  const CustomBrandCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final brandCatController = Get.put(BrandCategoryController());
    final categoryController = CategoryController.instance;

    return Form(
      key: brandCatController.uploadFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scrollable Brand List
          Container(
            height: 200,
            padding: const EdgeInsets.all(CustomSizes.sm),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(CustomSizes.md),
            ),
            child: Obx(() {
              if (brandCatController.filteredBrands.isEmpty) {
                return Center(
                  child: Text(
                    'No Brands Available!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
              return ListView.builder(
                itemCount: brandCatController.filteredBrands.length,
                itemBuilder: (_, index) {
                  final brand = brandCatController.filteredBrands[index];
                  return Obx(() => ListTile(
                        title: Text(brand.id, style: Theme.of(context).textTheme.bodyMedium),
                        onTap: () => brandCatController.selectBrand(brand.id),
                        selected: brandCatController.selectedBrandId.value == brand.id,
                        selectedTileColor: CustomColors.primary,
                      ));
                },
              );
            }),
          ),

          SizedBox(height: CustomSizes.defaultSpace),

          // Category Checklist (only shown when a brand is selected)
          Obx(() {
            if (brandCatController.selectedBrandId.isEmpty) {
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
                      value: brandCatController.selectedCategoryIds.contains(category.id),
                      onChanged: (isSelected) {
                        brandCatController.toggleCategorySelection(category.id);
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
