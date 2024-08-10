import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_chip_category.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_product_cashier.dart';
import 'package:pos/router/named_route.dart';

class CashierScreen extends StatelessWidget {
  const CashierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Cashier',
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
              Container(
                color: neutral20,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                    'Category',
                    style: bodyXXL.copyWith(
                      color: neutral90,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 64,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CustomChipCategory(
                      category: 'All',
                      selected: true,
                      total: 1232,
                    ),
                    CustomChipCategory(
                      category: 'Shirt',
                      selected: false,
                      total: 132,
                    ),
                    CustomChipCategory(
                      category: 'Clothing ',
                      selected: false,
                      total: 132,
                    ),
                    CustomChipCategory(
                      category: 'Electronics',
                      selected: false,
                      total: 132,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
                    label: 'Filter',
                    width: 99,
                    height: 40,
                    color: neutral10,
                    textColor: neutral90,
                    alignment: IconAlignment.end,
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list,
                      color: neutral90,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 22),
              GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                childAspectRatio: 0.5,
                crossAxisSpacing: 16,
                crossAxisCount: 2,
                physics: const ScrollPhysics(),
                children: [
                  CustomProductCashier(
                    img: 'assets/dummy/img_product1.png',
                    price: 'Rp 32.000',
                    title: "Women's Turtleneck Sweater",
                    onTap: () =>
                        context.push(NamedRoute.routeDetailProductCashier),
                  ),
                  const CustomProductCashier(
                    img: 'assets/dummy/img_product2.png',
                    price: 'Rp 32.000',
                    title: "Women's Knitted Top",
                  ),
                  const CustomProductCashier(
                    img: 'assets/dummy/img_product1.png',
                    price: 'Rp 32.000',
                    title: "Women's Turtleneck Sweater",
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
