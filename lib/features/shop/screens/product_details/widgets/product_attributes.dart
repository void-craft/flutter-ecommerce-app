import 'package:bagit/common/widgets/chips/choice_chips.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/product/variation_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductAttributes extends StatelessWidget {
  const CustomProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
      () => Column(children: [
        // -- Selected Attribute Pricing & Description
        // Display variation price and stock when some variation is selected
        if (controller.selectedVariation.value.id.isNotEmpty)
          CustomRoundedContainer(
              padding: const EdgeInsets.all(CustomSizes.md),
              backgroundColor:
                  dark ? CustomColors.darkerGrey : CustomColors.grey,
              child: Column(children: [
                // -- Title, Price and Stock status
                Row(children: [
                  const CustomSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: CustomSizes.spaceBtwItems),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const CustomProductTitleText(
                              title: 'Price : ', smallSize: true),
                          const SizedBox(width: CustomSizes.spaceBtwItems),
                          // -- Actual Price
                          if (controller.selectedVariation.value.salePrice > 0)
                            Text(
                              '€${controller.selectedVariation.value.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                          const SizedBox(width: CustomSizes.spaceBtwItems),

                          // -- Sale Price
                          CustomProductPrice(
                              price: controller.getVariationPrice()),
                        ]),
                        // -- Stock
                        Row(children: [
                          const CustomProductTitleText(
                              title: 'Stock : ', smallSize: true),
                          const SizedBox(width: CustomSizes.spaceBtwItems),
                          Text(controller.variationStocksStatus.value,
                              style: Theme.of(context).textTheme.titleMedium)
                        ])
                      ])
                ]),
                // - Variation Description
                CustomProductTitleText(
                  title: controller.selectedVariation.value.description ?? '',
                  smallSize: true,
                  maxLines: 4,
                )
              ])),
        const SizedBox(height: CustomSizes.spaceBtwItems),

        // -- Attributes
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSectionHeading(
                              title: attribute.name ?? '',
                              showActionButton: false),
                          const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                          Obx(
                            () => Wrap(
                                spacing: 8,
                                children:
                                    attribute.values!.map((attributeValue) {
                                  final isSelected = controller
                                          .selectedAttributes[attribute.name] ==
                                      attributeValue;
                                  final available = controller
                                      .getAttributesAvailabilityInVariation(
                                          product.productVariations!,
                                          attribute.name!)
                                      .contains(attributeValue);

                                  return CustomChoiceChip(
                                      text: attributeValue,
                                      selected: isSelected,
                                      onSelected: available
                                          ? (selected) {
                                              if (selected && available) {
                                                controller.onAttributeSelected(
                                                    product,
                                                    attribute.name ?? '',
                                                    attributeValue);
                                              }
                                            }
                                          : null);
                                }).toList()),
                          )
                        ]))
                .toList())
      ]),
    );
  }
}
