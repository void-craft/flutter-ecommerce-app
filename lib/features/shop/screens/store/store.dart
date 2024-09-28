import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/appbar/tabbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/custom_cart_counter_icon.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/screens/brand/all_brands.dart';
import 'package:bagit/features/shop/screens/brand/brand_products.dart';
import 'package:bagit/features/shop/screens/brand/widget/brand_shimmer.dart';
import 'package:bagit/features/shop/screens/store/widgets/category_tab.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Original first implementation
    final brandController = BrandController.instance;
    final categories = CategoryController.instance.featuredCategories;

    return DefaultTabController(
        length: categories.length,
        child: Scaffold(
            appBar: CustomAppBar(
              showBackArrow: false,
              title: Text('Store',
                  style: Theme.of(context).textTheme.headlineMedium),
              actions: const [CustomCartCounterIcon()],
            ),
            body: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: true,
                        backgroundColor:
                            CustomHelperFunctions.isDarkMode(context)
                                ? CustomColors.black
                                : CustomColors.white,
                        expandedHeight: 440,
                        flexibleSpace: Padding(
                            padding:
                                const EdgeInsets.all(CustomSizes.defaultSpace),
                            child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  const SizedBox(
                                      height: CustomSizes.spaceBtwInputFields),
                                  const CustomSearchContainer(
                                      text: 'Search in Store',
                                      showBorder: true,
                                      showBackground: false,
                                      padding: EdgeInsets.zero),
                                  const SizedBox(
                                      height: CustomSizes.spaceBtwSections),

                                  // -- Featured Brands
                                  CustomSectionHeading(
                                      title: 'Featured Brands',
                                      onPressed: () =>
                                          Get.to(() => const AllBrandsScreen())),
                                  const SizedBox(
                                      height: CustomSizes.spaceBtwItems / 1.5),

                                  // -- Brands grid
                                  Obx(() {
                                    if (brandController.isLoading.value) return const CustomBrandShimmer();
                                    if (brandController
                                        .featuredBrands.isEmpty) {
                                      return Center(
                                          child: Text('No Data Found!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .apply(color: Colors.white)));
                                    }
                                    return CustomGridLayout(
                                        itemCount: brandController
                                            .featuredBrands.length,
                                        mainAxisExtent: 80,
                                        itemBuilder: (_, index) {
                                          final brand = brandController
                                              .featuredBrands[index];
                                          return CustomBrandCard(
                                              showBorder: true,
                                              brand: brand,
                                              onTap: () => Get.to(() =>
                                                  BrandProductsScreen(
                                                      brand: brand)));
                                        });
                                  })
                                ])),

                        // Tabs
                        bottom: CustomTabBar(
                            tabs: categories
                                .map((category) =>
                                    Tab(child: Text(category.name)))
                                .toList()))
                  ];
                },
                body: TabBarView(
                    children: categories
                        .map(
                            (category) => CustomCategoryTab(category: category))
                        .toList()))));
  }
}
