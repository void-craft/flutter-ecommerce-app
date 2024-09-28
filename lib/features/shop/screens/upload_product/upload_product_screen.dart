import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/shop/screens/upload_product/widget/upload_product_action.dart';
import 'package:bagit/features/shop/screens/upload_product/widget/upload_product_form.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: Text('Upload Product')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(height: CustomSizes.spaceBtwSections),
              /// Upload Product Form
              CustomUploadProductForm(),
              SizedBox(height: CustomSizes.spaceBtwSections),
              CustomUploadProductActions(),
            ],
          ),
        ),
      ),
    );
  }
}
