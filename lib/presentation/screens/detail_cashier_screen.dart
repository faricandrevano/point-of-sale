import 'package:flutter/material.dart';

class DetailCashierScreen extends StatelessWidget {
  const DetailCashierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Image.asset('assets/dummy/img_product1.png'),
        ],
      ),
    );
  }
}
