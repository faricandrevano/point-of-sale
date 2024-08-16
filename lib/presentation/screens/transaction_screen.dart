import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/blocs/product_bloc/product_bloc.dart';
import 'package:pos/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_search_bar.dart';
import 'package:pos/router/named_route.dart';
import 'package:pos/utils/currency_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(TransactionFetch());
  }

  @override
  void dispose() {
    super.dispose();
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
          'Transaction List',
          style: bodyXXL.copyWith(
            fontWeight: bold,
            color: neutral90,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            // if (state is ProductSuccess && state.event is ProductDelete) {
            //   context.read<ProductBloc>().add(ProductFetch());
            //   toastMessage(
            //       context: context,
            //       description: state.message,
            //       type: ToastificationType.success);
            // } else if (state is ProductFailed) {
            //   context.read<ProductBloc>().add(ProductFetch());
            //   toastMessage(
            //       context: context,
            //       description: state.error,
            //       type: ToastificationType.error);
            // }
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
                          'Transaction List',
                          style: bodyXXL.copyWith(
                            color: neutral90,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomFilledButton(
                      label: 'Print',
                      width: 99,
                      height: 40,
                      alignment: IconAlignment.start,
                      onPressed: () {
                        _generatePdf(context);
                      },
                      icon: Icon(
                        Icons.print,
                        color: neutral10,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const CustomSearchBar(),
                const SizedBox(height: 18),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoaded) {
                      return ListView.builder(
                        itemCount: state.data.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CustoTransactionList(
                            total: RupiahTextInputFormatter.format(
                                state.data[index].total),
                            customerName: state.data[index].customerName,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _generatePdf(BuildContext context) async {
  final pdf = pw.Document();

  // Tambahkan halaman ke dokumen PDF
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Sales Report',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
            pw.SizedBox(height: 20),
            _createTable(),
            pw.SizedBox(height: 20),
            pw.Text('Total Sales: \$1,500',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ],
        );
      },
    ),
  );

  // Tampilkan preview PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

pw.Widget _createTable() {
  return pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text('Product',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text('Quantity',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text('Price',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Padding(
              padding: pw.EdgeInsets.all(5), child: pw.Text('Product A')),
          pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text('5')),
          pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text('\$100')),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Padding(
              padding: pw.EdgeInsets.all(5), child: pw.Text('Product B')),
          pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text('3')),
          pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text('\$200')),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Padding(
              padding: pw.EdgeInsets.all(5), child: pw.Text('Product C')),
          pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text('2')),
          pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text('\$300')),
        ],
      ),
    ],
  );
}

class CustoTransactionList extends StatefulWidget {
  const CustoTransactionList({
    super.key,
    required this.total,
    required this.customerName,
  });
  final String customerName;

  final String total;
  @override
  State<CustoTransactionList> createState() => _CustoTransactionListState();
}

class _CustoTransactionListState extends State<CustoTransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide(color: neutral30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.customerName,
                      style: bodyL.copyWith(
                        color: neutral90,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      widget.total,
                      style: bodyL.copyWith(
                        color: neutral90,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
