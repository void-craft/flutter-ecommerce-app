import 'package:bagit/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class CustomCouponCode extends StatelessWidget {
  const CustomCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);

    return CustomRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? CustomColors.dark : CustomColors.white,
      padding: const EdgeInsets.only(top: CustomSizes.sm, bottom: CustomSizes.sm, right: CustomSizes.sm, left: CustomSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here.',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              )
            )
          ),
          // -- Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark ? CustomColors.white.withOpacity(0.5) : CustomColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1))
              ),
              child: const Text('Apply')
            )
          )
        ],
      ),
    );
  }
}
