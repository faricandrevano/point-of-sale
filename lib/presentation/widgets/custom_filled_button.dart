import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.width,
    this.alignment,
    this.height,
    this.color,
    this.textColor,
  });
  final String label;
  final Icon? icon;
  final VoidCallback? onPressed;
  final double? width;
  final IconAlignment? alignment;
  final double? height;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? double.infinity,
      child: ElevatedButton.icon(
        iconAlignment: alignment ?? IconAlignment.end,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          backgroundColor: color ?? primaryMain,
          side: BorderSide(color: neutral30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: Text(
          label,
          style: bodyL.copyWith(
            fontWeight: semiBold,
            color: textColor ?? neutral10,
          ),
        ),
        icon: icon,
      ),
    );
  }
}
