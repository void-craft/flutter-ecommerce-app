import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/appbar/tabbar.dart';
import 'package:bagit/common/widgets/brand/brand_card.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/custom_cart_counter_icon.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/screens/store/widgets/category_tab.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: CustomAppBar(
            showBackArrow: false,
            title:
                Text('Store', style: Theme.of(context).textTheme.headlineMedium),
            actions: [CustomCartCounterIcon(onPressed: () {})],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: CustomHelperFunctions.isDarkMode(context)
                        ? CustomColors.black
                        : CustomColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                        padding: const EdgeInsets.all(CustomSizes.defaultSpace),
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
                                  title: 'Featured Brands', onPressed: () {}),
                              const SizedBox(
                                  height: CustomSizes.spaceBtwItems / 1.5),
      
                              // -- Brands grid
                              CustomGridLayout(
                                  itemCount: 4,
                                  mainAxisExtent: 80,
                                  itemBuilder: (_, index) {
                                    return const CustomBrandCard(showBorder: true,);
                                  })
                            ])),
      
                    // Tabs
                    bottom: const CustomTabBar(
                      tabs: [
                        Tab(child: Text('Sports')),
                        Tab(child: Text('Furniture')),
                        Tab(child: Text('Electronics')),
                        Tab(child: Text('Clothes')),
                        Tab(child: Text('Cosmetics')),
                      ],
                    ),
                  )
                ];
              },
              body: const TabBarView(
                children: [
                  CustomCategotyTab(),
                  CustomCategotyTab(),
                  CustomCategotyTab(),
                  CustomCategotyTab(),
                  CustomCategotyTab(),
                ])
              )),
    );
  }
}
