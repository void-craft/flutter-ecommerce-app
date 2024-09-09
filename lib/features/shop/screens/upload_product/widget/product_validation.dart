class ProductValidations {
  // Basic validation for required fields
  static String? validateRequiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Validation for numeric fields
  static String? validateNumericField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  // Validation for positive numeric fields
  static String? validatePositiveNumericField(String? value) {
    final validationMessage = validateNumericField(value);
    if (validationMessage != null) return validationMessage;

    final number = double.tryParse(value ?? '');
    if (number != null && number <= 0) {
      return 'Please enter a number greater than zero';
    }
    return null;
  }

  // Validation for optional fields (no validation if empty)
  static String? validateOptionalNumericField(String? value) {
    if (value == null || value.isEmpty) return null; // No validation if empty
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  // Validation for optional positive numeric fields
  static String? validateOptionalPositiveNumericField(String? value) {
    if (value == null || value.isEmpty) return null; // No validation if empty
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number <= 0) {
      return 'Please enter a number greater than zero';
    }
    return null;
  }
}
