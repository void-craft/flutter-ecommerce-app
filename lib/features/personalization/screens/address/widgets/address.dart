import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/personalization/controllers/address_controller.dart';
import 'package:bagit/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:bagit/features/personalization/screens/address/widgets/single_address.dart';
import 'package:bagit/utils/constants/colors.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressesScreen extends StatelessWidget {
  const UserAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
        appBar: CustomAppBar(
          showBackArrow: true,
          title: Text('Addressess',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Obx(() => FutureBuilder(
                    key: Key(controller.refreshData.value.toString()),
                    future: controller.getAllUserAddresses(),
                    builder: (context, snapshot) {
                      // Helper function: Handle loader, no record, or error message
                      final response =
                          CustomCloudHelperFunctions.checkMultipleRecordState(
                              snapshot: snapshot);
                      if (response != null) return response;

                      final addresses = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (_, index) => CustomSingleAddress(
                            address: addresses[index],
                            onTap: () =>
                                controller.selectAddress(addresses[index])),
                      );
                    })))),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(() => const AddNewAddressScreen()),
            backgroundColor: CustomColors.primary,
            child: const Icon(Iconsax.add, color: CustomColors.white)));
  }
}
