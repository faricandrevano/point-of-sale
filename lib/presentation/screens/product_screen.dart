import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_product_list.dart';
import 'package:pos/presentation/widgets/custom_search_bar.dart';
import 'package:pos/router/named_route.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 24,
                        decoration: BoxDecoration(
                          color: neutral90,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Product List',
                        style: bodyXXL.copyWith(
                          color: neutral90,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomFilledButton(
                    label: 'Add',
                    width: 99,
                    height: 40,
                    alignment: IconAlignment.start,
                    onPressed: () {
                      context.push(NamedRoute.routeProductDataScreen);
                    },
                    icon: Icon(
                      Icons.add,
                      color: neutral10,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const CustomSearchBar(),
              const SizedBox(height: 18),
              Column(
                children: [
                  CustomProductList(
                    category: 'Shirt',
                    img: 'assets/dummy/img_product1.png',
                    price: 32.000,
                    stock: 102,
                    title: "T-Men's UA Storm Armour Down 2.0 Sweater",
                    delete: () {},
                    editPrice: () {},
                    editStock: () {},
                  ),
                  const SizedBox(height: 17),
                  CustomProductList(
                    category: 'Shirt',
                    img: 'assets/dummy/img_product2.png',
                    price: 68.000,
                    stock: 322,
                    title: "Windproof Handbell Oversized Long Coat",
                    delete: () {},
                    editPrice: () {},
                    editStock: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
