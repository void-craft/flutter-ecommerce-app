import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String cartId;
  final List<CartItemModel> items;

  CartModel({
    required this.cartId,
    required this.items,
  });

  // Convert model to JSON structure for storing data.
  Map<String, dynamic> toJson() {
    return {
      'CartId': cartId,
      'Items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Factory method to create a CartModel from a Firebase document snapshot.
  factory CartModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      List<CartItemModel> items = (data['Items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return CartModel(
        cartId: data['CartId'] ?? '',
        items: items,
      );
    } else {
      return CartModel(cartId: '', items: []);
    }
  }
}

class CartItemModel {
  final String productId;
  final String variationId;
  final int quantity;
  final String title;
  final String image;
  final String brandName;
  final double price;
  final Map<String, dynamic> selectedVariation;

  CartItemModel({
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.title,
    required this.image,
    required this.brandName,
    required this.price,
    required this.selectedVariation,
  });

  // Convert model to JSON structure for storing data.
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'VariationId': variationId,
      'Quantity': quantity,
      'Title': title,
      'Image': image,
      'BrandName': brandName,
      'Price': price,
      'SelectedVariation': selectedVariation,
    };
  }

  // Factory method to create a CartItemModel from JSON data.
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['ProductId'] ?? '',
      variationId: json['VariationId'] ?? '',
      quantity: json['Quantity'] ?? 0,
      title: json['Title'] ?? '',
      image: json['Image'] ?? '',
      brandName: json['BrandName'] ?? '',
      price: json['Price']?.toDouble() ?? 0.0,
      selectedVariation: json['SelectedVariation'] ?? {},
    );
  }
}
