import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.onPressed,
      required this.actionText,
      required this.body,
      required this.title});
  final VoidCallback onPressed;
  final String title, body, actionText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        width: 358,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 24,
                  decoration: BoxDecoration(
                    color: error,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: bodyXL.copyWith(
                    fontWeight: bold,
                    color: neutral90,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: Text(
                body,
                style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Cancel',
                      style: bodyL.copyWith(
                        color: primaryMain,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: error,
                    ),
                    onPressed: onPressed,
                    child: Text(
                      actionText,
                      style: bodyL.copyWith(
                        color: neutral10,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
