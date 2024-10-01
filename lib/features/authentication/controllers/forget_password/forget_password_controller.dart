import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/features/authentication/screens/password/reset_password.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // --- Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // --- Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // --- Start loading
      CustomFullscreenLoader.openLoadingDialog(
          'Processing your request...', CustomImages.lottieLoadingllustration);

      // --- Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // --- Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // --- Send email to Reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // --- Remove Loader
      CustomFullscreenLoader.stopLoading();

      // --- Show Success Screen
      CustomLoaders.successSnackbar(
          title: 'Email Sent',
          message: 'An email has been sent to Reset your Password.'.tr);

      // --- Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));

    } catch (e) {

      // --- Remove Loader
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // --- Start loading
      CustomFullscreenLoader.openLoadingDialog(
          'Processing your request...', CustomImages.lottieLoadingllustration);

      // --- Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // --- Send email to Reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      // --- Remove Loader
      CustomFullscreenLoader.stopLoading();

      // --- Show Success Screen
      CustomLoaders.successSnackbar(
          title: 'Email Sent',
          message: 'An email has been sent to Reset your Password.'.tr);

    } catch (e) {
      
      // --- Remove Loader
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }
}
