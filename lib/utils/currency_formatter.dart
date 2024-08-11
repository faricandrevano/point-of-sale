import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RupiahTextInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormatter =
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
}
