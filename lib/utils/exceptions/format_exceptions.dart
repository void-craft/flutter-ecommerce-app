// Custom exception class to handle various format-related errors.
class CustomFormatException implements Exception {
  // The associated error message.
  final String message;

  // Default constructor with a generic error message.
  const CustomFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  // Create a format exception from a specific error message.
  factory CustomFormatException.fromMessage(String message) {
    return CustomFormatException(message);
  }

  // Get the corresponding error message.
  String get formattedMessage => message;

  // Create a format exception from a specific error code.
  factory CustomFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const CustomFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const CustomFormatException('The phone number format is invalid. Please enter a valid phone number.');
      case 'invalid-url-format':
        return const CustomFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-date-format':
        return const CustomFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-time-format':
        return const CustomFormatException('The time format is invalid. Please enter a valid time.');
      case 'invalid-credit-card-format':
        return const CustomFormatException('The credit card number format is invalid. Please enter a valid credit card number.');
      case 'invalid-postal-code-format':
        return const CustomFormatException('The postal code format is invalid. Please enter a valid postal code.');
      case 'invalid-ssn-format':
        return const CustomFormatException('The social security number format is invalid. Please enter a valid SSN.');
      case 'invalid-currency-format':
        return const CustomFormatException('The currency format is invalid. Please enter a valid currency value.');
      case 'invalid-ipv4-format':
        return const CustomFormatException('The IPv4 address format is invalid. Please enter a valid IPv4 address.');
      case 'invalid-ipv6-format':
        return const CustomFormatException('The IPv6 address format is invalid. Please enter a valid IPv6 address.');
      case 'invalid-hex-color-format':
        return const CustomFormatException('The color format is invalid. Please enter a valid hex color code.');
      default:
        return const CustomFormatException();
    }
  }
}
