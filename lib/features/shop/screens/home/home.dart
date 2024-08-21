import 'package:bagit/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bagit/features/shop/screens/home/wigets/theme_home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      // Header
      CustomPrimaryHeaderContainer(child: ThemeHomeAppBar())
    ])));
  }
}
