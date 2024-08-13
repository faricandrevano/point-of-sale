class ProductModel {
  ProductModel(
      {required this.productName,
      required this.category,
      required this.price,
      required this.sku,
      required this.description,
      this.images,
      this.id});
  final String? id;
  final String productName;
  final String sku;
  final double price;
  final String category;
  final String description;
  final List<String>? images;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      images: json['images'],
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
