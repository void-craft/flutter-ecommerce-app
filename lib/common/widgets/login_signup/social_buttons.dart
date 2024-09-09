import 'package:bagit/features/authentication/controllers/login/login_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSocialButtons extends StatelessWidget {
  const CustomSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController(), permanent: true);

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: CustomColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: const Image(
                width: CustomSizes.iconMd,
                height: CustomSizes.iconMd,
                image: AssetImage(CustomImages.google),
              )))
    ]);
  }
}