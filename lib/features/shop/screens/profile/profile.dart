import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bagit/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:bagit/common/widgets/list_tile/user_profile.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      // -- Header
      CustomPrimaryHeaderContainer(
          child: Column(children: [
        CustomAppBar(
            showBackArrow: false,
            title: Text('Profile',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: CustomColors.white))),
        // const SizedBox(height: CustomSizes.spaceBtwSections),

        // User
        const CustomUserProfileTile(),
        const SizedBox(height: CustomSizes.spaceBtwSections),
      ])),

      // -- Body
      Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(children: [
            // -- Account Settings
            const CustomSectionHeading(
                title: 'Account Settings', showActionButton: false),
            const SizedBox(height: CustomSizes.spaceBtwItems),

            const CustomSettingsMenuTile(
                icon: Iconsax.safe_home,
                title: 'My Addresses',
                subtitle: 'Set shipping address'),
            const CustomSettingsMenuTile(
                icon: Iconsax.shopping_cart,
                title: 'My Cart',
                subtitle: 'View items in your cart'),
            const CustomSettingsMenuTile(
                icon: Iconsax.bag_tick,
                title: 'My Orders',
                subtitle: 'Track your order history'),
            const CustomSettingsMenuTile(
                icon: Iconsax.bank,
                title: 'Bank Account',
                subtitle: 'Manage payment methods'),
            const CustomSettingsMenuTile(
                icon: Iconsax.discount_shape,
                title: 'My Coupons',
                subtitle: 'View available coupons'),
            const CustomSettingsMenuTile(
                icon: Iconsax.notification,
                title: 'Notification',
                subtitle: 'Manage notifications settings'),
            const CustomSettingsMenuTile(
                icon: Iconsax.security_card,
                title: 'Account Privacy',
                subtitle: 'Manage your privacy settings'),

            // -- App Settings
            const SizedBox(height: CustomSizes.spaceBtwSections),
            const CustomSectionHeading(
                title: 'App Settings', showActionButton: false),
            const SizedBox(height: CustomSizes.spaceBtwItems),
            const CustomSettingsMenuTile(
                icon: Iconsax.document_upload,
                title: 'Load Data',
                subtitle: 'Upload Data to your Cloud Firebase'),
            CustomSettingsMenuTile(
                icon: Iconsax.location,
                title: 'Geolocation',
                subtitle: 'Set recommendation based on location',
                trailing: Switch(value: true, onChanged: (value) {})),
            CustomSettingsMenuTile(
                icon: Iconsax.shield_tick,
                title: 'Safe Mode',
                subtitle: 'Enable content safety filter',
                trailing: Switch(value: true, onChanged: (value) {})),
            CustomSettingsMenuTile(
                icon: Iconsax.image,
                title: 'HD Image Quality',
                subtitle: 'Enable high-definition images',
                trailing: Switch(value: false, onChanged: (value) {})),
            const SizedBox(height: CustomSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: (){}, child: const Text('Logout')),
            ),
            const SizedBox(height: CustomSizes.spaceBtwSections * 2.5)
          ]))
    ])));
  }
}
