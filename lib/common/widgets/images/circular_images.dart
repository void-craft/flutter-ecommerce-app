import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/common/widgets/shimmers/shimmer_effect.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    this.fit,
    required this.image,
    this.isNetworkImage = true,
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
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: backgroundColor ??
                (dark ? CustomColors.black : CustomColors.white),
            borderRadius: BorderRadius.circular(100)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Center(
                child: isNetworkImage
                    ? CachedNetworkImage(
                        fit: fit,
                        color: overlayColor,
                        imageUrl: image,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CustomShimmerEffect(
                                    width: 55, height: 55, radius: 55),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error))
                    : Image(
                        fit: fit,
                        image: AssetImage(image),
                        color: overlayColor))));
  }
}
