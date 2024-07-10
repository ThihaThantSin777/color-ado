import 'package:flutter/material.dart';

class CustomIndicatorWidget extends StatelessWidget {
  const CustomIndicatorWidget({
    super.key,
    required this.pageIndex,
    required this.totalIndicator,
    required this.onTapIndicator,
    this.activeColor,
    this.inActiveColor,
    this.height,
  });

  final int pageIndex;
  final int totalIndicator;
  final Function(int) onTapIndicator;
  final Color? activeColor;
  final Color? inActiveColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        totalIndicator,
        (index) => GestureDetector(
          onTap: () => onTapIndicator(index),
          child: AnimatedContainer(
            margin: const EdgeInsets.only(right: 10),
            duration: const Duration(milliseconds: 500),
            width: pageIndex == index ? 21 : 12,
            height: height ?? 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: pageIndex == index ? activeColor ?? Colors.white : inActiveColor ?? Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
