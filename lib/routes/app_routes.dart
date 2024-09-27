import 'package:bagit/features/authentication/screens/login/login.dart';
import 'package:bagit/features/authentication/screens/onboarding/onboarding.dart';
import 'package:bagit/features/authentication/screens/password/forgot_password.dart';
import 'package:bagit/features/authentication/screens/signup/signup.dart';
import 'package:bagit/features/authentication/screens/signup/verify_email.dart';
import 'package:bagit/features/personalization/screens/address/widgets/address.dart';
import 'package:bagit/features/personalization/screens/profile/profile.dart';
import 'package:bagit/features/personalization/screens/settings/settings.dart';
import 'package:bagit/features/shop/screens/cart/cart.dart';
import 'package:bagit/features/shop/screens/checkout/checkout.dart';
import 'package:bagit/features/shop/screens/favorites/favorites.dart';
import 'package:bagit/features/shop/screens/home/home.dart';
import 'package:bagit/features/shop/screens/order/order.dart';
import 'package:bagit/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:bagit/features/shop/screens/store/store.dart';
import 'package:bagit/features/shop/screens/upload_product/dummy.dart';
import 'package:bagit/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: CustomRoutes.cart, page: () => const HomeScreen()),
    GetPage(name: CustomRoutes.store, page: () => const StoreScreen()),
    GetPage(name: CustomRoutes.favorites, page: () => const FavoriteScreen()),
    GetPage(name: CustomRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: CustomRoutes.productReviews, page: () => const ProductReviewScreen()),
    GetPage(name: CustomRoutes.order, page: () => const OrderScreen()),
    GetPage(name: CustomRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: CustomRoutes.cart, page: () => const CartScreen()),
    GetPage(name: CustomRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: CustomRoutes.userAddress, page: () => const UserAddressesScreen()),
    GetPage(name: CustomRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: CustomRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: CustomRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: CustomRoutes.forgetPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: CustomRoutes.onboarding, page: () => const OnBoardingScreen()),
    GetPage(name: CustomRoutes.dummyScreen, page: () => const UploadProductScreen()),
  ];
}