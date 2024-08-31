import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomLoaders {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: CustomHelperFunctions.isDarkMode(Get.context!)
                    ? CustomColors.darkGrey.withOpacity(0.9)
                    : CustomColors.grey.withOpacity(0.9)),
            child: Center(
                child: Text(message,
                    style: Theme.of(Get.context!).textTheme.labelLarge)))));
  }

  static successSnackbar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CustomColors.primary,
      colorText: Colors.white,
      icon: const Icon(Iconsax.check, color: Colors.white),
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      isDismissible: true,
      shouldIconPulse: true,
    );
  }

  static warningSnackbar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      icon: const Icon(Iconsax.warning_2, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      isDismissible: true,
      shouldIconPulse: true,
    );
  }

  static errorSnackbar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      icon: const Icon(Iconsax.warning_2, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      isDismissible: true,
      shouldIconPulse: true,
    );
  }
}
