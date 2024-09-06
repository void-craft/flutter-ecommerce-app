import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/appbar/tabbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/custom_cart_counter_icon.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/screens/brand/all_brands.dart';
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
                                      onPressed: () => Get.to(
                                          () => const AllBrandsScreen())),
                                  const SizedBox(
                                      height: CustomSizes.spaceBtwItems / 1.5),

                                  // -- Brands grid
                                  CustomGridLayout(
                                      itemCount: 4,
                                      mainAxisExtent: 80,
                                      itemBuilder: (_, index) {
                                        return const CustomBrandCard(
                                            showBorder: true);
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
                            (category) => CustomCategotyTab(category: category))
                        .toList()))));
  }
}
