import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomProductList extends StatefulWidget {
  const CustomProductList({
    super.key,
    required this.category,
    required this.img,
    required this.price,
    required this.stock,
    required this.title,
    required this.delete,
    required this.editPrice,
    required this.editStock,
  });
  final String category, title, img;
  final double stock, price;
  final VoidCallback editStock, editPrice, delete;
  @override
  State<CustomProductList> createState() => _CustomProductListState();
}

class _CustomProductListState extends State<CustomProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide(color: neutral30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 90,
                child: Image.asset(widget.img),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 58,
                      height: 24,
                      decoration: BoxDecoration(
                        color: neutral20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.category,
                        style: bodyS.copyWith(
                          color: neutral90,
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: bodyL.copyWith(
                        color: neutral90,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Stock :',
                            style: bodyL.copyWith(
                              color: neutral60,
                              fontWeight: regular,
                            ),
                            children: [
                              TextSpan(
                                text: widget.stock.toString(),
                                style: bodyL.copyWith(
                                  color: neutral90,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.price.toString(),
                          style: bodyL.copyWith(
                            color: neutral90,
                            fontWeight: bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 147,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.editStock,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neutral10,
                    elevation: 0,
                    side: BorderSide(
                      color: neutral30,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Edit Stock',
                    style: bodyL.copyWith(
                      fontWeight: semiBold,
                      color: neutral90,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 147,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.editPrice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neutral10,
                    elevation: 0,
                    side: BorderSide(
                      color: neutral30,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Edit Price',
                    style: bodyL.copyWith(
                      fontWeight: semiBold,
                      color: neutral90,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: widget.delete,
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  foregroundColor: error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: error,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                icon: const Icon(Icons.delete_sweep),
              )
            ],
          )
        ],
      ),
    );
  }
}
