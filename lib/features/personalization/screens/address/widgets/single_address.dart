import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/features/personalization/controllers/address_controller.dart';
import 'package:bagit/features/personalization/models/address_model.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomSingleAddress extends StatelessWidget {
  const CustomSingleAddress(
      {super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = CustomHelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
          onTap: onTap,
          child: CustomRoundedContainer(
              padding: const EdgeInsets.all(CustomSizes.md),
              width: double.infinity,
              showBorder: true,
              backgroundColor: selectedAddress
                  ? CustomColors.primary.withOpacity(0.5)
                  : Colors.transparent,
              borderColor: selectedAddress
                  ? Colors.transparent
                  : dark
                      ? CustomColors.darkerGrey
                      : CustomColors.grey,
              margin: const EdgeInsets.only(bottom: CustomSizes.spaceBtwItems),
              child: Stack(children: [
                Positioned(
                    right: 5,
                    top: 0,
                    child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                        color: selectedAddress
                            ? dark
                                ? CustomColors.light
                                : CustomColors.dark.withOpacity(0.6)
                            : null)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: CustomSizes.sm / 2),
                  Text(address.formattedPhoneNo,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: CustomSizes.sm / 2),
                  Text(address.toString(),
                      softWrap: true)
                ])
              ])));
    });
  }
}
