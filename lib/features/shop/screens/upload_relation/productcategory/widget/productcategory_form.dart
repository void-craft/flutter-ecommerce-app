import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCategoryForm extends StatelessWidget {
  const CustomProductCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    final productController = ProductController.instance;

    return Column(
      children: [
        /// Select Product Dropdown
        Obx(() {
          return DropdownButton<String>(
            hint: const Text('Select Product'),
            value: productController.selectedProductId.value,
            onChanged: (value) {
              productController.selectedProductId.value = value;
            },
            items: productController.products.map((product) {
              return DropdownMenuItem<String>(
                value: product.id,
                child: Text(product.title),
              );
            }).toList(), // Explicitly convert to List here
          );
        }),
        const SizedBox(height: 16),

        /// Select Categories Dropdown (Allow multiple selections)
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Categories:'),
              ...categoryController.categories.map((category) {
                return Obx(() {
                  // Determine if this category is selected
                  bool isSelected = categoryController.selectedCategories
                      .any((selectedCategory) => selectedCategory.id == category.id);

                  return CheckboxListTile(
                    title: Text(category.name),
                    value: isSelected,
                    onChanged: (bool? selected) {
                      if (selected == true) {
                        categoryController.selectedCategories.addIf(
                          !categoryController.selectedCategories
                              .contains(category),
                          category,
                        );
                      } else {
                        categoryController.selectedCategories
                            .removeWhere((cat) => cat.id == category.id);
                      }
                    },
                  );
                });
              }), // Explicitly convert to List here as well
            ],
          );
        }),
      ],
    );
  }
}
