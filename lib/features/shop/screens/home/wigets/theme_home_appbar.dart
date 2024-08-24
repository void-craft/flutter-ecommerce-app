import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/products/custom_cart_counter_icon.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class ThemeHomeAppBar extends StatelessWidget {
  const ThemeHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(CustomTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: CustomColors.white)),
          Text(CustomTexts.homeAppbarSubtitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: CustomColors.white)),
        ],
      ),
      actions: [
        CustomCartCounterIcon(onPressed: () {})
      ],
      showBackArrow: false, 
    );
  }
}
