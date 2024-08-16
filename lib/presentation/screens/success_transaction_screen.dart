import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos/router/named_route.dart';
import 'package:printing/printing.dart';

class SuccessTransactionScreen extends StatefulWidget {
  const SuccessTransactionScreen({super.key});

  @override
  State<SuccessTransactionScreen> createState() =>
      _SuccessTransactionScreenState();
}

class _SuccessTransactionScreenState extends State<SuccessTransactionScreen> {
  Future<List<Map<String, dynamic>>> _fetchItems() async {
    // Simulasi pengambilan data dari API atau database
    await Future.delayed(Duration(seconds: 2));
    return [
      {"name": "Apel", "qty": 2, "price": 5000},
      {"name": "Roti", "qty": 1, "price": 15000},
      {"name": "Susu", "qty": 3, "price": 7000},
    ];
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    final items = await _fetchItems();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Struk Belanja',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Tanggal: ${DateTime.now().toString().split(' ')[0]}'),
              pw.SizedBox(height: 20),
              _createTable(items),
              pw.SizedBox(height: 20),
              pw.Text('Total Belanja: Rp${_calculateTotal(items)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _createTable(List<Map<String, dynamic>> items) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Produk',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Jumlah',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Harga',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
        ...items.map((item) => pw.TableRow(
              children: [
                pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Text(item['name'])),
                pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Text(item['qty'].toString())),
                pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Text('Rp${item['price']}')),
              ],
            )),
      ],
    );
  }

  int _calculateTotal(List<Map<String, dynamic>> items) {
    return items.fold(0, (sum, item) => (item['qty'] * item['price']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Column(
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: Image.asset('assets/icons/icon_success.png'),
              ),
              const SizedBox(height: 12),
              Text(
                "Payment Success",
                style: bodyL.copyWith(
                  fontWeight: bold,
                  color: neutral60,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Rp 30000",
                style: headingM.copyWith(
                  color: neutral90,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Divider(color: neutral30),
          ),
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Text(
                  "Payment Method",
                  style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                ),
                trailing: Text(
                  "QRIS",
                  style: bodyL.copyWith(color: neutral90, fontWeight: semiBold),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Text(
                  "Status",
                  style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                ),
                trailing: Container(
                  width: 73,
                  alignment: Alignment.center,
                  height: 28,
                  decoration: BoxDecoration(
                    color: successSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Success",
                    style: bodyM.copyWith(
                      color: const Color(0xff36B37E),
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Text(
                  "Transaction ID",
                  style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                ),
                trailing: Text(
                  "0912819472978378",
                  style: bodyL.copyWith(color: neutral90, fontWeight: semiBold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Divider(color: neutral30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "T-Men's UA Storm Armour Down 2.0 Sweater",
                          style: bodyL.copyWith(
                              color: neutral90, fontWeight: regular),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "1 X 1,000",
                          style: bodyL.copyWith(
                              color: neutral90, fontWeight: regular),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Rp 200000",
                    style:
                        bodyL.copyWith(color: neutral100, fontWeight: semiBold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 0),
                child: Divider(color: neutral30),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Text(
                  "Subtotal",
                  style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                ),
                trailing: Text(
                  "Rp 300000",
                  style:
                      bodyL.copyWith(color: neutral100, fontWeight: semiBold),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Text(
                  "Tax",
                  style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                ),
                trailing: Text(
                  "Rp 10000",
                  style:
                      bodyL.copyWith(color: neutral100, fontWeight: semiBold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Divider(color: neutral30),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Text(
                  "Total",
                  style: bodyL.copyWith(color: neutral90, fontWeight: regular),
                ),
                trailing: Text(
                  "Rp 10000",
                  style:
                      bodyL.copyWith(color: neutral100, fontWeight: semiBold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          CustomFilledButton(
            onPressed: () {
              _generatePdf(context);
            },
            label: 'Print Receipt',
            alignment: IconAlignment.start,
            icon: Icon(
              Icons.print,
              color: neutral20,
            ),
          ),
          const SizedBox(height: 10),
          CustomFilledButton(
            label: "Ok, back to cashier",
            onPressed: () {
              context.go(NamedRoute.routeCashier);
            },
          )
        ],
      ),
    );
  }
}
