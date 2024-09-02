import 'package:flutter/material.dart';
import 'package:job_portal/screens/dashboard/widgets/job_desc_widget.dart';

class CurvedBottomSheet extends StatelessWidget {
  final Widget child;
  final double curveHeight;

  const CurvedBottomSheet({
    super.key,
    required this.child,
    this.curveHeight = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CurvedBottomSheetClipper(curveHeight: curveHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: child,
            ),
          ),
        ),
        Positioned(
            top: -2,
            left: 20,
            child: Container(
              height: 100,
              width: 100,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.red,
                ),
              ),
            ))
      ],
    );
  }
}

class CurvedBottomSheetClipper extends CustomClipper<Path> {
  final double curveHeight;

  CurvedBottomSheetClipper({this.curveHeight = 20});

  @override
  Path getClip(Size size) {
    final path = Path();

    // Define constants
    final curveHeight =
        size.height * 0.05; // Subtle curve (5% of screen height)
// Radius of 50 pixels for the circular protrusion

    // Adjust the circle center position
    /* final circleCenter = Offset(
      circleRadius * 0.8 + 30.0, // Shift the center to the right by 30px
      (curveHeight + circleRadius * 0.4) * 3, // Increase the height by 3 times
    ); */

    // Start at the top-left corner
    path.moveTo(0, 0);

    // Move to the start of the curve, accounting for the large protrusion
    path.lineTo(0, curveHeight);

    // Draw the main subtle curve
    path.quadraticBezierTo(
      size.width * 0.5, // control point x (middle of the screen)
      0, // control point y
      size.width, // end point x
      curveHeight, // end point y
    );

    // Complete the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    /* // Add the large circular protrusion ("chicken pox")
    path.addArc(
      Rect.fromCircle(center: circleCenter, radius: circleRadius),
      pi, // Start angle (facing left)
      pi, // Sweep angle (half circle)
    );
 */
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Usage example
void showCurvedBottomSheet(BuildContext context , int index) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return CurvedBottomSheet(
        child: JobDescWidget(index: index),
      );
    },
  );
}
