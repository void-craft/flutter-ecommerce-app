import 'package:bagit/bindings/general_bindings.dart';
import 'package:bagit/routes/app_routes.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: CustomAppTheme.lightTheme,
        darkTheme: CustomAppTheme.darkTheme,
        initialBinding: GeneralBindings(),
        getPages: AppRoutes.pages,
        home: const Scaffold(
            backgroundColor: CustomColors.primary,
            body:
                Center(child: CircularProgressIndicator(color: Colors.white))));
  }
}
