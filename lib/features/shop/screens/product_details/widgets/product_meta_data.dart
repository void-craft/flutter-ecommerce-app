import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomProductMetaData extends StatelessWidget {
  const CustomProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = CustomHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salPercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // -- Price & Sale Price
      Row(children: [
        // -- Sale Tag -- DONE
        CustomRoundedContainer(
          radius: CustomSizes.sm,
          backgroundColor: CustomColors.secondary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(
              horizontal: CustomSizes.sm, vertical: CustomSizes.xs),
          child: Text('$salPercentage%',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: CustomColors.black)),
        ),
        const SizedBox(width: CustomSizes.spaceBtwItems),

        // -- Price -- DONE
        if (product.productType == ProductType.single.toString() &&
            product.salePrice > 0)
          Text('€${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough)),
        if (product.productType == ProductType.single.toString() &&
            product.salePrice > 0)
          const SizedBox(width: CustomSizes.spaceBtwItems),
        CustomProductPrice(
            price: controller.getProductPrice(product), isLarge: true)
      ]),
      const SizedBox(height: CustomSizes.borderRadiusMd),

      // -- Title -- DONE
      CustomProductTitleText(title: product.title),
      const SizedBox(height: CustomSizes.spaceBtwItems / 1.5),

      // -- Stock Status -- DONE
      Row(children: [
        const CustomProductTitleText(title: 'Status'),
        const SizedBox(width: CustomSizes.spaceBtwItems),
        Text(controller.getProductStockStatus(product.stock),
            style: Theme.of(context).textTheme.titleMedium)
      ]),
      const SizedBox(height: CustomSizes.spaceBtwItems / 1.5),

      // -- Brand -- DONE
      Row(children: [
        CustomCircularImage(
          image: product.brand != null ? product.brand!.image : '',
          width: 32,
          height: 32,
          overlayColor: darkMode ? CustomColors.white : CustomColors.black,
        ),
        CustomBrandTitleTextVerifiedIcon(
            title: product.brand != null ? product.brand!.name : '',
            brandTextSize: TextSizes.medium),
      ])
    ]);
  }
}
