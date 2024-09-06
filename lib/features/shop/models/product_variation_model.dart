// DONE
class ProductVariationModel {
  final String id;
  String sku;
  int stock;
  double price;
  double salePrice;
  String image;
  String? description;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.stock = 0,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.image = '',
    this.description = '',
    required this.attributeValues,
  });

  // Create empty func for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  // Convert ProductVariationModel to JSON
  toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'Price': price,
      'SalePrice': salePrice,
      'Image': image,
      'Description': description,
      'AttributeValues': attributeValues,
      'SKU': sku,
    };
  }

  // Convert JSON to ProductVariationModel
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      attributeValues: Map<String, String>.from(data['AttributeValues']),
    );
  }
}
