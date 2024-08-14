import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/blocs/cart_bloc/cart_bloc.dart';
import 'package:pos/data/models/cart_model.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_textfield_auth.dart';
import 'package:pos/utils/currency_formatter.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
      ),
      body: ListView(
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
                onPressed: () {},
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
                  shrinkWrap: true,
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    return ItemCart(cart: state.cart[index]);
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          )
        ],
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
  @override
  Widget build(BuildContext context) {
    int quantity = widget.cart.qty;
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
                onPressed: () {},
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
