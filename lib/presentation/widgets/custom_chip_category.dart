import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomChipCategory extends StatelessWidget {
  const CustomChipCategory(
      {super.key,
      required this.category,
      required this.total,
      required this.selected});
  final String category;
  final int total;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 139,
      height: 64,
      padding: const EdgeInsets.only(right: 16),
      child: InputChip(
        selected: selected,
        showCheckmark: false,
        selectedColor: selected ? primarySurface : null,
        side: BorderSide(color: selected ? primaryBorder : neutral20),
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.toString(),
              style: bodyXL.copyWith(
                fontWeight: bold,
                color: neutral90,
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: total.toString(),
                style: bodyM.copyWith(
                  color: neutral60,
                  fontWeight: regular,
                ),
                children: [
                  TextSpan(
                    text: ' Product',
                    style: bodyM.copyWith(
                      color: neutral60,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
