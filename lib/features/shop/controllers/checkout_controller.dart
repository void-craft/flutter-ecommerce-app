import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/models/payment_method_model.dart';
import 'package:bagit/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    // Default payment method set to PayPal
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: CustomImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    // Renamed the method to avoid conflict
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(CustomSizes.lg),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSectionHeading(
                        title: 'Select Payment Method',
                        showActionButton: false,
                      ),
                      const SizedBox(height: CustomSizes.spaceBtwSections),
                      CustomPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Paypal', image: CustomImages.paypal)),
                      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                      CustomPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Google Pay', image: CustomImages.gpay)),
                      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                      CustomPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Apple Pay', image: CustomImages.applepay)),
                      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                      CustomPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'MasterCard',
                              image: CustomImages.mastercard)),
                      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                      CustomPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Visa', image: CustomImages.visa)),
                      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                      CustomPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Credit Card',
                              image: CustomImages.creditcard)),
                      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                    ]))));
  }
}
