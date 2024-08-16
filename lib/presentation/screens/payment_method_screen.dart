import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:pos/data/models/transaction_model.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/router/named_route.dart';
import 'package:pos/utils/currency_formatter.dart';
import 'package:pos/utils/flutter_notification.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen(
      {super.key,
      required this.total,
      required this.customerName,
      required this.tax});
  final double total;
  final double tax;
  final String customerName;
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedOption = 0;
  String textSelected = '';
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: 'BANK TRANSFER',
              ),
              Tab(
                text: 'E-WALLET',
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              physics: const ScrollPhysics(),
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      runSpacing: 40,
                      children: [
                        CustomListTile(
                          img: 'assets/images/bank/bca.png',
                          label: 'BCA',
                          value: 1,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "BCA";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/bank/bni.png',
                          label: 'BNI',
                          value: 2,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "BNI";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/bank/bri.png',
                          label: 'BRI',
                          value: 3,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "BRI";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/bank/cimb.png',
                          label: 'CIMB',
                          value: 4,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "CIMB";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/bank/btn.png',
                          label: 'BTN',
                          value: 5,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "BTN";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/bank/mandiri.png',
                          label: 'MANDIRI',
                          value: 6,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "MANDIRI";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/bank/jago.png',
                          label: 'JAGO',
                          value: 7,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "JAGO";
                              selectedOption = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      runSpacing: 40,
                      children: [
                        CustomListTile(
                          img: 'assets/images/ewallet/dana.png',
                          label: 'DANA',
                          value: 1,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "DANA";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/ewallet/flip.png',
                          label: 'FLIP',
                          value: 2,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "FLIP";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/ewallet/ovo.png',
                          label: 'OVO',
                          value: 3,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "OVO";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/ewallet/paypal.png',
                          label: 'PAYPAL',
                          value: 4,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "PAYPAL";
                              selectedOption = value!;
                            });
                          },
                        ),
                        CustomListTile(
                          img: 'assets/images/ewallet/shopeepay.png',
                          label: 'SHOPEE PAY',
                          value: 5,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              textSelected = "SHOPEE PAY";
                              selectedOption = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 140,
        color: Colors.transparent,
        child: SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change",
                    style: bodyL.copyWith(
                      color: neutral90,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    RupiahTextInputFormatter.format(widget.total),
                    style: bodyXXL.copyWith(
                      color: neutral90,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomFilledButton(
                label: 'Pay Now',
                onPressed: () async {
                  context.push(NamedRoute.routeSuccessPayment);
                  context.read<TransactionBloc>().add(TransactionAdded(
                      TransactionModel(
                          customerName: widget.customerName,
                          date: DateTime.now().toString(),
                          id: (Random().nextInt(99) * 99).toString(),
                          paymentMethod: textSelected,
                          status: "SUCCESS",
                          tax: widget.tax,
                          total: widget.total)));
                  await HelperNotification.flutterLocalNotificationsPlugin.show(
                    Random().nextInt(99),
                    'Success Checkout Order',
                    'Proses Checkout Order',
                    HelperNotification.notificationDetails,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  const CustomListTile(
      {super.key,
      required this.img,
      required this.label,
      required this.value,
      required this.onChanged,
      required this.groupValue});
  final String img;
  final String label;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Image.asset(widget.img),
      title: Text(
        widget.label,
        style: bodyXL.copyWith(
          color: neutral90,
          fontWeight: semiBold,
        ),
      ),
      onLongPress: () {
        widget.onChanged(widget.value);
      },
      trailing: Radio(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
