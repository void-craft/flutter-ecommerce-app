import 'package:bagit/common/widgets/loaders/circular_loader.dart';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/common/widgets/texts/section_heading.dart';
import 'package:bagit/data/repositories/address/address_repository.dart';
import 'package:bagit/features/personalization/models/address_model.dart';
import 'package:bagit/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:bagit/features/personalization/screens/address/widgets/single_address.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/constants/sizes.dart';
import 'package:bagit/utils/helpers/cloud_helper_functions.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  // Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CustomCircularLoader());
      // Clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the selected field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error Selecting', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      // Start loading
      CustomFullscreenLoader.openLoadingDialog(
          'Storing Address..', CustomImages.lottieLoadingllustration);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      // Save address data
      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: city.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);
      final id = await addressRepository.addAddress(address);

      // Update selected address status
      address.id = id;
      selectedAddress(address);

      // Remove loader
      CustomFullscreenLoader.stopLoading();

      // Show success message
      CustomLoaders.successSnackbar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully.');

      // Refresh addresses data
      refreshData.toggle();

      // Resrt fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackbar(
          title: 'Error Selecting', message: e.toString());
    }
  }

  // Show addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
            padding: const EdgeInsets.all(CustomSizes.lg),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CustomSectionHeading(
                  title: 'Select Address', showActionButton: false),
              FutureBuilder(
                  future: getAllUserAddresses(),
                  builder: (_, snapshot) {
                    final response =
                        CustomCloudHelperFunctions.checkMultipleRecordState(
                            snapshot: snapshot);
                    if (response != null) return response;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => CustomSingleAddress(
                            address: snapshot.data![index],
                            onTap: () async {
                              selectedAddress(snapshot.data![index]);
                              Get.back();
                            }));
                  }),
              const SizedBox(height: CustomSizes.defaultSpace * 2),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          Get.to(() => const AddNewAddressScreen()),
                      child: const Text('Add New Address')))
            ])));
  }

  // Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
