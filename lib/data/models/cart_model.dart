class CartModel {
  const CartModel(
      {required this.productName,
      required this.price,
      required this.qty,
      this.id});
  final String productName;
  final String? id;
  final double price;
  final int qty;
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productName: json['productName'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
      'qty': qty,
    };
  }
}
