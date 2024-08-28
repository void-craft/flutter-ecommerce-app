import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text('Popular Products'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  // -- Dropdown
                  DropdownButtonFormField(
                    decoration:
                        const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                    onChanged: (value) {},
                    items: [
                      'Name',
                      'Higher Price',
                      'Lower Price',
                      'Sale',
                      'Newest',
                      'Popularity'
                    ]
                        .map((option) => DropdownMenuItem(
                            value: option, child: Text(option)))
                        .toList(),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),
                  // Products
                  CustomGridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) =>
                          const CustomProductCardVertical())
                ]))));
  }
}
