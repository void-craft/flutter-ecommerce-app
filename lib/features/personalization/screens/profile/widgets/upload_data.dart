import 'package:bagit/features/shop/controllers/banner_controller.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/screens/upload_product/upload_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/sizes.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BannerController bannerController = BannerController();
    CategoryController categoryController = CategoryController();

    return Scaffold(
        appBar: const CustomAppBar(title: Text('Upload Data')),
        body: SingleChildScrollView(
            child: Column(children: [
          // -- Body
          Padding(
              padding: const EdgeInsets.all(CustomSizes.defaultSpace),
              child: Column(children: [
                // -- Main Record Section
                const CustomSectionHeading(
                    title: 'Main Record', showActionButton: false),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                // Upload Categories --- DONE
                CustomSettingsMenuTile(
                    icon: Iconsax.category,
                    title: 'Upload Categories',
                    subtitle: 'Upload product categories',
                    trailing: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () async {
                          await categoryController.uploadCategory();
                        })),
                // Upload Brands
                CustomSettingsMenuTile(
                    icon: Iconsax.shop,
                    title: 'Upload Brands',
                    subtitle: 'Upload product brands',
                    trailing: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () {
                          // Handle upload action
                        })),
                // Upload Products
                CustomSettingsMenuTile(
                    icon: Iconsax.bag,
                    title: 'Upload Products',
                    subtitle: 'Upload product data',
                    trailing: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () async {
                          await Get.dialog(UploadProductDialog());
                        })),
                // Upload Banners - DONE
                CustomSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'Upload Banners',
                    subtitle: 'Upload banner images',
                    trailing: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () async {
                          await bannerController.uploadBanner();
                        })),
                const SizedBox(height: CustomSizes.spaceBtwSections),

                // -- Relationships Section
                const CustomSectionHeading(
                    title: 'Relationships', showActionButton: false),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                // Upload Brand & Categories Relation Data
                CustomSettingsMenuTile(
                    icon: Iconsax.link,
                    title: 'Upload Brand & Categories Relation Data',
                    subtitle: 'Set relationships between brands and categories',
                    trailing: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () {
                          // Handle upload action
                        })),
                // Upload Product Categories Relational Data
                CustomSettingsMenuTile(
                    icon: Iconsax.link,
                    title: 'Upload Product Categories Relational Data',
                    subtitle:
                        'Set relationships between products and categories',
                    trailing: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () {
                          // Handle upload action
                        })),
                const SizedBox(height: CustomSizes.spaceBtwSections * 2.5),
              ]))
        ])));
  }
}
