import 'package:daily_task_manager/values/values.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  CustomDivider({
    this.width = Sizes.WIDTH_80,
    this.height = Sizes.HEIGHT_1,
    this.color = AppColors.white,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
