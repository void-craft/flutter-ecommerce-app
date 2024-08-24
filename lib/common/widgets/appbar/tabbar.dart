import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/device/device_utility.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Material(
        color: dark ? CustomColors.black : CustomColors.white,
        child: TabBar(
          tabAlignment: TabAlignment.start,
            tabs: tabs,
            isScrollable: true,
            indicatorColor: CustomColors.primary,
            labelColor: dark ? CustomColors.white : CustomColors.primary,
            unselectedLabelColor: CustomColors.darkGrey));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(CustomDeviceUtils.getAppBarHeight());
}
