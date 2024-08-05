import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {super.key, required this.label, this.icon, this.onPressed});
  final String label;
  final String? icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: Text(
          label,
          style: bodyL.copyWith(
            fontWeight: semiBold,
            color: onPressed == null ? neutral60 : neutral10,
          ),
        ),
        icon: icon != null ? Image.asset(icon.toString()) : null,
      ),
    );
  }
}
