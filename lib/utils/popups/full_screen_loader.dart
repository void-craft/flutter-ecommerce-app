import 'package:bagit/common/widgets/loaders/animation_loader.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFullscreenLoader {
  // This static method displays a full-screen loading dialog.
  // Parameters:
  // - text: The message to display with the loading animation.
  // - animation: The type of animation to display.
  static void openLoadingDialog(String text, String animation) {
    // Show a modal dialog that cannot be dismissed by tapping outside (barrierDismissible: false).
    // Get.overlayContext! provides the overlay context from GetX, which is used to display dialogs.
    showDialog(
        context: Get.overlayContext!, // GetX's overlay context.
        barrierDismissible:
            false, // Prevent dismissing the dialog by tapping outside.
        builder: (_) => PopScope(
            // PopScope widget prevents the back button from closing the dialog.
            canPop:
                false, // Disable popping the dialog (e.g., via the back button).
            child: Container(
                color: CustomHelperFunctions.isDarkMode(Get.context!)
                    ? CustomColors.dark
                    : CustomColors.white,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 250),
                    CustomAnimationLoaderWidget(
                      // Display the custom animation loader widget.
                      text: text, // Pass the text to display with the loader.
                      animation: animation, // Pass the animation type.
                    )
                  ]),
                ))));
  }

  // This static method closes the currently open loading dialog.
  // It does not return any value.
  static stopLoading() {
    // Pop (close) the top-most route in the navigation stack, which is the loading dialog.
    Navigator.of(Get.overlayContext!).pop();
  }
}
