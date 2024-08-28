import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/products/sortable/sortable_products.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(
          title: Text('Popular Products'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(CustomSizes.defaultSpace),
                child: CustomSortableProducts())));
  }
}
