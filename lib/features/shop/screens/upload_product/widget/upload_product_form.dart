import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomUploadProductForm extends StatelessWidget {
  const CustomUploadProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    

    return Form(
      key: controller.uploadFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ID Field (Required)
          _buildTextField(
            label: 'ID',
            icon: Iconsax.tag,
            validator: (value) => CustomValidator.validateEmptyText('ID', value),
            onChanged: (value) => controller.id.value = value,
          ),

          /// Title Field (Required)
          _buildTextField(
            label: 'Title',
            icon: Iconsax.book,
            validator: (value) => CustomValidator.validateEmptyText('Title', value),
            onChanged: (value) => controller.title.value = value,
          ),

          /// Stock Field (Required)
          _buildTextField(
            label: 'Stock',
            icon: Iconsax.box,
            keyboardType: TextInputType.number,
            validator: (value) => CustomValidator.validatePositiveNumber(value, 'Stock'),
            onChanged: (value) => controller.stock.value = int.tryParse(value) ?? 0,
          ),

          /// Price Field (Required)
          _buildTextField(
            label: 'Price',
            icon: Iconsax.coin,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) => CustomValidator.validatePrice(value),
            onChanged: (value) => controller.price.value = double.tryParse(value) ?? 0.0,
          ),

          /// Product Type Selection (Radio Buttons)
          const SizedBox(height: CustomSizes.spaceBtwSections),
          Text('Product Type', style: Theme.of(context).textTheme.titleMedium),
          Row(
           children: [
              Obx(() => Radio<ProductType>(
                    value: ProductType.single,
                    groupValue: controller.productType.value,
                    onChanged: (ProductType? value) {
                      if (value != null) {
                        controller.productType.value = value;
                      }
                    },
                  )),
              const Text('Single'),
              Obx(() => Radio<ProductType>(
                    value: ProductType.variable,
                    groupValue: controller.productType.value,
                    onChanged: (ProductType? value) {
                      if (value != null) {
                        controller.productType.value = value;
                      }
                    },
                  )),
              const Text('Variable'),
            ],
          ),

          /// Thumbnail Upload (Required)
          const SizedBox(height: CustomSizes.spaceBtwSections),
          Row(
            children: [
              Text('Thumbnail', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: CustomSizes.spaceBtwInputFields),
              IconButton(
                onPressed: controller.pickThumbnail,
                icon: const Icon(Icons.upload), // Upload icon
                tooltip: 'Upload Thumbnail',
              ),
            ],
          ),
          if (controller.thumbnail.value.isNotEmpty)
            Text('Thumbnail Selected: ${controller.thumbnail.value}'),

          /// Optional Fields Header
          const SizedBox(height: CustomSizes.spaceBtwSections),
          Text('Optional Fields', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: CustomSizes.spaceBtwInputFields),

          /// Description (Optional)
          _buildTextField(
            label: 'Description (Optional)',
            icon: Iconsax.note,
            onChanged: (value) => controller.description.value = value,
          ),

          /// SKU (Optional)
          _buildTextField(
            label: 'SKU (Optional)',
            icon: Iconsax.code,
            onChanged: (value) => controller.sku.value = value,
          ),

          /// Brand (Optional)
          _buildTextField(
            label: 'Brand (Optional)',
            icon: Iconsax.bank,
            onChanged: (value) => controller.brand.value = value,
          ),

          /// Category ID (Optional)
          _buildTextField(
            label: 'Category ID (Optional)',
            icon: Iconsax.tag,
            onChanged: (value) => controller.categoryId.value = value,
          ),

          /// Sale Price (Optional)
          _buildTextField(
            label: 'Sale Price (Optional)',
            icon: Iconsax.money,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) => controller.salePrice.value = double.tryParse(value) ?? 0.0,
          ),

          /// Product Images Upload (Optional)
          const SizedBox(height: CustomSizes.spaceBtwSections),
          Row(
            children: [
              Text('Product Images (Optional)', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: CustomSizes.spaceBtwInputFields),
              IconButton(
                onPressed: controller.pickImages,
                icon: const Icon(Icons.upload), // Upload icon
                tooltip: 'Upload Images',
              ),
            ],
          ),
          if (controller.additionalImages.isNotEmpty)
            Text('${controller.additionalImages.length} images selected'),

          const SizedBox(height: CustomSizes.spaceBtwSections),
        ],
      ),
    );
  }

  /// Helper method to build text fields with validation
  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CustomSizes.spaceBtwInputFields),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
