import 'dart:core';
import 'package:bagit/features/personalization/models/address_model.dart';
import 'package:bagit/utils/formatter/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // Keep values that should not be updated as final
  final String id;
  String firstName;
  String firstSurname;
  String? lastSurname;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  List<AddressModel>? addresses;

  UserModel({
    required this.id,
    required this.firstName,
    required this.firstSurname,
    this.lastSurname,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.addresses,
  });

  // Helper function to get the full name.
  String get fullName => lastSurname != null
      ? '$firstName $firstSurname $lastSurname'
      : '$firstName $firstSurname';
  // Helper function to format phone number.
  String get formattedPhoneNo => CustomFormatter.formatPhoneNumber(phoneNumber);

  // Static function to split fullname to first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  // Static function to generate a username.
  static String generateUsername(String fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String firstSurname =
        nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String lastSurname = nameParts.length > 2 ? nameParts[2].toLowerCase() : "";

    String camelCaseUsername = "$firstName$firstSurname$lastSurname";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        firstSurname: '',
        lastSurname: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        addresses: [], // Initialize addresses as empty list
      );

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FirstName': firstName,
      'FirstSurname': firstSurname,
      'LastSurname': lastSurname,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Addresses': addresses
          ?.map((address) => address.toJson())
          .toList(), // Convert addresses to JSON
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      List<AddressModel> addresses = (data['Addresses'] as List<dynamic>?)
              ?.map((address) =>
                  AddressModel.fromMap(address as Map<String, dynamic>))
              .toList() ??
          []; // Default to an empty list if null
      return UserModel(
        id: data['Id'] ?? '',
        firstName: data['FirstName'] ?? '',
        firstSurname: data['FirstSurname'] ?? '',
        lastSurname: data['LastSurname'],
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        addresses: addresses,
      );
    } else {
      return UserModel.empty();
    }
  }
}
