import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TouchedBadgeWidget extends StatelessWidget {
  const TouchedBadgeWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.borderColor,
  });
  final IconData icon;
  final Color iconColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: 55.0,
      height: 55.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.all(55.0 * .15),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
