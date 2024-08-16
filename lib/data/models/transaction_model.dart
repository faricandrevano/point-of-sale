class TransactionModel {
  const TransactionModel(
      {required this.customerName,
      required this.date,
      required this.id,
      required this.paymentMethod,
      required this.status,
      required this.tax,
      required this.total});
  final String status, id, customerName, date, paymentMethod;
  final double tax, total;
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        customerName: json['customerName'],
        date: json['date'],
        id: json['id'],
        total: json['total'],
        paymentMethod: json['paymentMethod'],
        status: json['status'],
        tax: json['tax']);
  }
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'date': date,
      'id': id,
      'paymentMethod': paymentMethod,
      'status': status,
      'tax': tax,
      'total': total
    };
  }
}
