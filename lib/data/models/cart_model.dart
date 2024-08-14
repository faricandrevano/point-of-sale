class CartModel {
  const CartModel(
      {required this.productName,
      required this.price,
      required this.qty,
      required this.customerName,
      required this.id});
  final String productName, id;
  final int price;
  final int qty;
  final String customerName;
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productName: json['productName'],
      price: json['price'],
      qty: json['qty'],
      customerName: json['customerName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
      'qty': qty,
      'customerName': customerName
    };
  }
}
