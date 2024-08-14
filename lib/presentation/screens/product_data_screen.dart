import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/product_bloc/product_bloc.dart';
import 'package:pos/data/models/product_model.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_multi_image.dart';
import 'package:pos/presentation/widgets/custom_toast.dart';
import 'package:pos/router/named_route.dart';
import 'package:pos/utils/currency_formatter.dart';
import 'package:toastification/toastification.dart';

class ProductDataScreen extends StatefulWidget {
  const ProductDataScreen({super.key, this.product});
  final ProductModel? product;
  @override
  State<ProductDataScreen> createState() => _ProductDataScreenState();
}

class _ProductDataScreenState extends State<ProductDataScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController pricingController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  String selectedCategory = '';
  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.productName;
      skuController.text = widget.product!.sku;
      pricingController.text = widget.product!.price.toString();
      descController.text = widget.product!.description;
      selectedCategory = widget.product!.category;

      context.read<ProductBloc>().add(ProductFetchImage(widget.product!.sku));
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    skuController.dispose();
    pricingController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product != null ? 'Edit Product' : 'Add Product',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductSuccess) {
              toastMessage(
                  context: context,
                  description: state.message,
                  type: ToastificationType.success);
            } else if (state is ProductFailed) {
              toastMessage(
                  context: context,
                  description: state.error,
                  type: ToastificationType.error);
            } else if (state is ProductUploadData) {
              toastMessage(
                  context: context,
                  description: state.message,
                  type: ToastificationType.success);
              context.read<ProductBloc>().add(ProductFetch());
              context.go(NamedRoute.routeProduct);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Wrap(
              runSpacing: 14,
              children: [
                ColumnText(
                  controller: nameController,
                  desc:
                      "Do not exceed 20 characters when entering the product name.",
                  hint: "Enter product name",
                  label: "Product name",
                ),
                Divider(color: neutral20),
                ColumnText(
                  controller: skuController,
                  desc:
                      "SKU is a scannable barcode and is the unit of measure in which the stock of a product is managed.",
                  hint: "Enter SKU",
                  label: "SKU",
                ),
                Divider(color: neutral20),
                ColumnText(
                  controller: stockController,
                  hint: "Enter Stock",
                  label: "Stock",
                  desc: "Enter Stock Product",
                ),
                Divider(color: neutral20),
                ColumnText(
                  controller: pricingController,
                  hint: "000",
                  label: "Pricing",
                  number: true,
                ),
                Divider(color: neutral20),
                ColumnDropdown(
                  selected: selectedCategory.isEmpty ? null : selectedCategory,
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                  hintText: 'Select Category',
                  items: const ['Man', 'Woman'],
                  label: 'Category',
                  desc:
                      'Please select your product category from the list provided.',
                ),
                Divider(color: neutral20),
                widget.product == null
                    ? const CustomMultiImage()
                    : CustomMultiImage(
                        updateImage: widget.product!.images,
                      ),
                Divider(color: neutral20),
                ColumnText(
                  controller: descController,
                  label: 'Product description',
                  hint: 'Description',
                  desc:
                      'Set a description on product to detail your product and better visibility.',
                  multiLine: true,
                ),
                BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductLoading) {
                    return const CustomFilledButton(
                      loading: true,
                    );
                  }
                  return CustomFilledButton(
                    label: 'Save Product',
                    onPressed: () {
                      double price = RupiahTextInputFormatter.parse(
                          pricingController.text);
                      context.read<ProductBloc>().add(ProductAdded(
                            ProductModel(
                                productName: nameController.text,
                                category: selectedCategory,
                                price: price,
                                stock: int.parse(stockController.text),
                                sku: skuController.text,
                                description: descController.text),
                          ));
                    },
                    alignment: IconAlignment.start,
                    icon: Icon(
                      Icons.save,
                      color: neutral10,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColumnDropdown extends StatefulWidget {
  const ColumnDropdown(
      {super.key,
      required this.label,
      required this.items,
      required this.hintText,
      this.desc,
      required this.onChanged,
      required this.selected});
  final String label, hintText;
  final List<String> items;
  final String? desc;
  final String? selected;
  final ValueChanged onChanged;
  @override
  State<ColumnDropdown> createState() => _ColumnDropdownState();
}

class _ColumnDropdownState extends State<ColumnDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: bodyL.copyWith(
            fontWeight: semiBold,
            color: neutral90,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            widget.desc.toString(),
            style: bodyM.copyWith(
              color: neutral50,
              fontWeight: regular,
            ),
          ),
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            hoverColor: neutral90,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: neutral40,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
          ),
          hint: Text(widget.hintText),
          value: widget.selected,
          elevation: 0,
          items: widget.items
              .map(
                (el) => DropdownMenuItem(
                  value: el,
                  child: Text(el),
                ),
              )
              .toList(),
          onChanged: (value) {
            widget.onChanged(value);
          },
        )
      ],
    );
  }
}

class ColumnText extends StatelessWidget {
  const ColumnText({
    super.key,
    required this.controller,
    required this.label,
    this.desc,
    required this.hint,
    this.number = false,
    this.onChanged,
    this.multiLine = false,
  });
  final TextEditingController controller;
  final String label;
  final String? desc;
  final String hint;
  final bool number;
  final bool multiLine;
  final ValueChanged<dynamic>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: bodyL.copyWith(
            fontWeight: semiBold,
            color: neutral90,
          ),
        ),
        number == false
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  desc.toString(),
                  style: bodyM.copyWith(
                    color: neutral50,
                    fontWeight: regular,
                  ),
                ),
              )
            : const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          minLines: multiLine ? 3 : null,
          maxLines: null,
          keyboardType: number
              ? const TextInputType.numberWithOptions(decimal: true)
              : null,
          inputFormatters: number
              ? [
                  RupiahTextInputFormatter(),
                ]
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: bodyL.copyWith(color: neutral50),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: neutral40,
              ),
            ),
          ),
        )
      ],
    );
  }
}
