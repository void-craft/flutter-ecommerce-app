import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/brand/brand_repository.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = false.obs;
  final brandRepository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // --- Load featured brand data
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands
          .where((brand) => brand.isFeatured ?? false)
          .take(4));
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  // --- Load selected brand data

  // --- Get brand details
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
    final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId);
    return products;
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    }
  }
}
