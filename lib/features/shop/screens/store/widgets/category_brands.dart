import 'package:bagit/common/widgets/brand/brand_showcase.dart';
import 'package:bagit/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:bagit/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          // Handle loader, no record, or error message
          const loader = Column(
            children: [
              CustomListTileShimmer(),
              SizedBox(height: CustomSizes.spaceBtwItems),
              CustomBoxesShimmer(),
              SizedBox(height: CustomSizes.spaceBtwItems)
            ],
          );
          final widget = CustomCloudHelperFunctions.checkMultipleRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;
          // Record found!
          final brands = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];
                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandId: brand.id, limit: 3),
                    builder: (context, snapshot) {
                      // Handle loader, no record, or error message
                      final widget =
                          CustomCloudHelperFunctions.checkMultipleRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      // Record Found!
                      final products = snapshot.data!;

                      return CustomBrandShowcase(
                          brand: brand,
                          images: products.map((e) => e.thumbnail).toList());
                    });
              });
        });
  }
}
