import 'package:bagit/common/widgets/appbar/appbar.dart';
import 'package:bagit/features/personalization/controllers/address_controller.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
        appBar: const CustomAppBar(
          showBackArrow: true,
          title: Text('Add new Address'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(CustomSizes.defaultSpace),
                child: Form(
                  key: controller.addressFormKey,
                    child: Column(
                      children: [
                  TextFormField(
                    controller: controller.name,
                    validator: (value) => CustomValidator.validateEmptyText('Name', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
                  const SizedBox(height: CustomSizes.spaceBtwInputFields),
                  TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number')),
                  const SizedBox(height: CustomSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31), labelText: 'Street')),
                      ),
                      const SizedBox(width: CustomSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code')),
                      )
                    ]
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building), labelText: 'City')),
                      ),
                      const SizedBox(width: CustomSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.activity), labelText: 'Region')),
                      )
                ]),
                const SizedBox(height: CustomSizes.spaceBtwInputFields),
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country')),
                const SizedBox(height: CustomSizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.addNewAddresses(), child: const Text('Save')))
                ])))));
  }
}
