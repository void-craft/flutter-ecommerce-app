import 'package:bagit/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:bagit/features/personalization/controllers/user_controller.dart';
import 'package:bagit/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CustomFirebaseStorageService());
    Get.put(UserController());
  }
}