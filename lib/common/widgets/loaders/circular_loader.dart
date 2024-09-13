import 'package:bagit/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomCircularLoader extends StatelessWidget {
  final Color? loaderColor;
  final double loaderSize;
  final Color? backgroundColor;
  final double borderRadius;
  final double padding;

  const CustomCircularLoader({
    Key? key,
    this.loaderColor,
    this.loaderSize = 50.0,
    this.backgroundColor,
    this.borderRadius = 10.0,
    this.padding = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomColors.grey.withOpacity(0.9),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: SizedBox(
          height: loaderSize,
          width: loaderSize,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                loaderColor ?? CustomColors.primary),
            strokeWidth: 4.0,
          ),
        ),
      ),
    );
  }

  // Static method to show the loader in a dialog.
  static Future<void> showLoader(BuildContext context, {bool dismissible = false}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: CustomCircularLoader(),
        );
      },
    );
  }

  // Static method to hide the loader.
  static void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
