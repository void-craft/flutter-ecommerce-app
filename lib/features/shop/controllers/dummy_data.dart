// import 'package:bagit/features/personalization/models/address_model.dart';
// import 'package:bagit/features/personalization/models/user_model.dart';
// import 'package:bagit/features/shop/models/banner_model.dart';
// import 'package:bagit/features/shop/models/brand_category_model.dart';
// import 'package:bagit/features/shop/models/brand_model.dart';
// import 'package:bagit/features/shop/models/cart_model.dart';
// import 'package:bagit/features/shop/models/category_model.dart';
// import 'package:bagit/features/shop/models/order_model.dart';
// import 'package:bagit/features/shop/models/product_attribute_model.dart';
// import 'package:bagit/features/shop/models/product_category_model.dart';
// import 'package:bagit/features/shop/models/product_model.dart';
// import 'package:bagit/features/shop/models/product_variation_model.dart';
// import 'package:bagit/routes/routes.dart';
// import 'package:bagit/utils/constants/enums.dart';
// import 'package:bagit/utils/constants/image_strings.dart';

// class CustomDummyData {
//   // Static list of banner models
//   static final List<BannerModel> banners = [
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.order,
//         active: false),
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.cart,
//         active: true),
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.favorites,
//         active: true),
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.search,
//         active: true),
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.settings,
//         active: true),
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.userAddress,
//         active: true),
//     BannerModel(
//         imageUrl: CustomImages.user,
//         targetScreen: CustomRoutes.checkout,
//         active: false),
//   ];

//   // User
//   static final UserModel user = UserModel(
//     firstName: "Void",
//     firstSurname: "Craft",
//     lastSurname: "Tech",
//     phoneNumber: '+34000000000',
//     profilePicture: CustomImages.user,
//     addresses: [
//       AddressModel(
//         id: '1',
//         name: 'Void Craft Tech',
//         phoneNumber: '+34000000000',
//         street: "Plaza España, 1",
//         city: "Oviedo",
//         state: "Asturias",
//         postalCode: '33000',
//         country: "Spain",
//       ),
//     ], id: '', username: '', email: '',
//   );

//   // -- Cart
//   static final CartModel cart = CartModel(
//     cartId: '001',
//     items: [
//       CartItemModel(
//         productId: '001',
//         variationId: '1',
//         quantity: 1,
//         title: products[0].title,
//         image: products[0].thumbnail,
//         brandName: products[0].brand!.name,
//         price: products[0].productVariations![0].price,
//         selectedVariation: products[0].productVariations![0].attributeValues,
//       ),
//       CartItemModel(
//         productId: '002',
//         variationId: '2',
//         quantity: 2,
//         title: products[1].title,
//         image: products[1].thumbnail,
//         brandName: products[1].brand!.name,
//         price: products[1].productVariations![0].price,
//         selectedVariation: products[1].productVariations![0].attributeValues,
//       ),
//       CartItemModel(
//         productId: '003',
//         variationId: '1',
//         quantity: 1,
//         title: products[2].title,
//         image: products[2].thumbnail,
//         brandName: products[2].brand!.name,
//         price: products[2].productVariations![0].price,
//         selectedVariation: products[2].productVariations![0].attributeValues,
//       ),
//       CartItemModel(
//         productId: '004',
//         variationId: '3',
//         quantity: 3,
//         title: products[3].title,
//         image: products[3].thumbnail,
//         brandName: products[3].brand!.name,
//         price: products[3].productVariations![0].price,
//         selectedVariation: products[3].productVariations![0].attributeValues,
//       ),
//       CartItemModel(
//         productId: '005',
//         variationId: '2',
//         quantity: 1,
//         title: products[4].title,
//         image: products[4].thumbnail,
//         brandName: products[4].brand!.name,
//         price: products[4].productVariations![0].price,
//         selectedVariation: products[4].productVariations![0].attributeValues,
//       ),
//     ],
//   );

//   // -- Order
//   static final List<OrderModel> orders = [
//     OrderModel(
//       id: 'BI0001',
//       status: OrderStatus.processing,
//       items: cart.items,
//       totalAmount: 177,
//       orderData: DateTime(2024, 09, 01),
//       deliveryDate: DateTime(2024, 09, 10),
//     ),
//     OrderModel(
//       id: 'BI0002',
//       status: OrderStatus.delivered,
//       items: cart.items.sublist(0, 2), // Example with fewer items
//       totalAmount: 85,
//       orderData: DateTime(2024, 08, 20),
//       deliveryDate: DateTime(2024, 08, 30),
//     ),
//     OrderModel(
//       id: 'BI0003',
//       status: OrderStatus.cancelled,
//       items: cart.items.sublist(2, 4), // Another subset of items
//       totalAmount: 92,
//       orderData: DateTime(2024, 07, 15),
//       deliveryDate: DateTime(2024, 07, 25),
//     ),
//     OrderModel(
//       id: 'BI0004',
//       status: OrderStatus.processing,
//       items: cart.items, // Same full cart
//       totalAmount: 177,
//       orderData: DateTime(2024, 09, 02),
//       deliveryDate: DateTime(2024, 09, 12),
//     ),
//     OrderModel(
//       id: 'BI0005',
//       status: OrderStatus.shipped,
//       items: cart.items.sublist(1, 3), // Different subset of items
//       totalAmount: 92,
//       orderData: DateTime(2024, 09, 03),
//       deliveryDate: DateTime(2024, 09, 13),
//     ),
//   ];

//   // List of all categories
//   static final List<CategoryModel> categories = [
//     CategoryModel(
//         id: '1',
//         image: CustomImages.sportsIcon,
//         name: 'Sports',
//         isFeatured: true),
//     CategoryModel(
//         id: '2',
//         image: CustomImages.furnitureIcon,
//         name: 'Furniture',
//         isFeatured: true),
//     CategoryModel(
//         id: '3',
//         image: CustomImages.electronicsIcon,
//         name: 'Electronics',
//         isFeatured: true),
//     CategoryModel(
//         id: '4',
//         image: CustomImages.clothesIcon,
//         name: 'Clothes',
//         isFeatured: true),
//     CategoryModel(
//         id: '5', image: CustomImages.petIcon, name: 'Pets', isFeatured: true),
//     CategoryModel(
//         id: '6',
//         image: CustomImages.shoesIcon,
//         name: 'Shoes',
//         isFeatured: true),
//     CategoryModel(
//         id: '7',
//         image: CustomImages.cosmeticsIcon,
//         name: 'Cosmetics',
//         isFeatured: true),
//     CategoryModel(
//         id: '8',
//         image: CustomImages.jewelryIcon,
//         name: 'Jewelry',
//         isFeatured: true),

//     // Subcategories for Sports
//     CategoryModel(
//         id: '9',
//         image: CustomImages.sportsIcon,
//         name: 'Sports Equipment',
//         parentId: '1',
//         isFeatured: false),
//     CategoryModel(
//         id: '10',
//         image: CustomImages.sportsIcon,
//         name: 'Sportswear',
//         parentId: '1',
//         isFeatured: false),
//     CategoryModel(
//         id: '11',
//         image: CustomImages.sportsIcon,
//         name: 'Outdoor Sports',
//         parentId: '1',
//         isFeatured: false),

//     // Subcategories for Furniture
//     CategoryModel(
//         id: '12',
//         image: CustomImages.furnitureIcon,
//         name: 'Living Room Furniture',
//         parentId: '2',
//         isFeatured: false),
//     CategoryModel(
//         id: '13',
//         image: CustomImages.furnitureIcon,
//         name: 'Bedroom Furniture',
//         parentId: '2',
//         isFeatured: false),
//     CategoryModel(
//         id: '14',
//         image: CustomImages.furnitureIcon,
//         name: 'Office Furniture',
//         parentId: '2',
//         isFeatured: false),

//     // Subcategories for Electronics
//     CategoryModel(
//         id: '15',
//         image: CustomImages.electronicsIcon,
//         name: 'Mobile Phones',
//         parentId: '3',
//         isFeatured: false),
//     CategoryModel(
//         id: '16',
//         image: CustomImages.electronicsIcon,
//         name: 'Televisions',
//         parentId: '3',
//         isFeatured: false),
//     CategoryModel(
//         id: '17',
//         image: CustomImages.electronicsIcon,
//         name: 'Laptops',
//         parentId: '3',
//         isFeatured: false),

//     // Subcategories for Clothes
//     CategoryModel(
//         id: '18',
//         image: CustomImages.clothesIcon,
//         name: 'Men\'s Clothing',
//         parentId: '4',
//         isFeatured: false),
//     CategoryModel(
//         id: '19',
//         image: CustomImages.clothesIcon,
//         name: 'Women\'s Clothing',
//         parentId: '4',
//         isFeatured: false),
//     CategoryModel(
//         id: '20',
//         image: CustomImages.clothesIcon,
//         name: 'Kids\' Clothing',
//         parentId: '4',
//         isFeatured: false),

//     // Subcategories for Pets
//     CategoryModel(
//         id: '21',
//         image: CustomImages.petIcon,
//         name: 'Pet Food',
//         parentId: '5',
//         isFeatured: false),
//     CategoryModel(
//         id: '22',
//         image: CustomImages.petIcon,
//         name: 'Pet Toys',
//         parentId: '5',
//         isFeatured: false),
//     CategoryModel(
//         id: '23',
//         image: CustomImages.petIcon,
//         name: 'Pet Care',
//         parentId: '5',
//         isFeatured: false),

//     // Subcategories for Shoes
//     CategoryModel(
//         id: '24',
//         image: CustomImages.shoesIcon,
//         name: 'Men\'s Shoes',
//         parentId: '6',
//         isFeatured: false),
//     CategoryModel(
//         id: '25',
//         image: CustomImages.shoesIcon,
//         name: 'Women\'s Shoes',
//         parentId: '6',
//         isFeatured: false),
//     CategoryModel(
//         id: '26',
//         image: CustomImages.shoesIcon,
//         name: 'Kids\' Shoes',
//         parentId: '6',
//         isFeatured: false),

//     // Subcategories for Cosmetics
//     CategoryModel(
//         id: '27',
//         image: CustomImages.cosmeticsIcon,
//         name: 'Skincare',
//         parentId: '7',
//         isFeatured: false),
//     CategoryModel(
//         id: '28',
//         image: CustomImages.cosmeticsIcon,
//         name: 'Makeup',
//         parentId: '7',
//         isFeatured: false),
//     CategoryModel(
//         id: '29',
//         image: CustomImages.cosmeticsIcon,
//         name: 'Haircare',
//         parentId: '7',
//         isFeatured: false),

//     // Subcategories for Jewelry
//     CategoryModel(
//         id: '30',
//         image: CustomImages.jewelryIcon,
//         name: 'Rings',
//         parentId: '8',
//         isFeatured: false),
//     CategoryModel(
//         id: '31',
//         image: CustomImages.jewelryIcon,
//         name: 'Necklaces',
//         parentId: '8',
//         isFeatured: false),
//     CategoryModel(
//         id: '32',
//         image: CustomImages.jewelryIcon,
//         name: 'Earrings',
//         parentId: '8',
//         isFeatured: false),
//   ];

//   // List of all brands
// static final List<BrandModel> brands = [
//   BrandModel(
//     id: '1',
//     image: CustomImages.user,
//     name: 'Nike',
//     productsCount: 200,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '2',
//     image: CustomImages.user,
//     name: 'Adidas',
//     productsCount: 150,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '3',
//     image: CustomImages.user,
//     name: 'Apple',
//     productsCount: 300,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '4',
//     image: CustomImages.user,
//     name: 'Samsung',
//     productsCount: 250,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '5',
//     image: CustomImages.user,
//     name: 'Microsoft',
//     productsCount: 180,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '6',
//     image: CustomImages.user,
//     name: 'Google',
//     productsCount: 220,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '7',
//     image: CustomImages.user,
//     name: 'Under Armour',
//     productsCount: 130,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '8',
//     image: CustomImages.user,
//     name: 'Puma',
//     productsCount: 170,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '9',
//     image: CustomImages.user,
//     name: 'Reebok',
//     productsCount: 140,
//     isFeatured: true,
//   ),
//   BrandModel(
//     id: '10',
//     image: CustomImages.user,
//     name: 'Levi\'s',
//     productsCount: 160,
//     isFeatured: true,
//   ),
// ];
//   static final List<BrandCategoryModel> brandCategory = [
//   BrandCategoryModel(brandId: '1', categoryId: '19'),
//   BrandCategoryModel(brandId: '1', categoryId: '8'),
//   BrandCategoryModel(brandId: '1', categoryId: '10'),
//   BrandCategoryModel(brandId: '2', categoryId: '10'),
//   BrandCategoryModel(brandId: '2', categoryId: '8'),
//   BrandCategoryModel(brandId: '2', categoryId: '1'),
//   BrandCategoryModel(brandId: '3', categoryId: '15'),
//   BrandCategoryModel(brandId: '3', categoryId: '16'),
//   BrandCategoryModel(brandId: '3', categoryId: '17'),
//   BrandCategoryModel(brandId: '4', categoryId: '18'),
//   BrandCategoryModel(brandId: '4', categoryId: '19'),
//   BrandCategoryModel(brandId: '4', categoryId: '20'),
//   BrandCategoryModel(brandId: '5', categoryId: '21'),
//   BrandCategoryModel(brandId: '5', categoryId: '22'),
//   BrandCategoryModel(brandId: '5', categoryId: '23'),
//   BrandCategoryModel(brandId: '6', categoryId: '24'),
//   BrandCategoryModel(brandId: '6', categoryId: '25'),
//   BrandCategoryModel(brandId: '6', categoryId: '26'),
//   BrandCategoryModel(brandId: '7', categoryId: '27'),
//   BrandCategoryModel(brandId: '7', categoryId: '28'),
//   BrandCategoryModel(brandId: '7', categoryId: '29'),
//   BrandCategoryModel(brandId: '8', categoryId: '30'),
//   BrandCategoryModel(brandId: '8', categoryId: '31'),
//   BrandCategoryModel(brandId: '8', categoryId: '32'),
//   BrandCategoryModel(brandId: '9', categoryId: '15'),
//   BrandCategoryModel(brandId: '9', categoryId: '24'),
//   BrandCategoryModel(brandId: '10', categoryId: '8'),
//   BrandCategoryModel(brandId: '10', categoryId: '10'),
// ];

// static final List<ProductCategoryModel> productCategories = [
//   ProductCategoryModel(productId: '001', categoryId: '1'),
//   ProductCategoryModel(productId: '001', categoryId: '8'),
//   ProductCategoryModel(productId: '002', categoryId: '1'),
//   ProductCategoryModel(productId: '002', categoryId: '10'),
//   ProductCategoryModel(productId: '003', categoryId: '2'),
//   ProductCategoryModel(productId: '003', categoryId: '13'),
//   ProductCategoryModel(productId: '004', categoryId: '3'),
//   ProductCategoryModel(productId: '004', categoryId: '15'),
//   ProductCategoryModel(productId: '005', categoryId: '4'),
//   ProductCategoryModel(productId: '005', categoryId: '18'),
//   ProductCategoryModel(productId: '006', categoryId: '5'),
//   ProductCategoryModel(productId: '006', categoryId: '21'),
//   ProductCategoryModel(productId: '007', categoryId: '6'),
//   ProductCategoryModel(productId: '007', categoryId: '24'),
//   ProductCategoryModel(productId: '008', categoryId: '7'),
//   ProductCategoryModel(productId: '008', categoryId: '27'),
//   ProductCategoryModel(productId: '009', categoryId: '8'),
//   ProductCategoryModel(productId: '009', categoryId: '10'),
//   ProductCategoryModel(productId: '010', categoryId: '9'),
//   ProductCategoryModel(productId: '010', categoryId: '12'),
//   ProductCategoryModel(productId: '011', categoryId: '9'),
//   ProductCategoryModel(productId: '011', categoryId: '13'),
//   ProductCategoryModel(productId: '012', categoryId: '10'),
//   ProductCategoryModel(productId: '012', categoryId: '18'),
//   ProductCategoryModel(productId: '013', categoryId: '11'),
//   ProductCategoryModel(productId: '013', categoryId: '15'),
//   ProductCategoryModel(productId: '014', categoryId: '12'),
//   ProductCategoryModel(productId: '014', categoryId: '24'),
//   ProductCategoryModel(productId: '015', categoryId: '13'),
//   ProductCategoryModel(productId: '015', categoryId: '27'),
//   ProductCategoryModel(productId: '016', categoryId: '14'),
//   ProductCategoryModel(productId: '016', categoryId: '21'),
//   ProductCategoryModel(productId: '017', categoryId: '15'),
//   ProductCategoryModel(productId: '017', categoryId: '5'),
//   ProductCategoryModel(productId: '018', categoryId: '16'),
//   ProductCategoryModel(productId: '018', categoryId: '6'),
//   ProductCategoryModel(productId: '019', categoryId: '17'),
//   ProductCategoryModel(productId: '019', categoryId: '7'),
//   ProductCategoryModel(productId: '020', categoryId: '18'),
//   ProductCategoryModel(productId: '020', categoryId: '8'),
//   ProductCategoryModel(productId: '021', categoryId: '19'),
//   ProductCategoryModel(productId: '021', categoryId: '9'),
//   ProductCategoryModel(productId: '022', categoryId: '20'),
//   ProductCategoryModel(productId: '022', categoryId: '10'),
//   ProductCategoryModel(productId: '023', categoryId: '21'),
//   ProductCategoryModel(productId: '023', categoryId: '11'),
//   ProductCategoryModel(productId: '024', categoryId: '22'),
//   ProductCategoryModel(productId: '024', categoryId: '12'),
//   ProductCategoryModel(productId: '025', categoryId: '23'),
//   ProductCategoryModel(productId: '025', categoryId: '13'),
//   ProductCategoryModel(productId: '026', categoryId: '24'),
//   ProductCategoryModel(productId: '026', categoryId: '14'),
//   ProductCategoryModel(productId: '027', categoryId: '25'),
//   ProductCategoryModel(productId: '027', categoryId: '15'),
//   ProductCategoryModel(productId: '028', categoryId: '26'),
//   ProductCategoryModel(productId: '028', categoryId: '16'),
//   ProductCategoryModel(productId: '029', categoryId: '27'),
//   ProductCategoryModel(productId: '029', categoryId: '17'),
//   ProductCategoryModel(productId: '030', categoryId: '28'),
//   ProductCategoryModel(productId: '030', categoryId: '18'),
//   ProductCategoryModel(productId: '031', categoryId: '29'),
//   ProductCategoryModel(productId: '031', categoryId: '19'),
//   ProductCategoryModel(productId: '032', categoryId: '30'),
//   ProductCategoryModel(productId: '032', categoryId: '20'),
//   ProductCategoryModel(productId: '033', categoryId: '31'),
//   ProductCategoryModel(productId: '033', categoryId: '21'),
//   ProductCategoryModel(productId: '034', categoryId: '32'),
//   ProductCategoryModel(productId: '034', categoryId: '22'),
//   ProductCategoryModel(productId: '035', categoryId: '33'),
//   ProductCategoryModel(productId: '035', categoryId: '23'),
//   ProductCategoryModel(productId: '036', categoryId: '34'),
//   ProductCategoryModel(productId: '036', categoryId: '24'),
//   ProductCategoryModel(productId: '037', categoryId: '35'),
//   ProductCategoryModel(productId: '037', categoryId: '25'),
//   ProductCategoryModel(productId: '038', categoryId: '36'),
//   ProductCategoryModel(productId: '038', categoryId: '26'),
//   ProductCategoryModel(productId: '039', categoryId: '37'),
//   ProductCategoryModel(productId: '039', categoryId: '27'),
//   ProductCategoryModel(productId: '040', categoryId: '38'),
//   ProductCategoryModel(productId: '040', categoryId: '28'),
// ];

// static final List<ProductModel> products = [
//   ProductModel(
//     id: '001',
//     title: 'Green Nike Sports Shoe',
//     stock: 15,
//     price: 135.0,
//     isFeatured: true,
//     thumbnail: CustomImages.productImage1,
//     description: 'Green Nike sports shoe',
//     brand: BrandModel(
//       id: '1',
//       name: 'Nike',
//       image: CustomImages.user,
//       productsCount: 200,
//       isFeatured: true,
//     ),
//     images: [
//       CustomImages.productImage1,
//       CustomImages.productImage2,
//       CustomImages.productImage3,
//     ],
//     salePrice: 30.0,
//     sku: 'ABR4568',
//     categoryId: '1',
//     productAttributes: [
//       ProductAttributeModel(
//         name: 'Color',
//         values: ['Green', 'Red', 'Blue'],
//       ),
//       ProductAttributeModel(
//         name: 'Size',
//         values: ['EU 30', 'EU 32', 'EU 34'],
//       ),
//     ],
//     productVariations: [
//       ProductVariationModel(
//         id: '001-01',
//         productType: 'variable',
//         variationType: 'Size',
//         value: 'EU 30',
//         price: 135.0,
//         stock: 10,
//         salePrice: 30.0,
//         image: CustomImages.productImage1,
//         description: 'Green Nike sports shoe in size EU 30',
//         attributeValues: {
//           'Color': ['Green'],
//           'Size': ['EU 30'],
//         },
//       ),
//       ProductVariationModel(
//         id: '001-02',
//         productType: 'variable',
//         variationType: 'Size',
//         value: 'EU 32',
//         price: 135.0,
//         stock: 5,
//         salePrice: 30.0,
//         image: CustomImages.productImage2,
//         description: 'Green Nike sports shoe in size EU 32',
//         attributeValues: {
//           'Color': ['Green'],
//           'Size': ['EU 32'],
//         },
//       ),
//       ProductVariationModel(
//         id: '001-03',
//         productType: 'variable',
//         variationType: 'Size',
//         value: 'EU 34',
//         price: 135.0,
//         stock: 0,
//         salePrice: 30.0,
//         image: CustomImages.productImage3,
//         description: 'Green Nike sports shoe in size EU 34',
//         attributeValues: {
//           'Color': ['Green'],
//           'Size': ['EU 34'],
//         },
//       ),
//     ],
//     productType: 'variable', variations: [], attributes: [],
//   ),
//   ProductModel(
//     id: '002',
//     title: 'Leather Brown Jacket',
//     stock: 10,
//     price: 388.80,
//     isFeatured: false,
//     thumbnail: CustomImages.productImage4,
//     description: 'Leather brown jacket with premium quality material.',
//     brand: BrandModel(
//       id: '2',
//       name: 'ZARA',
//       image: CustomImages.user,
//       productsCount: 150,
//       isFeatured: true,
//     ),
//     images: [
//       CustomImages.productImage4,
//       CustomImages.productImage5,
//       CustomImages.productImage6,
//     ],
//     salePrice: 300.0,
//     sku: 'ABJ7890',
//     categoryId: '2',
//     productAttributes: [
//       ProductAttributeModel(
//         name: 'Color',
//         values: ['Brown', 'Black'],
//       ),
//       ProductAttributeModel(
//         name: 'Size',
//         values: ['S', 'M', 'L', 'XL'],
//       ),
//     ],
//     productVariations: [
//       ProductVariationModel(
//         id: '002-01',
//         productType: 'single',
//         variationType: 'Color',
//         value: 'Brown',
//         price: 388.80,
//         stock: 5,
//         salePrice: 300.0,
//         image: CustomImages.productImage4,
//         description: 'Leather brown jacket in color Brown',
//         attributeValues: {
//           'Color': ['Brown'],
//           'Size': ['S', 'M', 'L', 'XL'],
//         },
//       ),
//       ProductVariationModel(
//         id: '002-02',
//         productType: 'single',
//         variationType: 'Color',
//         value: 'Black',
//         price: 388.80,
//         stock: 5,
//         salePrice: 300.0,
//         image: CustomImages.productImage5,
//         description: 'Leather brown jacket in color Black',
//         attributeValues: {
//           'Color': ['Black'],
//           'Size': ['S', 'M', 'L', 'XL'],
//         },
//       ),
//     ],
//     productType: 'single', variations: [], attributes: [],
//   ),
//   // New Product
//   ProductModel(
//     id: '003',
//     title: 'Classic Red Backpack',
//     stock: 25,
//     price: 89.99,
//     isFeatured: true,
//     thumbnail: CustomImages.productImage7,
//     description: 'Classic red backpack with durable material and multiple compartments.',
//     brand: BrandModel(
//       id: '3',
//       name: 'Adidas',
//       image: CustomImages.user,
//       productsCount: 100,
//       isFeatured: true,
//     ),
//     images: [
//       CustomImages.productImage7,
//       CustomImages.productImage8,
//       CustomImages.productImage9,
//     ],
//     salePrice: 70.0,
//     sku: 'ABP1234',
//     categoryId: '3',
//     productAttributes: [
//       ProductAttributeModel(
//         name: 'Color',
//         values: ['Red', 'Black', 'Blue'],
//       ),
//       ProductAttributeModel(
//         name: 'Material',
//         values: ['Nylon', 'Polyester'],
//       ),
//     ],
//     productVariations: [
//       ProductVariationModel(
//         id: '003-01',
//         productType: 'single',
//         variationType: 'Color',
//         value: 'Red',
//         price: 89.99,
//         stock: 15,
//         salePrice: 70.0,
//         image: CustomImages.productImage7,
//         description: 'Classic red backpack in color Red',
//         attributeValues: {
//           'Color': ['Red'],
//           'Material': ['Nylon', 'Polyester'],
//         },
//       ),
//       ProductVariationModel(
//         id: '003-02',
//         productType: 'single',
//         variationType: 'Color',
//         value: 'Black',
//         price: 89.99,
//         stock: 10,
//         salePrice: 70.0,
//         image: CustomImages.productImage8,
//         description: 'Classic red backpack in color Black',
//         attributeValues: {
//           'Color': ['Black'],
//           'Material': ['Nylon', 'Polyester'],
//         },
//       ),
//       ProductVariationModel(
//         id: '003-03',
//         productType: 'single',
//         variationType: 'Color',
//         value: 'Blue',
//         price: 89.99,
//         stock: 5,
//         salePrice: 70.0,
//         image: CustomImages.productImage9,
//         description: 'Classic red backpack in color Blue',
//         attributeValues: {
//           'Color': ['Blue'],
//           'Material': ['Nylon', 'Polyester'],
//         },
//       ),
//     ],
//     productType: 'single', variations: [], attributes: [],
//   ),
//   // Add more products as needed
// ];


// }
