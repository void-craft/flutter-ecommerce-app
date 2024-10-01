import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/loaders/animation_loader.dart';
import 'package:bagit/features/shop/controllers/order_controller.dart';
import 'package:bagit/navigation_menu.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomOrderListItems extends StatelessWidget {
  const CustomOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          // Nothing Found Widget
          final emptyWidget = CustomAnimationLoaderWidget(
              text: 'Sorry! No Orders Yet!',
              animation: CustomImages.orderCompleteIllustration,
              showAction: true,
              actionText: 'Let\'s fill it',
              onActionPressed: () => Get.off(() => const NavigationMenu()));

          // Helper function: Handle loader, no record, or error message
          final response = CustomCloudHelperFunctions.checkMultipleRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          // Congratulations! Record found
          final orders = snapshot.data!;
          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: CustomSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return CustomRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(CustomSizes.md),
                    backgroundColor: CustomHelperFunctions.isDarkMode(context) ? CustomColors.dark : CustomColors.light,
                    child: Column(
                      children: [
                      // -- Row 1
                      Row(children: [
                        // Icon
                        const Icon(Iconsax.ship),
                        const SizedBox(width: CustomSizes.spaceBtwItems / 2),

                        // Status & Date
                        Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(order.orderStatusText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: CustomColors.primary,
                                          fontWeightDelta: 1)),
                              Text(order.formattedDeliveryDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ])),
                        // -- Icon
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.arrow_right_34,
                                size: CustomSizes.iconSm))
                      ]),
                      const SizedBox(height: CustomSizes.spaceBtwItems),

                      //// -- Row 2 -- ////
                      Row(children: [
                        Expanded(
                            child: Row(children: [
                          // Icon
                          const Icon(Iconsax.tag),
                          const SizedBox(width: CustomSizes.spaceBtwItems / 2),

                          // Status & Date
                          Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('Order',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!),
                                Text(order.id,
                                    style:
                                        Theme.of(context).textTheme.titleMedium)
                              ]))
                        ])),
                        // -- Row 3
                        Expanded(
                            child: Row(children: [
                          // Icon
                          const Icon(Iconsax.calendar),
                          const SizedBox(width: CustomSizes.spaceBtwItems / 2),

                          // Status & Date
                          Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('Shipping Date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!),
                                Text(order.formattedDeliveryDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ]))
                        ]))
                      ])
                    ]));
              });
        });
  }
}
