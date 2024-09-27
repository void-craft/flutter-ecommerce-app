import 'package:bagit/features/personalization/models/address_model.dart';
import 'package:bagit/features/shop/models/cart_item_model.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.address,
    this.deliveryDate,
  });

  // Formatted order and delivery dates using helper functions
  String get formattedOrderDate =>
      CustomHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? CustomHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  // Text representation of the order status based on enum value
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  // Convert model to JSON structure for storing data in Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'OrderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Factory method to create an OrderModel from a Firebase document snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
        id: data['id'] as String,
        userId: data['userId'] as String,
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['status']),
        totalAmount: data['totalAmount'] as double,
        orderDate: (data['orderDate'] as Timestamp).toDate(),
        paymentMethod: data['paymentMethod'] as String,
        address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
        deliveryDate: data['deliveryDate'] == null
            ? null
            : (data['deliveryDate'] as Timestamp).toDate(),
        items: (data['items'] as List<dynamic>)
            .map((itemData) =>
                CartItemModel.fromJson(itemData as Map<String, dynamic>))
            .toList());
  }
}
