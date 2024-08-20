import 'package:bagit/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              CustomPrimaryHeaderContainer(
                child: Container(),
              )
            ],
          )
      ),
    );
  }
}
