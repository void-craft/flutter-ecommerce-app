// DONE
class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  // Convert ProductAttributeModel to JSON
  toJson() {
    return {
      'name': name,
      'values': values,
    };
  }

  // Convert JSON to ProductAttributeModel
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
        name: data.containsKey('Name') ? data['Name'] : '',
        values: List<String>.from(data['values']));
  }
}
