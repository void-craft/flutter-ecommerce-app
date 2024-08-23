import 'package:bagit/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/screens/home/wigets/home_categories.dart';
import 'package:bagit/features/shop/screens/home/wigets/promo_slider.dart';
import 'package:bagit/features/shop/screens/home/wigets/theme_home_appbar.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      // Header
      const CustomPrimaryHeaderContainer(
          child: Column(children: [
        // -- Appbar
        ThemeHomeAppBar(),
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
              HomeCategories()
            ]))
      ])),

      // -- Promo slider
      Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
            const CustomPromoSlider(banners: [
              CustomImages.promoBanner1,
              CustomImages.promoBanner2,
              CustomImages.promoBanner3
            ]),
            const SizedBox(height: CustomSizes.spaceBtwSections),

            // -- Popular Products
            CustomGridLayout(itemCount: 4, itemBuilder: (_, index) => const CustomProductCardVertical()),
          ]))
    ])));
  }
}

