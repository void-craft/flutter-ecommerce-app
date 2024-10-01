class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.title = '',
    this.image,
    this.brandName,
    this.price = 0.0,
    this.selectedVariation,
  });

  // Empty cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  // Convert model to JSON structure for storing data.
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'variationId': variationId,
      'quantity': quantity,
      'title': title,
      'image': image,
      'brandName': brandName,
      'price': price,
      'selectedVariation': selectedVariation,
    };
  }

  // Factory method to create a CartItemModel from JSON data.
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      variationId: json['variationId'],
      quantity: json['quantity'],
      title: json['title'],
      image: json['image'],
      brandName: json['brandName'],
      price: json['price']?.toDouble(),
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}
