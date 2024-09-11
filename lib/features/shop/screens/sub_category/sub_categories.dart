import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text('Sports'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(CustomSizes.defaultSpace),
            child: Column(children: [
              // -- Banner -- //
              const CustomRoundedImage(
                  width: double.infinity,
                  imageUrl: CustomImages.promoBanner4,
                  applyImageRadius: true),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // -- Sub-Categories -- //
              Column(children: [
                // -- Heading -- //
                CustomSectionHeading(title: 'Sports Shoes', onPressed: () {}),
                const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: CustomSizes.spaceBtwItems),
                      itemBuilder: (context, index) =>
                          const CustomProductCardHorizontal()),
                )
              ])
            ])));
  }
}
