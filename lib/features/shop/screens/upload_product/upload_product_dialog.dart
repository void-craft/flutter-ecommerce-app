import 'dart:io';
import 'package:bagit/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_attribute_model.dart';
import 'package:bagit/features/shop/models/product/product_variation_model.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductDialog extends StatelessWidget {
  final ProductController productController = ProductController.instance;
  final CustomFirebaseStorageService storageService = CustomFirebaseStorageService.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();

  final Rx<File?> thumbnailFile = Rx<File?>(null);
  final RxList<File> imageFiles = <File>[].obs;

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<ProductAttributeModel>? productAttributes = <ProductAttributeModel>[].obs;
  final RxList<ProductVariationModel>? productVariations = <ProductVariationModel>[].obs;

  UploadProductDialog({super.key});

  Future<void> _pickImage(bool isThumbnail) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (isThumbnail) {
        thumbnailFile.value = file;
      } else {
        imageFiles.add(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Product'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title *'),
                validator: (value) => value?.isEmpty ?? true ? 'This field is required' : null,
              ),
              const SizedBox(height: CustomSizes.spaceBtwInputFields),
              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock *'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'This field is required' : null,
              ),
              const SizedBox(height: CustomSizes.spaceBtwInputFields),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price *'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'This field is required' : null,
              ),
              const SizedBox(height: CustomSizes.spaceBtwInputFields),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(true),
                    child: const Text('Select Thumbnail'),
                  ),
                  const SizedBox(width: 10),
                  Obx(() => Text(thumbnailFile.value != null
                      ? thumbnailFile.value!.path.split('/').last
                      : 'No file selected')),
                ],
              ),
              const SizedBox(height: CustomSizes.spaceBtwInputFields),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Single'),
                        leading: Radio<ProductType>(
                          value: ProductType.single,
                          groupValue: productController.currentProductType,
                          onChanged: (value) {
                            if (value != null) {
                              productController.currentProductType = value;
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Variable'),
                        leading: Radio<ProductType>(
                          value: ProductType.variable,
                          groupValue: productController.currentProductType,
                          onChanged: (value) {
                            if (value != null) {
                              productController.currentProductType = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwInputFields),
              TextFormField(
                controller: categoryIdController,
                decoration: const InputDecoration(labelText: 'Category ID *'),
                validator: (value) => value?.isEmpty ?? true ? 'This field is required' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        Obx(() => ElevatedButton(
              onPressed: productController.isLoading.value
                  ? null
                  : () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await productController.uploadProduct(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: titleController.text,
                          productType: productController.currentProductType.name,
                          stock: int.parse(stockController.text),
                          price: double.parse(priceController.text),
                          thumbnail: thumbnailFile.value!,
                          categoryId: categoryIdController.text,
                          sku: skuController.text,
                          description: descriptionController.text,
                          images: imageFiles.toList(),
                          salePrice: salePriceController.text.isNotEmpty
                              ? double.tryParse(salePriceController.text)
                              : null,
                          brand: selectedBrand.value,
                          date: selectedDate.value,
                          productVariations: productVariations?.toList(),
                          productAttributes: productAttributes?.toList(),
                        );
                      }
                    },
              child: productController.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Upload'),
            )),
      ],
    );
  }
}
