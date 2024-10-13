import 'package:bagit/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/controllers/product/all_products_controller.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/features/shop/screens/all_products/all_products.dart';
import 'package:bagit/features/shop/screens/home/wigets/home_categories.dart';
import 'package:bagit/features/shop/screens/home/wigets/promo_slider.dart';
import 'package:bagit/features/shop/screens/home/wigets/home_appbar.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(ProductController());
    // Adding it here to avoid error popups at app start
    Get.put(BrandController());
    // Adding it here to avoid repetition 
    Get.put(AllProductsController());

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      // Header
      const CustomPrimaryHeaderContainer(
          child: Column(children: [
        // -- Appbar
        CustomHomeAppBar(),
        SizedBox(height: CustomSizes.spaceBtwSections),

        // -- Searchbar
        CustomSearchContainer(text: 'Search in Store'),
        SizedBox(height: CustomSizes.spaceBtwSections),

        // -- Category Section
        Padding(
            padding: EdgeInsets.only(left: CustomSizes.defaultSpace),
            child: Column(children: [
              // -- Heading
              CustomSectionHeading(
                  title: 'Popular Categories',
                  showActionButton: false,
                  textColor: CustomColors.white),
              SizedBox(height: CustomSizes.spaceBtwItems),

              // -- Categories
              CustomHomeCategories()
            ])),
        SizedBox(height: CustomSizes.spaceBtwSections)
      ])),

      // -- Promo slider
      Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(children: [
            // Promo slider
            const CustomPromoSlider(),
            const SizedBox(height: CustomSizes.spaceBtwSections),
            // -- Heading: Popular Products
            CustomSectionHeading(
                title: 'Popular Products',
                onPressed: () => Get.to(() => AllProductsScreen(
                      title: 'Popular Products',
                      futureMethod: controller.fetchAllFeaturedProducts(),
                    ))),
            const SizedBox(height: CustomSizes.spaceBtwItems),
            // -- Popular products grid
            Obx(() {
              if (controller.isLoading.value) return const CustomVerticalProductShimmer();
              if (controller.featuredProducts.isEmpty) {
                return Center(
                    child: Text('No Data Found!',
                        style: Theme.of(context).textTheme.bodyMedium));
              }
              return CustomGridLayout(
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (_, index) => CustomProductCardVertical(
                      product: controller.featuredProducts[index]));
            })
          ]))
    ])));
  }
}
