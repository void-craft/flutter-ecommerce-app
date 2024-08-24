import 'package:bagit/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class CustomBrandTitleText extends StatelessWidget {
  const CustomBrandTitleText({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: brandTextSize == TextSizes.small
            ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
            : brandTextSize == TextSizes.medium
                ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
                : brandTextSize == TextSizes.large
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: color)
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: color));
  }
}
