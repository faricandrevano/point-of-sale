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
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'This month transaction',
                            style: bodyM.copyWith(
                              color: neutral50,
                              fontWeight: regular,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$3599.00",
                            style: headingM.copyWith(
                              fontWeight: bold,
                              color: neutral10,
                            ),
                          ),
                        ],
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
                  const CustomMenuDashboard(
                    img: 'assets/icons/icon_dashboard.png',
                    title: 'Report',
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
                  const CustomMenuDashboard(
                    img: 'assets/icons/icon_customers.png',
                    title: 'Customer',
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
