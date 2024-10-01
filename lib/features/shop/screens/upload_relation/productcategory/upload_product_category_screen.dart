import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/shop/screens/upload_relation/productcategory/widget/productcategory_action.dart';
import 'package:bagit/features/shop/screens/upload_relation/productcategory/widget/productcategory_form.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UploadProductCategoryScreen extends StatelessWidget {
  const UploadProductCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: Text('Product-Category Relation')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(height: CustomSizes.spaceBtwSections),
              /// Upload Product-Category Relation Form
              CustomProductCategoryForm(),
              SizedBox(height: CustomSizes.spaceBtwSections),
              CustomProductCategoryAction(),
            ],
          ),
        ),
      ),
    );
  }
}
