// lib/screens/payment_screen.dart

import 'package:buy_it_app/widgets/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String billingName;
  final String billingEmail;
  final String billingPhone;
  final String billingAddress;
  final String billingCity;
  final String billingState;
  final String billingZipCode;
  final String shippingName;
  final String shippingEmail;
  final String shippingPhone;
  final String shippingAddress;
  final String shippingCity;
  final String shippingState;
  final String shippingZipCode;
  final double totalAmount;

  const PaymentScreen({
    super.key,
    required this.billingName,
    required this.billingEmail,
    required this.billingPhone,
    required this.billingAddress,
    required this.billingCity,
    required this.billingState,
    required this.billingZipCode,
    required this.shippingName,
    required this.shippingEmail,
    required this.shippingPhone,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingZipCode,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Payment',
        isTitleCentered: true,
        showBackButton: true,
      ),
      body: Center(
        child: Text(
          'Payment Screen\nTotal Amount: €${totalAmount.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
