class ProductModel {
  ProductModel({
    required this.productName,
    required this.category,
    required this.price,
    required this.sku,
    required this.description,
  });
  final String productName;
  final String sku;
  final double price;
  final String category;
  final String description;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['productName'],
      category: json['category'],
      price: json['price'],
      sku: json['sku'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'category': category,
      'price': price,
      'sku': sku,
      'description': description,
    };
  }
}
