import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/features/shop/models/product_model.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSortableProducts extends StatelessWidget {
  const CustomSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // -- Dropdown
      DropdownButtonFormField(
        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        onChanged: (value) {},
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
      CustomGridLayout(
          itemCount: 4,
          itemBuilder: (_, index) => CustomProductCardVertical(product: ProductModel.empty()))
    ]);
  }
}
