import 'package:bagit/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:bagit/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomPrimaryHeaderContainer extends StatelessWidget {
  const CustomPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdges(
      child: Container(
        color: CustomColors.primary,
        child: Stack(
          children: [
            Positioned(top: -150, right: -250, child: CustomCircularContainer(backgroundColor:CustomColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: -300, child: CustomCircularContainer(backgroundColor:CustomColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
              ),
    );
  }
}
