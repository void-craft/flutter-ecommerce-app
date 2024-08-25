import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: Text('Profile'), showBackArrow: true),

        // -- Body
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Column(children: [
                  // -- Profile Picture
                  SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        const CustomCircularImage(
                            image: CustomImages.user, width: 80, height: 80),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Change Profile Picture'))
                      ])),

                  // -- Details
                  const SizedBox(height: CustomSizes.defaultSpace / 2),
                  const Divider(),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // -- Heading Proflie Information
                  const CustomSectionHeading(
                      title: 'Profile Information', showActionButton: false),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  CustomProfileMenu(
                      onPressed: () {}, title: 'Name', value: 'Void Craft'),

                  // -- Break
                  const SizedBox(height: CustomSizes.defaultSpace / 2),
                  const Divider(),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // -- Heading Personal Information
                  const CustomSectionHeading(
                      title: 'Personal Information', showActionButton: false),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'User ID',
                      value: '1234567890',
                      icon: Iconsax.copy),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'E-mail',
                      value: 'example@email.com'),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'Phone Number',
                      value: '+34 612 345 678'),
                  CustomProfileMenu(
                      onPressed: () {}, title: 'Gender', value: 'None'),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'Date of Birth',
                      value: '01/01/1900'),
                  const Divider(),
                  const SizedBox(height: CustomSizes.sm),

                  Center(
                      child: TextButton(
                          onPressed: () {},
                          child: const Text('Close Account',
                              style: TextStyle(color: Colors.red))))
                ]))));
  }
}
