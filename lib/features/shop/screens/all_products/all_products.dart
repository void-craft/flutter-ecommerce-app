import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/products/sortable/sortable_products.dart';
import 'package:bagit/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:bagit/features/shop/controllers/product/all_products_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(title),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: FutureBuilder(
                    future:
                        futureMethod ?? controller.fetchProductsByQuery(query),
                    builder: (context, snapshot) {
                      /// Check the state of the FutureBuilder snapshot
                      const loader = CustomVerticalProductShimmer();
                      final widget = CustomCloudHelperFunctions.checkMultipleRecordState(snapshot: snapshot, loader: loader);

                      // Return appropriate widget based on snapshot state
                      if (widget != null) return widget;

                      // Products found!
                      final products = snapshot.data!;

                      return CustomSortableProducts(products: products);
                    }))));
  }
}
