import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/product_bloc/product_bloc.dart';
import 'package:pos/data/models/product_model.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/router/named_route.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.data});
  final ProductModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.read<ProductBloc>().add(ProductFetch());
            context.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Product',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.push(NamedRoute.routeProductUpdateScreen, extra: data);
            },
            child: Text(
              'Edit',
              style: bodyL.copyWith(
                color: primaryMain,
                fontWeight: semiBold,
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  child: Image.network(data.images![0]),
                ),
                const SizedBox(height: 16),
                Divider(color: neutral20),
                const SizedBox(height: 16),
                Wrap(
                  runSpacing: 16,
                  children: [
                    ListDescription(
                      label: 'Product Name',
                      desc: data.productName,
                    ),
                    ListDescription(
                      label: 'SKU',
                      desc: data.sku,
                    ),
                    ListDescription(
                      label: 'Price',
                      desc: data.price.toString(),
                    ),
                    ListDescription(
                      label: 'Category',
                      desc: data.category,
                    ),
                    Divider(color: neutral20),
                    ListDescription(
                      dualLine: true,
                      label: 'Description',
                      desc: data.description,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListDescription extends StatelessWidget {
  const ListDescription(
      {super.key,
      required this.label,
      required this.desc,
      this.dualLine = false});
  final String label, desc;
  final bool dualLine;
  @override
  Widget build(BuildContext context) {
    return dualLine
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: bodyL.copyWith(
                  fontWeight: semiBold,
                  color: neutral90,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: bodyL.copyWith(
                  color: neutral90,
                  fontWeight: regular,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: bodyL.copyWith(
                  fontWeight: semiBold,
                  color: neutral90,
                ),
              ),
              SizedBox(
                width: 208,
                child: Text(
                  desc,
                  style: bodyL.copyWith(
                    color: neutral90,
                    fontWeight: regular,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          );
  }
}
