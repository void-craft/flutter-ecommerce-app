import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/features/shop/controllers/product/variation_controller.dart';
import 'package:bagit/features/shop/models/cart_item_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt productQuantityInCart = 0.obs;
  RxInt productQuantityInBag = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = Get.put(VariationController());

  CartController() {
    loadCartItems();
  }

  // Getter for the number of items in the cart
  int get noOfCartItems => cartItems.fold(0, (total, item) => total + item.quantity);

  // Getter for the total price of items in the cart
  double get totalCartPrice =>
      cartItems.fold(0.0, (total, item) => total + item.price * item.quantity);

  // Method to retrieve quantity of a specific product in the cart
  int getProductQuantity(String productId, {String? variationId}) {
    final item = cartItems.firstWhere(
      (item) =>
          item.productId == productId &&
          (variationId == null || item.variationId == variationId),
      orElse: () => CartItemModel.empty(),
    );
    return item.quantity;
  }

  // Method to add product to cart
  void addToCart(ProductModel product, int quantity) {
    if (quantity < 1) {
      CustomLoaders.customToast(message: "Select Quantity");
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      CustomLoaders.customToast(message: 'Select Variation');
      return;
    }

    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        CustomLoaders.warningSnackbar(
            title: 'Oh, snap!', message: 'Selected variation is out of stock.');
        return;
      } else if (product.stock < 1) {
        CustomLoaders.warningSnackbar(
            title: 'Oh, snap!', message: 'Selected product is out of stock.');
        return;
      }
    }

    final selectedCartItem = convertToCartItem(product, quantity);

    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);
    if (index >= 0) {
      cartItems[index].quantity += quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCartInFirebase();
    updateCart();
    CustomLoaders.customToast(message: 'Your product has been added to the cart.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        removeFromCartDialog(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        updateCartInFirebase();
        CustomLoaders.customToast(message: 'Product removed from the cart.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    productQuantityInCart.value = noOfCartItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    CustomLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        CustomLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  void clearCart() {
    productQuantityInBag.value = 0;
    cartItems.clear();
    updateCart();
  }

  void updateCartInFirebase() {
    const userId = 'currentUserId';
    final userCartRef =
        FirebaseFirestore.instance.collection('Users').doc(userId).collection('Cart');

    userCartRef.doc('cartData').set({
      'items': cartItems.map((item) => item.toJson()).toList(),
      'totalCount': noOfCartItems,
      'totalPrice': totalCartPrice,
    });
  }

  // Initialize already added Item's count in the cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      productQuantityInCart.value = variationId.isNotEmpty
          ? getVariationQuantityInCart(product.id, variationId)
          : 0;
    }
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  int getProductQuantityInCart(String productId) {
    return cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
  }

  // Method to save quantity to Firebase
  Future<void> saveSelectedQuantityToFirebase(String productId, int quantity) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Cart')
        .doc(productId)
        .set({'selectedQuantity': quantity}, SetOptions(merge: true));
  }

  // Method to retrieve saved quantity from Firebase
  Future<int> getSelectedQuantityFromFirebase(String productId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Cart')
        .doc(productId)
        .get();

    return doc.data()?['selectedQuantity'] ?? 0;
  }
}