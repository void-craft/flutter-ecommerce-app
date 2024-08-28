import 'package:bagit/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:bagit/features/shop/screens/sub_category/sub_categories.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeCategories extends StatelessWidget {
  const CustomHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return CustomVerticalImageText(image: CustomImages.shoeIcon, title: 'Shoes', onTap: () => Get.to(() => const SubCategoriesScreen()));
          }),
    );
  }
}