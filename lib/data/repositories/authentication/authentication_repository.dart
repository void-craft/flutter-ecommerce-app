import 'package:bagit/features/authentication/screens/login/login.dart';
import 'package:bagit/features/authentication/screens/onboarding/onboarding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to show Relevant Screen
  screenRedirect() async {
    // Local Storage
    if (kDebugMode) {
      print('================ GET STORAGE Auth ================');
      print(deviceStorage.read('IsFirstTime'));
    }

    deviceStorage.writeIfNull('isFirsTime', true);
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
  }
}
