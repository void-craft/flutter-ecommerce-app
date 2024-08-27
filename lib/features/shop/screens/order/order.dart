import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/shop/screens/order/widgets/orders_list.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -- AppBar
      appBar: CustomAppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(CustomSizes.defaultSpace),
        
        // -- Orders
        child: CustomOrderListItems(),
        )
    );
  }
}