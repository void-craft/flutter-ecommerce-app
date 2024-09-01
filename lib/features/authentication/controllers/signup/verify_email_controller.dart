import 'dart:async';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/common/widgets/success_scren/success_screen.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // Send Email whenever verify screen appears & set timer for auto redirect.

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send email verification link

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      CustomLoaders.successSnackbar(
          title: 'Email sent!',
          message: 'Please check your inbox and verify your email.');
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }

  // Timer to automatically redirect an email verification

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: CustomImages.lottieSuccessllustration,
            title: CustomTexts.yourAccountCreatedTitle,
            subtitle: CustomTexts.yourAccountCreatedSubtitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  // Manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: CustomImages.lottieSuccessllustration,
          title: CustomTexts.yourAccountCreatedTitle,
          subtitle: CustomTexts.yourAccountCreatedSubtitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
