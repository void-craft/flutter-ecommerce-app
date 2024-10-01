import 'package:bagit/app.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Add widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  // GetX local storage
  await GetStorage.init();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BagIt',
      home: BaseApp(), // Your main app screen
    );
  }
  // Await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize firebase & authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) async {
    Get.put(AuthenticationRepository(), permanent: true);
  });

  runApp(const App());
}
