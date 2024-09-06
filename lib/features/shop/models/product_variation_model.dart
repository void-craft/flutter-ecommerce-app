class ProductVariationModel {
  final String id;
  final int stock;
  final double price;
  final double salePrice;
  final String image;
  final String description;
  final Map<String, List<String>> attributeValues; // Assuming attribute values are key-value pairs.

  ProductVariationModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.salePrice,
    required this.image,
    required this.description,
    required this.attributeValues, required String productType, required String variationType, required String value,
  });

  // Convert JSON to ProductVariationModel
  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] ?? '',
      stock: json['stock'] ?? 0,
      price: json['price']?.toDouble() ?? 0.0,
      salePrice: json['salePrice']?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      attributeValues: Map<String, List<String>>.from(json['attributeValues'] ?? {}), productType: '', variationType: '', value: '',
    );
  }

  // Convert ProductVariationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'price': price,
      'salePrice': salePrice,
      'image': image,
      'description': description,
      'attributeValues': attributeValues,
    };
  }
}
