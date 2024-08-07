import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        iconAlignment: IconAlignment.end,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          backgroundColor: primaryMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: const CircularProgressIndicator(),
      ),
    );
  }
}
