class TransactionModel {
  const TransactionModel(
      {required this.customerName,
      required this.date,
      required this.id,
      required this.payment,
      required this.paymentMethod,
      required this.status,
      required this.tax});
  final String status, id, customerName, date, paymentMethod;
  final double payment, tax;
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        customerName: json['customerName'],
        date: json['date'],
        id: json['id'],
        payment: json['payment'],
        paymentMethod: json['paymentMethod'],
        status: json['status'],
        tax: json['tax']);
  }
}
