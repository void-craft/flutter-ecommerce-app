import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/features/personalization/controllers/user_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomUserProfileTile extends StatelessWidget {
  const CustomUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
        leading: CustomCircularImage(
            isNetworkImage: true,
            width: 50,
            height: 50,
            padding: 0,
            image: controller.user.value.profilePicture),
        title: Text(controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: CustomColors.white)),
        subtitle: Text(controller.user.value.email,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: CustomColors.white)),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Iconsax.edit,
              color: CustomColors.white,
            )));
  }
}
