import 'package:bagit/features/shop/models/cart_item_model.dart';
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
