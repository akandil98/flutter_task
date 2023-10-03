import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';

class BadgeWidget extends StatelessWidget {
  final Color color;
  const BadgeWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.scaffoldBackgroundColor,
        ),
        color: AppColors.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.scaffoldBackgroundColor,
          ),
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
