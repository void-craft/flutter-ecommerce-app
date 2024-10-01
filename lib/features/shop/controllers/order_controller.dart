import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/common/widgets/success_scren/success_screen.dart';
import 'package:bagit/data/repositories/authentication/authentication_repository.dart';
import 'package:bagit/data/repositories/order_repository.dart';
import 'package:bagit/features/personalization/controllers/address_controller.dart';
import 'package:bagit/features/shop/controllers/checkout_controller.dart';
import 'package:bagit/features/shop/controllers/product/cart_controller.dart';
import 'package:bagit/features/shop/models/order_model.dart';
import 'package:bagit/navigation_menu.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  // Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      CustomLoaders.warningSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    }
  }

  // Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      CustomFullscreenLoader.openLoadingDialog(
          'Processing your order', CustomImages.processingIllustration);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
          // Generate a unique ID for the order
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          // Set Date as needed
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList());

      // Save the order to firestore
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      // Show success screen
      Get.off(() => SuccessScreen(
          image: CustomImages.orderCompleteIllustration,
          title: 'Payment Success!',
          subtitle: 'Your order will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu())));
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    }
  }
}
