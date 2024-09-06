import 'dart:io';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/features/shop/models/banner_model.dart';
import 'package:bagit/data/repositories/banners/banner_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

// DONE
class BannerController extends GetxController {
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    Get.put(BannerRepository());
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final fetchedBanners = await BannerRepository.instance.fetchBanners();
      banners.assignAll(fetchedBanners);
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadBanner() async {
    try {
      isLoading.value = true;

      // Check if the user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        CustomLoaders.errorSnackbar(title: 'Error', message: 'User is not authenticated.');
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        await BannerRepository.instance.uploadBanner(imageFile: imageFile);
        CustomLoaders.successSnackbar(title: 'Success', message: 'Banner uploaded successfully!');
      } else {
        CustomLoaders.errorSnackbar(title: 'Error', message: 'No image selected.');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Error', message: 'Error uploading banner: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
