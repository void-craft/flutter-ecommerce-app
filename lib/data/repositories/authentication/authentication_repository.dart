import 'package:bagit/features/authentication/screens/login/login.dart';
import 'package:bagit/features/authentication/screens/onboarding/onboarding.dart';
import 'package:bagit/features/authentication/screens/signup/verify_email.dart';
import 'package:bagit/navigation_menu.dart';
import 'package:bagit/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
import 'package:bagit/utils/exceptions/format_exceptions.dart';
import 'package:bagit/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Called from main.dart on app launch
  @override
  void onReady() {
    // Remove native splash screen.
    FlutterNativeSplash.remove();
    // Redirect to the appropriate screen.
    screenRedirect();
  }

  // Function to show relevant screen.
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirsTime', true);
      // Check if it's app's first time loading.
      deviceStorage.read('isFirstTime') != true
          // Redirect to login if not
          ? Get.offAll(() => const LoginScreen())
          // Redirect to onboarding if yes
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /* ----------- Email & Password SignIn */

  // Email Authentication - SignIn
  // Email Authentication - SignUp
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // EmailVerification - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [ReAuthentication] - ReAuthenticate user

  /* ----------- ./end Federated identity & social sign-in ----- */
  
  // [LogoutUser] Valid for any authentication.
  Future<void> logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginScreen());
  } on FirebaseAuthException catch (e) {
    throw CustomFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    throw CustomFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const CustomFormatException();
  } on PlatformException catch (e) {
    throw CustomPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again later.';
  }
}



  // [DeleteUser] Remove user Auth and Firestore account.
}
