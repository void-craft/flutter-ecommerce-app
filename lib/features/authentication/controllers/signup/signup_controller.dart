import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/data/repositories/user/user_repository.dart';
import 'package:bagit/features/authentication/screens/signup/verify_email.dart';
import 'package:bagit/features/personalization/models/user_model.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstSurname = TextEditingController();
  final lastSurname = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // -- SIGNUP
  Future<void> signup() async {
    // Start loading
    CustomFullscreenLoader.openLoadingDialog(
        'Processing information...', CustomImages.lottieLoadingllustration);

    try {
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackbar(
            title: 'No Internet',
            message: 'Please check your internet connection and try again.');
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove loader
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        CustomLoaders.warningSnackbar(
            title: 'Accept Privacy Policy',
            message:
                'To create an account, you must read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      // Register user in Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save authenticated user in Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          firstSurname: firstSurname.text.trim(),
          lastSurname: lastSurname.text.trim(), // Fixed from firstSurname
          username: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = UserRepository.instance;
      await userRepository.saveUserRecord(newUser);

      // Remove loader
      CustomFullscreenLoader.stopLoading();

      // Show success message
      CustomLoaders.successSnackbar(
          title: 'Congratulations!',
          message:
              'Your account has been created! Verify your email to continue.');

      // Navigate to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
      } catch (e) {
      // Remove loader
      CustomFullscreenLoader.stopLoading();

      // Show specific error message
      CustomLoaders.errorSnackbar(
          title: 'Error!',
          message: e is String ? e : 'An unexpected error occurred.');
    }
  }
}
