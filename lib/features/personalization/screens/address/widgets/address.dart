import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:bagit/features/personalization/screens/address/widgets/single_address.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressesScreen extends StatelessWidget {
  const UserAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => Get.to(() => const AddNewAddress()),
      backgroundColor: CustomColors.primary,
      child: const Icon(Iconsax.add, color: CustomColors.white),
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text('Addressess', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            children: [
              CustomSingleAddress(selectedAddress: false),
              CustomSingleAddress(selectedAddress: true)
            ]
          ))
      )
    );
  }
}