import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomMenuDashboard extends StatelessWidget {
  const CustomMenuDashboard(
      {super.key, required this.img, required this.title, this.onTap});
  final String img, title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              color: neutral15,
              border: Border.all(
                width: 1,
                color: neutral30,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Image.asset(
                img,
                height: 40,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: bodyM.copyWith(
            fontWeight: semiBold,
            color: neutral90,
          ),
        )
      ],
    );
  }
}
