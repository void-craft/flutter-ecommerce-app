import 'package:bagit/common/styles/shadows.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/icons/add_to_cart_button.dart';
import 'package:bagit/common/widgets/images/rounded_images.dart';
import 'package:bagit/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:bagit/common/widgets/texts/custom_brand_title_text_verified_icon.dart';
import 'package:bagit/common/widgets/texts/product_price.dart';
import 'package:bagit/common/widgets/texts/product_title_text.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/screens/product_details/product_detail.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCardVertical extends StatelessWidget {
  const CustomProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = CustomHelperFunctions.isDarkMode(context);

    return GestureDetector(
        onTap: () => Get.to(() => ProductDetailScreen(product: product)),
        child: Container(
            width: 180,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              boxShadow: [CustomShadowStyle.verticalProductShadow],
              borderRadius:
                  BorderRadius.circular(CustomSizes.productImageRadius),
              color: dark ? CustomColors.darkerGrey : CustomColors.white,
            ),
            child: Column(children: [
              CustomRoundedContainer(
                  height: 155,
                  width: 180,
                  padding: const EdgeInsets.all(CustomSizes.sm),
                  backgroundColor:
                      dark ? CustomColors.dark : CustomColors.light,
                  child: Stack(children: [
                    Center(
                      child: CustomRoundedImage(
                          height: CustomSizes.productImageSize,
                          imageUrl: product.thumbnail,
                          isNetworkImage: true,
                          applyImageRadius: true),
                    ),
                    if (salePercentage != null)
                      Positioned(
                          top: 10,
                          child: CustomRoundedContainer(
                              radius: CustomSizes.sm,
                              backgroundColor:
                                  CustomColors.secondary.withOpacity(0.8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CustomSizes.sm,
                                  vertical: CustomSizes.xs),
                              child: Text('$salePercentage%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(color: CustomColors.black))),
                      ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: CustomFavoriteIcon(productId: product.id))
                  ])),
              const SizedBox(height: CustomSizes.spaceBtwItems / 2),
              Padding(
                  padding: const EdgeInsets.only(left: CustomSizes.sm),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomProductTitleText(
                            title: product.title, smallSize: true),
                        const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                        CustomBrandTitleTextVerifiedIcon(
                            title: product.brand!.name)
                      ])),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    child: Column(children: [
                  if (product.productType == ProductType.single.toString() &&
                      product.salePrice > 0)
                    Padding(
                        padding: const EdgeInsets.only(left: CustomSizes.sm),
                        child: Text(
                          product.price.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(decoration: TextDecoration.lineThrough),
                        )),
                  Padding(
                    padding: const EdgeInsets.only(left: CustomSizes.sm),
                    child: CustomProductPrice(
                        price: controller.getProductPrice(product)),
                  )
                ])),
                ProductCardAddToCartButton(product: product)
              ])
            ])));
  }
}
