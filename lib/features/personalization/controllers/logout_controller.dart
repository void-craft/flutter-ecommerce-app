import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/features/authentication/screens/login/login.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();

  Future<void> logoutUser() async {
  try {
    print('Attempting to log out');

    // Start loading
    CustomFullscreenLoader.openLoadingDialog(
        'Logging you out...', CustomImages.lottieLoadingllustration);

    // Perform logout operation using AuthenticationRepository
    await AuthenticationRepository.instance.logout();
    print('Logout successful');

    // Remove Loader
    CustomFullscreenLoader.stopLoading();

    // Redirect to login screen
    Get.offAll(() => const LoginScreen());

    // Show success snackbar
    CustomLoaders.successSnackbar(
      title: 'Logged Out',
      message: 'You have been logged out successfully.',
    );

  } catch (e) {
    print('Logout error: $e');

    // Remove Loader
    CustomFullscreenLoader.stopLoading();

    // Show error snackbar
    CustomLoaders.errorSnackbar(
      title: 'Logout Failed',
      message: e.toString(),
    );
  }
}

}
