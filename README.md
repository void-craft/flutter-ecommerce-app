# BagIt

**BagIt** is a feature-rich Flutter application designed for seamless online shopping. It leverages Firebase for both authentication and cloud backend services, ensuring a secure and scalable experience. The app is built with the GetX package for state management, providing an intuitive and responsive user interface. With features like onboarding screens, user authentication, and profile management, BagIt delivers a smooth and modern shopping experience.

## Features

- **User Authentication**: Register and log in using either Google or email/password authentication through Firebase.
- **Onboarding Experience**: Swipe through an onboarding screen on the first launch, with local storage ensuring it isn't shown again after the initial use.
- **Splash Screen**: Start the app with a splash screen before transitioning to the main interface.
- **Bottom Navigation**: Navigate seamlessly between the app’s core sections using a bottom navigation bar featuring Home, Profile, Store, and Favorites.
- **Product Listing**: Browse through product listings, including images, titles, descriptions, prices, and ratings.
- **Product Details**: Access detailed information about individual products.
- **Cart Management**: Add and manage items in a dedicated cart screen.
- **Favorites**: Save products to a favorites list for easy access.
- **Cart and Favorites Interaction**: Effortlessly move items between the cart and favorites.
- **Profile Management**: View and manage user profiles and addresses within the app.
- **State Management**: Leverage the GetX package for efficient state management and reactive programming.
- **Local Storage**: Utilize local storage to store user preferences, such as ensuring the onboarding screen doesn't repeat after the first time.
- **Loading Indicators**: Display progress indicators during data fetching for a smoother experience.
- **Error Handling**: Handle errors gracefully with appropriate user feedback.

## Technology Stack

- **Framework**: Dart and Flutter
- **State Management**: GetX
- **Backend and Cloud Services**: Firebase
- **Local Storage**: Shared Preferences (or similar for onboarding persistence)

## Getting Started

To set up and run the app locally, follow these steps:

1. **Clone the Repository**

    ```bash
    git clone https://github.com/your-username/bagit.git
    ```

2. **Navigate to the Project Directory**

    ```bash
    cd bagit
    ```

3. **Install Dependencies**

    ```bash
    flutter pub get
    ```

4. **Run the Application**

    ```bash
    flutter run
    ```

## Usage

- **Onboarding**: Swipe through the onboarding screens on your first app launch.
- **Authentication**: Register or log in using Google or email/password.
- **Navigation**: Use the bottom navigation bar to explore Home, Profile, Store, and Favorites.
- **Product Listing**: Browse and explore products with detailed information.
- **Cart**: Add items to your cart and manage them.
- **Favorites**: Save and manage your favorite products.
- **Move Items**: Easily move items between your favorites and cart.
- **Profile**: View and update your profile, including managing addresses.
