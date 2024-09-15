import 'package:bagit/features/shop/models/cart_item_model.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final List<CartItemModel> items;
  final double totalAmount;
  final DateTime orderData;
  final DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderData,
    required this.deliveryDate,
  });

  // Convert model to JSON structure for storing data.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Status': status.toString().split('.').last, // Converts enum to String
      'Items': items.map((item) => item.toJson()).toList(),
      'TotalAmount': totalAmount,
      'OrderData': orderData.toIso8601String(),
      'DeliveryDate': deliveryDate.toIso8601String(),
    };
  }

  // Factory method to create an OrderModel from a Firebase document snapshot.
  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      List<CartItemModel> items = (data['Items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return OrderModel(
        id: data['Id'] ?? '',
        status: OrderStatus.values.firstWhere(
          (e) => e.toString().split('.').last == data['Status'],
          orElse: () => OrderStatus.processing, // Default value if status is not found
        ),
        items: items,
        totalAmount: data['TotalAmount']?.toDouble() ?? 0.0,
        orderData: DateTime.parse(data['OrderData']),
        deliveryDate: DateTime.parse(data['DeliveryDate']),
      );
    } else {
      return OrderModel(
        id: '',
        status: OrderStatus.processing, // Default status
        items: [],
        totalAmount: 0.0,
        orderData: DateTime.now(),
        deliveryDate: DateTime.now(),
      );
    }
  }
}
