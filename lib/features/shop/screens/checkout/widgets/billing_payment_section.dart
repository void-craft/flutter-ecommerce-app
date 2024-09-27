import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/features/shop/controllers/checkout_controller.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBillingPaymentSection extends StatelessWidget {
  const CustomBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    final dark = CustomHelperFunctions.isDarkMode(context);
    return Column(children: [
      CustomSectionHeading(
        title: 'Payment Method',
        buttonTitle: 'Change',
        onPressed: () => controller.selectPaymentMethod(context),
      ),
      const SizedBox(height: CustomSizes.spaceBtwItems / 2),
      Obx(() => Row(children: [
            CustomRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? CustomColors.light : CustomColors.light,
                padding: const EdgeInsets.all(CustomSizes.sm),
                child: Image(
                    image: AssetImage(
                        controller.selectedPaymentMethod.value.image),
                    fit: BoxFit.contain)),
            const SizedBox(width: CustomSizes.spaceBtwItems / 2),
            Text(controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge)
          ]))
    ]);
  }
}
