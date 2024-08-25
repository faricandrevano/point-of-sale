import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/cart_bloc/cart_bloc.dart';
import 'package:pos/data/models/cart_model.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_dialog.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_textfield_auth.dart';
import 'package:pos/presentation/widgets/custom_toast.dart';
import 'package:pos/router/named_route.dart';
import 'package:pos/utils/currency_formatter.dart';
import 'package:toastification/toastification.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController customerController = TextEditingController();
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetProductCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Cart',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            context.read<CartBloc>().add(GetProductCart());
            toastMessage(
                context: context,
                description: state.messsage,
                type: ToastificationType.success);
          } else if (state is CartFailed) {
            context.read<CartBloc>().add(GetProductCart());
            toastMessage(
                context: context,
                description: state.error,
                type: ToastificationType.error);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartEmpty) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                CustomTextfieldAuth(
                  label: "Customer’s Name",
                  hintText: "Customer’s name",
                  controller: customerController,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: neutral50,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Cart List",
                          style: bodyL.copyWith(
                            fontWeight: semiBold,
                            color: neutral90,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            actionText: 'Delete',
                            body: 'Are you sure want to clear this cart?',
                            onPressed: () {
                              context.pop();
                              context.read<CartBloc>().add(CartItemEmpty());
                            },
                            title: 'Remove Product',
                          ),
                        );
                      },
                      child: Text(
                        "Clear",
                        style: bodyM.copyWith(
                          color: primaryMain,
                          fontWeight: semiBold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: neutral30),
                const SizedBox(height: 16),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.cart.length,
                        itemBuilder: (context, index) {
                          return ItemCart(cart: state.cart[index]);
                        },
                      );
                    }
                    return const CircleAvatar(
                        child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 25),
                Divider(color: neutral30),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      double total = state.cart.fold(
                          0, (sum, item) => sum + (item.price * item.qty));
                      double tax = total * 0.1;
                      return Wrap(
                        direction: Axis.horizontal,
                        runSpacing: 8,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Subtotal',
                                style: bodyL.copyWith(
                                  color: neutral60,
                                  fontWeight: regular,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                RupiahTextInputFormatter.format(total),
                                style: bodyL.copyWith(
                                  color: neutral90,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Tax',
                                style: bodyL.copyWith(
                                  color: neutral60,
                                  fontWeight: regular,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                RupiahTextInputFormatter.format(tax),
                                style: bodyL.copyWith(
                                  color: neutral90,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return const CircleAvatar(
                        child: CircularProgressIndicator());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Divider(
                    color: neutral30,
                  ),
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      double subtotal = state.cart.fold(
                          0, (sum, item) => sum + (item.price * item.qty));
                      double total = (subtotal * 0.1) + subtotal;
                      double tax = total * 0.1;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total",
                                style: bodyXL.copyWith(
                                  color: neutral90,
                                  fontWeight: semiBold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                RupiahTextInputFormatter.format(total),
                                style: bodyXL.copyWith(
                                  color: neutral90,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomFilledButton(
                            label: 'Place Order',
                            onPressed: () {
                              if (customerController.text.isEmpty) {
                                toastMessage(
                                    context: context,
                                    description:
                                        'Customer name tidak boleh kosong',
                                    type: ToastificationType.error);
                              } else {
                                context.push(NamedRoute.routePaymentScreen,
                                    extra: {
                                      'total': total,
                                      'tax': tax,
                                      'customerName': customerController.text
                                    });
                              }
                            },
                          )
                        ],
                      );
                    }
                    return const CircleAvatar(
                        child: CircularProgressIndicator());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ItemCart extends StatefulWidget {
  const ItemCart({super.key, required this.cart});
  final CartModel cart;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  late int quantity = widget.cart.qty;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.cart.productName,
                style: bodyL.copyWith(
                  fontWeight: medium,
                  color: neutral90,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      actionText: 'Delete',
                      body: 'Are you sure want to delete this product?',
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(CartItemRemove(widget.cart.id.toString()));

                        context.pop();
                      },
                      title: 'Remove Product',
                    ),
                  );
                },
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  backgroundColor: neutral10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: neutral30,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                icon: Icon(
                  Icons.delete_outline,
                  color: neutral90,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (quantity > 1) {
                      quantity--;
                    }
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      return context.read<CartBloc>().add(CartUpdateQty(
                          id: widget.cart.id.toString(), qty: quantity));
                    });
                  });
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
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    return context.read<CartBloc>().add(CartUpdateQty(
                        id: widget.cart.id.toString(), qty: quantity));
                  });
                },
                icon: const Icon(Icons.add_outlined),
              ),
              const Spacer(),
              Text(RupiahTextInputFormatter.format(widget.cart.price))
            ],
          ),
        ],
      ),
    );
  }
}
