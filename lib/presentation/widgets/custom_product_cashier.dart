import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomProductCashier extends StatelessWidget {
  const CustomProductCashier(
      {super.key,
      required this.img,
      required this.price,
      required this.title,
      this.onTap});
  final String img;
  final String title;
  final String price;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 202,
            width: 171,
            child: Image.network(img),
          ),
          const SizedBox(height: 12),
          Text(
            "Winter Collections",
            style: bodyM.copyWith(
              color: neutral60,
              fontWeight: regular,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: bodyL.copyWith(
              color: neutral90,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: bodyL.copyWith(
              color: neutral90,
              fontWeight: bold,
            ),
          )
        ],
      ),
    );
  }
}
