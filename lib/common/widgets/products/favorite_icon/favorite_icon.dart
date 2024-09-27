import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/features/shop/controllers/product/favorites_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomFavoriteIcon extends StatelessWidget {
  const CustomFavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    // First Instance
    final controller = FavoritesController.instance;
    return Obx(() => CustomCircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? CustomColors.error : null,
        onPressed: () => controller.toggleFavoriteProduct(productId)));
  }
}
