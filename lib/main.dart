import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:bagit/screens/base/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await dotenv.load(fileName: ".env");
    MapBoxSearch.init(dotenv.env['MAPBOX_API_KEY'] ?? 'your_mapbox_access_token');
  } catch (e) {
    // Handle initialization error
    print('Initialization error: $e');
  }
  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
//   await dotenv.load(fileName: ".env"); // Load environment variables
//   MapBoxSearch.init(dotenv.env['MAPBOX_API_KEY'] ?? 'your_mapbox_access_token'); // Initialize Mapbox with API key
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//   runApp(const MyApp()); // Run the app
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BagIt',
      home: BaseApp(), // Your main app screen
    );
  }
}
