import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/features/shop/controllers/product/all_products_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomSortableProducts extends StatelessWidget {
  const CustomSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = AllProductsController.instance;
    controller.assignProducts(products);
    return Column(children: [
      // -- Dropdown
      DropdownButtonFormField(
        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        value: controller.selectedSortOption.value,
        onChanged: (value) {
          // Sort products based on the selected option
          controller.sortProducts(value!);
        },
        items: [
          'Name',
          'Higher Price',
          'Lower Price',
          'Sale',
          'Newest',
          'Popularity'
        ]
            .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
      ),
      const SizedBox(height: CustomSizes.spaceBtwSections),
      // Products
      Obx(
        () => CustomGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => CustomProductCardVertical(product: controller.products[index])),
      )
    ]);
  }
}
