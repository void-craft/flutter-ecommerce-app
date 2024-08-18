import 'package:get/get.dart';

class Controller extends GetxController {
  static Controller get instance => Get.find();

  var currentIndex = 0.obs; // Observable to track the current index

  // Method to update the current index when a page scrolls
  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  // Method to handle page navigation via dots (like in a PageIndicator)
  void onDotClicked(int index) {
    currentIndex.value = index;
    jumpToPage(index);
  }

  // Method to jump to the next page
  void nextPage() {
    if (currentIndex.value < totalPageCount - 1) {
      currentIndex.value++;
      jumpToPage(currentIndex.value);
    }
  }

  // Method to jump to the last page
  void lastPage() {
    currentIndex.value = totalPageCount - 1;
    jumpToPage(currentIndex.value);
  }

  // Method to jump to a specific page
  void jumpToPage(int page) {
    // Add your page controller logic here
    // Example: pageController.jumpToPage(page);
  }

  // Define total page count
  int get totalPageCount => 5; // Update this to your actual page count
}
