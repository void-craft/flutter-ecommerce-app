import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/personalization/controllers/user_controller.dart';
import 'package:bagit/features/personalization/screens/profile/widgets/update_name.dart';
import 'package:bagit/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
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
                        Obx(() {
                          final networkImage =
                              controller.user.value.profilePicture;
                          final image = networkImage.isNotEmpty
                              ? networkImage
                              : CustomImages.user;
                          return controller.imageUploading.value
                              ? const CustomShimmerEffect(
                                  width: 80, height: 80, radius: 80)
                              : CustomCircularImage(
                                  image: image,
                                  width: 80,
                                  height: 80,
                                  isNetworkImage: networkImage.isNotEmpty);
                        }),
                        TextButton(
                            onPressed: () =>
                                controller.uploadUserProfilePicture(),
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
                      onPressed: () => Get.to(() => const UpdateNameScreen()),
                      title: 'Name',
                      value: controller.user.value.fullName),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'Username',
                      value: controller.user.value.username),

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
                      value: controller.user.value.id,
                      icon: Iconsax.copy),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'E-mail',
                      value: controller.user.value.email),
                  CustomProfileMenu(
                      onPressed: () {},
                      title: 'Phone Number',
                      value: controller.user.value.phoneNumber),
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
                          onPressed: () =>
                              controller.deleteAccountWarningPopup(),
                          child: const Text('Close Account',
                              style: TextStyle(color: Colors.red))))
                ]))));
  }
}
