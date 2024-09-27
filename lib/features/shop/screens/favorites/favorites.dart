import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/icons/circular_icon.dart';
import 'package:bagit/common/widgets/layouts/grid_layout.dart';
import 'package:bagit/common/widgets/loaders/animation_loader.dart';
import 'package:bagit/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bagit/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:bagit/features/shop/controllers/product/favorites_controller.dart';
import 'package:bagit/features/shop/screens/home/home.dart';
import 'package:bagit/navigation_menu.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Scaffold(
        appBar: CustomAppBar(
            showBackArrow: false,
            title: Text('Favorites',
                style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              CustomCircularIcon(
                  icon: Iconsax.add,
                  onPressed: () => Get.to(const HomeScreen()))
            ]),
        // Body
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),

                // Product Grid
                child: Obx(() => FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, snapshot) {
                      final emptyWidget = CustomAnimationLoaderWidget(
                          text: 'Whoops! Wishlist is empty!',
                          animation: CustomImages.lottieGhostIllustration,
                          showAction: true,
                          actionText: 'Let\'s add some',
                          onActionPressed: () =>
                              Get.off(() => const NavigationMenu()));

                      const loader = CustomVerticalProductShimmer(itemCount: 6);
                      final widget =
                          CustomCloudHelperFunctions.checkMultipleRecordState(
                              snapshot: snapshot,
                              loader: loader,
                              nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return CustomGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => CustomProductCardVertical(
                              product: products[index]));
                    })))));
  }
}
