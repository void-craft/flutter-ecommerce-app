import 'package:bagit/common/widgets/appbar/custom_appbar.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/products/custom_cart_counter_icon.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                              // -- Features Brands
                              CustomSectionHeading(
                                  title: 'Featured Brands', onPressed: () {}),
                              const SizedBox(
                                  height: CustomSizes.spaceBtwItems / 1.5),

                              CustomGridLayout(
                                  itemCount: 4,
                                  mainAxisExtent: 80,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                        onTap: () {},
                                        child: CustomRoundedContainer(
                                            padding: const EdgeInsets.all(
                                                CustomSizes.sm),
                                            showBorder: true,
                                            backgroundColor: Colors.transparent,
                                            child: Row(children: [
                                              // - Icon
                                              Flexible(
                                                child: CustomCircularImage(
                                                    isNetworkImage: false,
                                                    image: CustomImages.clothIcon,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    overlayColor:
                                                        CustomHelperFunctions
                                                                .isDarkMode(
                                                                    context)
                                                            ? CustomColors.white
                                                            : CustomColors.black),
                                              ),
                                              const SizedBox(
                                                  width: CustomSizes
                                                          .spaceBtwItems /
                                                      2),

                                              // -- Text
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const CustomBrandTitleTextVerifiedIcon(
                                                          title: 'VShoes',
                                                          brandTextSize:
                                                              TextSizes.large),
                                                      Text(
                                                        '256 Products',
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium,
                                                      )
                                                    ]),
                                              )
                                            ])));
                                  })
                            ])))
              ];
            },
            body: Container()));
  }
}
