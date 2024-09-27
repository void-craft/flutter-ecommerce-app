import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/features/shop/controllers/checkout_controller.dart';
import 'package:bagit/features/shop/models/payment_method_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPaymentTile extends StatelessWidget {
  const CustomPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: CustomRoundedContainer(
        width: 40,
        height: 40,
        backgroundColor: CustomHelperFunctions.isDarkMode(context)
            ? CustomColors.light
            : CustomColors.white,
        padding: const EdgeInsets.all(CustomSizes.sm),
        child:
            Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Icons.arrow_right, size: 34),
    );
  }
}
