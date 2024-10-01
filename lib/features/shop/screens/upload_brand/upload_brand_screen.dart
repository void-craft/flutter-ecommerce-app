import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/shop/screens/upload_brand/widgets/upload_brand_action.dart';
import 'package:bagit/features/shop/screens/upload_brand/widgets/upload_brand_form.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UploadBrandScreen extends StatelessWidget {
  const UploadBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: Text('Upload Brand')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(height: CustomSizes.spaceBtwSections),
              /// Upload Brand Form
              CustomUploadBrandForm(),
              SizedBox(height: CustomSizes.spaceBtwSections),
              CustomUploadBrandActions(),
            ],
          ),
        ),
      ),
    );
  }
}
