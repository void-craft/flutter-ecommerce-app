import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL');
    email.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }

  // -- Email and Password Signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start the loading screen
      CustomFullscreenLoader.openLoadingDialog(
          'Logging you in...', CustomImages.loginIllustration);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove loader
      CustomFullscreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackbar(title: 'Oh, Snap!', message: e.toString());
    }
  }
}
