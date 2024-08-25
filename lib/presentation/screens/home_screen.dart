import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_bar_chart.dart';
import 'package:pos/presentation/widgets/custom_menu_dashboard.dart';
import 'package:pos/router/named_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xff273040),
                image: DecorationImage(
                  image: AssetImage('assets/images/img_home.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Faric Andrevano",
                                  style: bodyXL.copyWith(
                                    fontWeight: bold,
                                    color: neutral10,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Bussiness owner",
                                  style: bodyL.copyWith(
                                    color: neutral50,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.notifications_on_outlined,
                              color: neutral10,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Container(
                        width: 96,
                        height: 30,
                        decoration: BoxDecoration(
                          color: neutral10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Transactions",
                          style: bodyM.copyWith(
                            fontWeight: semiBold,
                            color: neutral90,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 114,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: neutral50,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Product Sales",
                          style: bodyM.copyWith(
                            fontWeight: semiBold,
                            color: neutral50,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'This month transaction',
                              style: bodyM.copyWith(
                                color: neutral50,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp 190.000",
                                  style: headingM.copyWith(
                                    fontWeight: bold,
                                    color: neutral10,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: info,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: neutral10,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "20%",
                                        style: bodyM.copyWith(
                                          fontWeight: medium,
                                          color: neutral10,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox()
                    ],
                  ),
                  const SizedBox(
                    height: 190,
                    child: CustomBarChart(),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.5, vertical: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 24,
                crossAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildListDelegate(
                [
                  CustomMenuDashboard(
                    img: 'assets/icons/icon_dashboard.png',
                    title: 'Report',
                    onTap: () => context.push(NamedRoute.routeTransaction),
                  ),
                  CustomMenuDashboard(
                    img: 'assets/icons/icon_product.png',
                    title: 'Product',
                    onTap: () => context.push(NamedRoute.routeProduct),
                  ),
                  const CustomMenuDashboard(
                    img: 'assets/icons/icon_transaction.png',
                    title: 'Transcations',
                  ),
                  const CustomMenuDashboard(
                    img: 'assets/icons/icon_payment.png',
                    title: 'Payment',
                  ),
                  CustomMenuDashboard(
                    img: 'assets/icons/icon_customers.png',
                    title: 'Cart',
                    onTap: () => context.push(NamedRoute.routeCartScreen),
                  ),
                  CustomMenuDashboard(
                    img: 'assets/icons/icon_settings.png',
                    title: 'Setting',
                    onTap: () {
                      context.push(NamedRoute.routeSettings);
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 48,
                  margin: const EdgeInsets.only(
                    bottom: 30,
                    left: 25.5,
                    right: 25.5,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.push(NamedRoute.routeCashier);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryMain,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/icons/icons_gotocashier.png',
                      height: 20,
                    ),
                    label: Text(
                      'Go to Cashier',
                      style: bodyL.copyWith(
                        color: neutral10,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
