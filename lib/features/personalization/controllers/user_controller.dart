import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/data/repositories/user/user_repository.dart';
import 'package:bagit/features/authentication/screens/login/login.dart';
import 'package:bagit/features/personalization/models/user_model.dart';
import 'package:bagit/features/personalization/screens/profile/widgets/reauthenticate_user_login_form.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  // Confirmed twice 
  final userRepository = Get.put(UserRepository(), permanent: true);
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  
  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final fetchedUser = await userRepository.fetchUserDetails();
      user.value = fetchedUser;
    } catch (e) {
      user.value = UserModel.empty();
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user record
      await fetchUserRecord();

      // If no record exists
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert name to first and last name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map Data
          final newUser = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              firstSurname: nameParts[1],
              lastSurname:
                  nameParts.length > 2 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '', addresses: []);

          // Save user data
          await userRepository.saveUserRecord(newUser);
        }
      }
    } catch (e) {
      CustomLoaders.warningSnackbar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your profile.');
    }
  }

  // Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(CustomSizes.md),
        title: 'Delete Account',
        middleText:
            'This action is irreversible and deletes all your data permanently. Are you sure you want to permanently delete your account?',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: CustomSizes.lg),
                child: Text('Delete'))),
        cancel: OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(Get.overlayContext!).pop()));
  }

  // Delete user account
  void deleteUserAccount() async {
    try {
      CustomFullscreenLoader.openLoadingDialog(
          'Processing', CustomImages.lottieLoadingllustration);

      // First user reauthentication
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re-verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          CustomFullscreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          CustomFullscreenLoader.stopLoading();
          Get.to(() => const ReauthenticateLoginForm());
        }
      }
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.warningSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }

  // Reauthenticate before deleting
  Future<void> reauthenticateEmailAndPasswordUser() async {
    try {
      CustomFullscreenLoader.openLoadingDialog(
          'Processing', CustomImages.lottieLoadingllustration);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reauthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyEmail.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      CustomFullscreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.warningSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }

  // Upload profile picture
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile', image);

        // Update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        CustomLoaders.successSnackbar(
            title: 'Done!', message: 'Profile picture successfully updated!');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Oh, snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
