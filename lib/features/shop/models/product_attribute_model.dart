class ProductAttributeModel {
  final String name;
  final List<String> values;

  ProductAttributeModel({
    required this.name,
    required this.values,
  });

  // Convert JSON to ProductAttributeModel
  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'] ?? '',
      values: List<String>.from(json['values'] ?? []),
    );
  }

  // Convert ProductAttributeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }
}
