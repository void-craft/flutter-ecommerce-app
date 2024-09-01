import 'package:bagit/app.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // Add widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // GetX local storage
  await GetStorage.init();

  // Await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize firebase & authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // Load all the Material design, themes, localizations, bindings
  runApp(const App());
}
