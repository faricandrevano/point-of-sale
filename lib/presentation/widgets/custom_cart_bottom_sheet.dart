import 'package:flutter/material.dart';
import 'package:pos/data/models/cart_model.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/utils/currency_formatter.dart';

class CustomCartBottomSheet extends StatelessWidget {
  const CustomCartBottomSheet(
      {super.key, required this.items, required this.onPressed});
  final List<CartModel> items;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    double total = items.fold(0, (sum, item) => sum + (item.price * item.qty));
    int totalItem = items.fold(0, (sum, item) => sum + item.qty);
    // items.map((el) => data = {});
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: neutral40,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shopping Cart",
                      style: bodyL.copyWith(
                        color: neutral60,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      "${totalItem.toString()} Items",
                      style: bodyXL.copyWith(
                        color: neutral90,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                CustomFilledButton(
                  label: RupiahTextInputFormatter.format(total),
                  width: 180,
                  height: 48,
                  onPressed: onPressed,
                  alignment: IconAlignment.start,
                  icon: Icon(
                    Icons.shopify_outlined,
                    color: neutral20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
