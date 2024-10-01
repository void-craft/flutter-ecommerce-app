// Custom exception class to handle various Firebase authentication-related errors.
class CustomFirebaseAuthException implements Exception {
  // The error code associated with the exception.
  final String code;

  // Constructor that takes an error code.
  CustomFirebaseAuthException(this.code);

  // Set the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'The quota for this operation has been exceeded. Please try again later.';
      case 'email-already-exists':
        return 'This email is already in use. Please use a different email.';
      case 'provider-already-linked':
        return 'This provider is already linked to your account. Please use a different provider.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again and try.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The provided credentials do not match the previously signed-in user.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support for assistance.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials. Please sign in using a linked provider.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your internet connection and try again.';
      case 'too-many-requests':
        return 'Too many requests have been made from this device. Please wait a moment and try again.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please request a new one.';
      case 'invalid-credential':
        return 'The provided authentication credential is invalid. Please check and try again.';
      case 'session-expired':
        return 'Your session has expired. Please log in again.';
      case 'unverified-email':
        return 'The email address is not verified. Please check your inbox for a verification email.';
      case 'captcha-check-failed':
        return 'Captcha verification failed. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid. Please enter a valid phone number.';
      case 'missing-phone-number':
        return 'No phone number was provided. Please enter a phone number.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
