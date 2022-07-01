import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand({
    required this.rotationZAngle,
    required this.handThickness,
    required this.handLength,
    required this.color,
    super.key,
  });

  final double rotationZAngle, handThickness, handLength;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topRight,
      transform: Matrix4.identity()
        ..translate(-handThickness / 2, 0, 0)
        ..rotateZ(rotationZAngle),
      child: Container(
        height: handLength,
        width: handThickness,
        color: color,
      ),
    );
  }
}
