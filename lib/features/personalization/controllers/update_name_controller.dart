import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/user/user_repository.dart';
import 'package:bagit/features/personalization/controllers/user_controller.dart';
import 'package:bagit/features/personalization/screens/profile/profile.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final firstSurname = TextEditingController();
  final lastSurname = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    firstSurname.text = userController.user.value.firstSurname;
    lastSurname.text = userController.user.value.lastSurname ?? '';
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      CustomFullscreenLoader.openLoadingDialog(
          'Updating your information', CustomImages.lottieLoadingllustration);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Update user's name in Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'FirstSurname': firstSurname.text.trim(),
        'LastSurname': lastSurname.text.trim().isEmpty ? null : lastSurname.text.trim()
      };
      await userRepository.updateSingleField(name);

      // Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.firstSurname = firstSurname.text.trim();
      userController.user.value.lastSurname = lastSurname.text.trim().isEmpty ? null : lastSurname.text.trim();

      // Remove loader
      CustomFullscreenLoader.stopLoading();

      // Show success message
      CustomLoaders.successSnackbar(
          title: 'Done!', message: 'Your name has been updated.');

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }
}
