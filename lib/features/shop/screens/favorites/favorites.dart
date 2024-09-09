import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/screens/home/home.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: false,
            title: Text('Favorites',
            style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              CustomCircularIcon(
                  icon: Iconsax.add,
                  onPressed: () => Get.to(const HomeScreen()))
            ]),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  CustomGridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) =>
                          CustomProductCardVertical(product: ProductModel.empty()))
                ]))));
  }
}
