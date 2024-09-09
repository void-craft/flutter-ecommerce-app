import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/products/sortable/sortable_products.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(title: Text('VShoes')),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  // Brand Detail
                  CustomBrandCard(showBorder: true),
                  SizedBox(height: CustomSizes.spaceBtwSections),
                  CustomSortableProducts(products: [])
                ]))));
  }
}
