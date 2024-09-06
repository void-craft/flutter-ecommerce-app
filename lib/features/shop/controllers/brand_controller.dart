import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/brand/brand_repository.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = false.obs;
  final _brandRepository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  // --- Load brand data
  Future<void> fetchBrands() async {
    try {
      // Show loader while loading brands
      isLoading.value = true;

      // Fetch brands from data source (Firestore, API, etc.)
      final brands = await _brandRepository.getAllBrands();

      // Update the brands list
      allBrands.assignAll(brands);

      // Filter the featured brands
      featuredBrands.assignAll(allBrands
          .where((brand) => brand.isFeatured)
          .take(8) // Adjust the number as needed
          .toList());
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  // --- Load selected brand data

  // --- Get brand details
}
