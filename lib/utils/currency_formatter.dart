import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RupiahTextInputFormatter extends TextInputFormatter {
  static final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Menghilangkan simbol mata uang dari value
    final numericString = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (numericString.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Memformat angka menjadi mata uang
    final value = int.tryParse(numericString) ?? 0;
    final formattedValue = _currencyFormatter.format(value);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  // Fungsi untuk mengubah nilai Rupiah menjadi double
  static double parse(String value) {
    // Menghilangkan simbol Rp dan semua karakter non-digit dan non-koma
    String cleanedString = value.replaceAll(RegExp(r'[^\d,]'), '');

    // Mengganti tanda koma dengan titik untuk pemisah desimal
    cleanedString = cleanedString.replaceAll(',', '.');

    // Mengubah string menjadi double
    final doubleValue = double.tryParse(cleanedString) ?? 0.0;

    return doubleValue;
  }

  static String format(double value) {
    final formattedValue = _currencyFormatter.format(value);
    return formattedValue;
  }
}
