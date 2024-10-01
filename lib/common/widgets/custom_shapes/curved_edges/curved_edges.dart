import 'package:flutter/material.dart';

class CustomCurvedEdges extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstPoint = Offset(0, size.height - 20);
    final secondPoint = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy);

    final thirdPoint = Offset(0, size.height - 20);
    final fourthPoint = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(thirdPoint.dx, thirdPoint.dy, fourthPoint.dx, fourthPoint.dy);

    final fifthPoint = Offset(size.width, size.height - 20);
    final sixthPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(fifthPoint.dx, fifthPoint.dy, sixthPoint.dx, sixthPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
