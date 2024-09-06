class AddressModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  // Convert model to JSON structure for storing data.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
    };
  }

  // Factory method to create an AddressModel from a JSON structure.
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      street: json['Street'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      postalCode: json['PostalCode'] ?? '',
      country: json['Country'] ?? '',
    );
  }
}
