import 'dart:io';
import 'package:bagit/features/shop/models/banner_model.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
import 'package:bagit/utils/exceptions/format_exceptions.dart';
import 'package:bagit/utils/exceptions/platform_exceptions.dart';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// DONE
class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> uploadBanner({required File imageFile}) async {
    try {
      // Ensure user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        CustomLoaders.errorSnackbar(title: 'Error', message: 'User is not authenticated.');
        return;
      }

      // Create a unique file name and upload the image
      String fileName = 'banners/${DateTime.now().millisecondsSinceEpoch}.png';
      UploadTask uploadTask = _storage.ref(fileName).putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        // Get download URL and save it in Firestore
        String downloadURL = await snapshot.ref.getDownloadURL();
        final banner = BannerModel(
          imageUrl: downloadURL,
          targetScreen: '/home',
          active: true,
        );
        await _db.collection('banners').add(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
