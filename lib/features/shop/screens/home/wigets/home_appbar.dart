import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/products/custom_cart_counter_icon.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:bagit/features/personalization/controllers/user_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Confirmed
    final controller = UserController.instance;
    return CustomAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(CustomTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: CustomColors.white)),
        Obx(() {
          if (controller.profileLoading.value) {
            return const CustomShimmerEffect(width: 80, height: 15);
          } else {
            return Text(controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: CustomColors.white));
          }
        })
      ]),
      actions: const [
        CustomCartCounterIcon(
            iconColor: CustomColors.white,
            counterBgColor: CustomColors.black,
            counterTextColor: CustomColors.white)
      ],
      showBackArrow: false,
    );
  }
}
