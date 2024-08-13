import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/product_bloc/product_bloc.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_dialog.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_product_list.dart';
import 'package:pos/presentation/widgets/custom_search_bar.dart';
import 'package:pos/presentation/widgets/custom_toast.dart';
import 'package:pos/router/named_route.dart';
import 'package:toastification/toastification.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.push(NamedRoute.routeHome),
          child: const Icon(Icons.arrow_back),
        ),
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
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductSuccess && state.event is ProductDelete) {
              context.read<ProductBloc>().add(ProductFetch());
              toastMessage(
                  context: context,
                  description: state.message,
                  type: ToastificationType.success);
            } else if (state is ProductFailed) {
              context.read<ProductBloc>().add(ProductFetch());
              toastMessage(
                  context: context,
                  description: state.error,
                  type: ToastificationType.error);
            }
          },
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
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      return ListView.builder(
                        itemCount: state.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomProductList(
                            category: state.data[index].category,
                            img: state.data[index].images![0],
                            price: state.data[index].price,
                            stock: 102,
                            title: state.data[index].productName,
                            delete: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                  actionText: 'Delete',
                                  body:
                                      'Are you sure want to delete this product?',
                                  onPressed: () {
                                    context.read<ProductBloc>().add(
                                          ProductDelete(
                                            id: state.data[index].id.toString(),
                                            sku: state.data[index].sku
                                                .toString(),
                                          ),
                                        );
                                  },
                                  title: 'Remove Product',
                                ),
                              );
                            },
                            editPrice: () {},
                            editStock: () {},
                            onTap: () => context.push(
                              NamedRoute.routeDetailProductScreen,
                              extra: state.data[index],
                            ),
                          );
                        },
                      );
                    } else if (state is ProductEmpty) {
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
                // Column(
                //   children: [
                //     CustomProductList(
                //       category: 'Shirt',
                //       img: 'assets/dummy/img_product1.png',
                //       price: 32.000,
                //       stock: 102,
                //       title: "T-Men's UA Storm Armour Down 2.0 Sweater",
                //       delete: () {},
                //       editPrice: () {},
                //       editStock: () {},
                //     ),
                //     const SizedBox(height: 17),
                //     CustomProductList(
                //       category: 'Shirt',
                //       img: 'assets/dummy/img_product2.png',
                //       price: 68.000,
                //       stock: 322,
                //       title: "Windproof Handbell Oversized Long Coat",
                //       delete: () {},
                //       editPrice: () {},
                //       editStock: () {},
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
