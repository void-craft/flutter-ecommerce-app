import 'package:bagit/common/widgets/images/circular_images.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class CustomUserProfileTile extends StatelessWidget {
  const CustomUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CustomCircularImage(
          image: CustomImages.user, width: 50, height: 50, padding: 0),
      title: Text('Void Craft',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: CustomColors.white)),
      subtitle: Text('hemapriyaweb@gmail.com',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: CustomColors.white)),
      trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Iconsax.edit,
            color: CustomColors.white,
          )),
    );
  }
}
