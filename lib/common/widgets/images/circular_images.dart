import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    this.fit,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = CustomSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: backgroundColor ??
                (CustomHelperFunctions.isDarkMode(context)
                    ? CustomColors.black
                    : CustomColors.white),
            borderRadius: BorderRadius.circular(100)),
        child: Center(
            child: Image(
                fit: fit,
                image: isNetworkImage
                    ? NetworkImage(image)
                    : AssetImage(image) as ImageProvider,
                color: overlayColor)));
  }
}
