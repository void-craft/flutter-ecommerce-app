import 'package:bagit/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:bagit/common/widgets/shimmers/category_shimmer.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/screens/sub_category/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeCategories extends StatelessWidget {
  const CustomHomeCategories({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if(categoryController.isLoading.value) return const CustomCategoryShimmer();
      
      if(categoryController.featuredCategories.isEmpty){
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
      }
      return SizedBox(
          height: 80,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryController.featuredCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final category = categoryController.featuredCategories[index];

                return CustomVerticalImageText(
                    image: category.image,
                    title: category.name,
                    onTap: () => Get.to(() => const SubCategoriesScreen()));
              }));
    });
  }
}
