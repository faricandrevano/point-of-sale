import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';

class DetailCashierScreen extends StatefulWidget {
  const DetailCashierScreen({super.key});

  @override
  State<DetailCashierScreen> createState() => _DetailCashierScreenState();
}

class _DetailCashierScreenState extends State<DetailCashierScreen> {
  String? selectedSize;
  Color? selectedColor;
  int quantity = 1;

  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  final List<Color> colors = [
    Colors.pink,
    Colors.grey,
    Colors.orange,
    Colors.black
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset('assets/dummy/img_product1.png'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 4,
                  blurRadius: 15,
                  offset: Offset(0, 16),
                )
              ],
              color: neutral10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Women's Grey T-Shirt",
                  style: headingS.copyWith(
                    color: neutral90,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Size',
                  style: bodyM.copyWith(
                    fontWeight: bold,
                    color: neutral90,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: sizes
                      .map((size) => InputChip(
                            label: Text(size),
                            selected: selectedSize == size,
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedSize = selected ? size : null;
                              });
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  "Color",
                  style: bodyM.copyWith(
                    fontWeight: bold,
                    color: neutral90,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: colors
                      .map(
                        (color) => InputChip(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          side: selectedColor == color
                              ? BorderSide(color: neutral60)
                              : BorderSide.none,
                          labelPadding: const EdgeInsets.all(0),
                          showCheckmark: false,
                          selected: selectedColor == color,
                          onSelected: (selected) {
                            setState(() {
                              selectedColor = selected ? color : null;
                            });
                          },
                          selectedColor: Colors.transparent,
                          label: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: color,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 17),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp 23.400,00',
                      style:
                          headingS.copyWith(color: neutral90, fontWeight: bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: neutral30,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              quantity--;
                            },
                            icon: const Icon(Icons.remove_outlined),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(quantity.toString()),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: const Icon(Icons.add_outlined),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                CustomFilledButton(
                  label: 'Add to cart',
                  onPressed: () {},
                  alignment: IconAlignment.start,
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: neutral10,
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
