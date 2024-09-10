import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/products/sortable/sortable_products.dart';
import 'package:bagit/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
        appBar: CustomAppBar(title: Text(brand.name)),
        body: SingleChildScrollView(  
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(
                  children: [
                  // Brand Detail
                  CustomBrandCard(showBorder: true, brand: brand),
                  const SizedBox(height: CustomSizes.spaceBtwSections),
                  FutureBuilder(
                      future: controller.getBrandProducts(brand.id),
                      builder: (context, snapshot) {
                        // Handle loader, no record or error message
                        const loader = CustomVerticalProductShimmer();
                        final widget = CustomCloudHelperFunctions.checkMultipleRecordState(snapshot: snapshot, loader: loader);
                        if (widget != null) return widget;

                        // Record found
                        final brandProducts = snapshot.data!;
                        return CustomSortableProducts(products: brandProducts);
                      })
                ]))));
  }
}
