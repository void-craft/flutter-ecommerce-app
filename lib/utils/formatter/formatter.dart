import 'package:intl/intl.dart';

class CustomFormatter {
  // Format a DateTime object to 'dd-MMM-yyyy'
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  // Format a double amount to currency format
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '€').format(amount);
  }

  // Format a 9-digit phone number in the ES format (Spain)
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 9) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    }
    return phoneNumber; // Return the original string if it doesn't match the 9-digit length
  }

  // Format a phone number in international format
  static String internationalFormatPhoneNumber(String phoneNumber) {
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length < 10) {
      return phoneNumber; // Return the original string if the length is less than 10 digits
    }

    String countryCode = '+${digitsOnly.substring(0, 1)}'; // Adjust to extract correct country code
    String localNumber = digitsOnly.substring(1);

    final formattedNumber = StringBuffer();
    formattedNumber.write('$countryCode ');

    // Example formatting for local number with groups of 3 digits
    for (int i = 0; i < localNumber.length; i += 3) {
      if (i > 0) {
        formattedNumber.write(' ');
      }
      formattedNumber.write(localNumber.substring(i, i + 3));
    }

    return formattedNumber.toString();
  }
}
