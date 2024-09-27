class CustomValidator {
  // Validate Empty Text
  static String? validateEmptyText(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  // Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@[\w-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  // Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  // Validate Number (including decimals)
  static String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    final numberRegExp = RegExp(r'^-?\d*\.?\d+$');
    if (!numberRegExp.hasMatch(value)) {
      return 'Invalid number format for $fieldName.';
    }
    return null;
  }

  // Validate Positive Number (no negative values allowed)
  static String? validatePositiveNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    final numberRegExp = RegExp(r'^\d*\.?\d+$');
    if (!numberRegExp.hasMatch(value)) {
      return 'Invalid number format for $fieldName.';
    }
    final doubleValue = double.tryParse(value);
    if (doubleValue != null && doubleValue < 0) {
      return '$fieldName must be a positive number.';
    }
    return null;
  }

  // Validate Price (two decimal places allowed)
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required.';
    }
    final priceRegExp = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!priceRegExp.hasMatch(value)) {
      return 'Invalid price format (up to two decimal places allowed).';
    }
    return null;
  }

  // Validate Alphanumeric (letters and numbers only)
  static String? validateAlphanumeric(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    final alphanumericRegExp = RegExp(r'^[a-zA-Z0-9]+$');
    if (!alphanumericRegExp.hasMatch(value)) {
      return '$fieldName must contain only letters and numbers.';
    }
    return null;
  }

  // Validate Phone Number (9-digit format)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }
    final phoneRegExp = RegExp(r'^\d{9}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (9 digits required).';
    }
    return null;
  }

  // Validate String Length (for fields with minimum or maximum length)
  static String? validateLength(String fieldName, String? value, {int? minLength, int? maxLength}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    if (minLength != null && value.length < minLength) {
      return '$fieldName must be at least $minLength characters long.';
    }
    if (maxLength != null && value.length > maxLength) {
      return '$fieldName must be at most $maxLength characters long.';
    }
    return null;
  }
}
