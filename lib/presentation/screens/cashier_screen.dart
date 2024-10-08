import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/cart_bloc/cart_bloc.dart';
import 'package:pos/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_cart_bottom_sheet.dart';
import 'package:pos/presentation/widgets/custom_chip_category.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_product_cashier.dart';
import 'package:pos/presentation/widgets/custom_toast.dart';
import 'package:pos/router/named_route.dart';
import 'package:pos/utils/currency_formatter.dart';
import 'package:toastification/toastification.dart';
import 'package:pos/data/models/cart_model.dart';

class CashierScreen extends StatefulWidget {
  const CashierScreen({super.key});

  @override
  State<CashierScreen> createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CashierBloc>().add(CashierFetchProduct());
    context.read<CartBloc>().add(GetProductCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.push(NamedRoute.routeHome);
          },
          child: const Icon(Icons.arrow_back),
        ),
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
        child: MultiBlocListener(
          listeners: [
            BlocListener<CashierBloc, CashierState>(
              listener: (context, state) {
                if (state is CashierFailed) {
                  context.read<CashierBloc>().add(CashierFetchProduct());
                  toastMessage(
                      context: context,
                      description: state.error,
                      type: ToastificationType.error);
                }
              },
            ),
            BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartLoaded) {
                  _showModalBottomSheet(context, state.cart);
                }
              },
            ),
          ],
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
                BlocBuilder<CashierBloc, CashierState>(
                  builder: (context, state) {
                    if (state is CashierLoadedProduct) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.5,
                          crossAxisCount: 2,
                        ),
                        itemCount: state.product.length,
                        itemBuilder: (context, index) {
                          return CustomProductCashier(
                            stock: state.product[index].stock,
                            img: state.product[index].images![0],
                            price: RupiahTextInputFormatter.format(
                                state.product[index].price),
                            title: "Women's Turtleneck Sweater",
                            onTap: () => context.push(
                              NamedRoute.routeDetailProductCashier,
                              extra: state.product[index],
                            ),
                          );
                        },
                      );
                    } else if (state is CashierEmptyProduct) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/img_product_empty.png',
                              width: 300,
                            ),
                            const SizedBox(height: 130),
                            Text(
                              'You don’t have any product yet',
                              style: headingS.copyWith(
                                color: neutral90,
                                fontWeight: bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'You have successfully registered. Click button bellow to continue using the apps',
                              style: bodyL.copyWith(
                                color: neutral60,
                                fontWeight: regular,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 48),
                            CustomFilledButton(
                              label: 'Continue',
                              onPressed: () {},
                            )
                          ],
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, List<CartModel> items) {
    if (items.isNotEmpty) {
      showBottomSheet(
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          return CustomCartBottomSheet(
            items: items,
            onPressed: () => context.push(NamedRoute.routeCartScreen),
          );
        },
      );
    }
  }
}
