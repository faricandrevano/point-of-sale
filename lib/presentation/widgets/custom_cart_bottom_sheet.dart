import 'package:flutter/material.dart';
import 'package:pos/data/models/cart_model.dart';

class CustomCartBottomSheet extends StatelessWidget {
  const CustomCartBottomSheet({super.key, required this.items});
  final List<CartModel> items;
  @override
  Widget build(BuildContext context) {
    double total = items.fold(0, (sum, item) => sum + (item.price * item.qty));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Cart Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('Total Items: ${items.length}'),
          Text('Total Price: \$${total.toStringAsFixed(2)}'),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Proceed to Checkout'),
            onPressed: () {
              // Implementasi checkout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Proceeding to checkout...')),
              );
            },
          ),
        ],
      ),
    );
  }
}
