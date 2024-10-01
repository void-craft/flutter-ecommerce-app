class CustomPlatformException implements Exception {
  final String code;

  CustomPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'NETWORK_ERROR':
        return 'Network error. Please check your internet connection.';
      case 'USER_NOT_FOUND':
        return 'User not found. Please verify your account details.';
      case 'EMAIL_ALREADY_IN_USE':
        return 'This email is already in use. Please use a different email.';
      case 'INVALID_EMAIL_FORMAT':
        return 'Invalid email format. Please enter a valid email address.';
      case 'ACCOUNT_DISABLED':
        return 'Your account has been disabled. Please contact support.';
      case 'UNAUTHORIZED_ACTION':
        return 'Unauthorized action. You do not have permission to perform this operation.';
      case 'OPERATION_NOT_ALLOWED':
        return 'This operation is not allowed. Please contact support for more information.';
      case 'SESSION_EXPIRED':
        return 'Your session has expired. Please log in again.';
      case 'INTERNAL_SERVER_ERROR':
        return 'Internal server error. Please try again later.';
      case 'INVALID_PASSWORD':
        return 'Invalid password. Please enter the correct password.';
      case 'PASSWORD_TOO_WEAK':
        return 'The password is too weak. Please choose a stronger password.';
      case 'TOKEN_EXPIRED':
        return 'Authentication token has expired. Please log in again.';
      case 'PERMISSION_DENIED':
        return 'Permission denied. You do not have access to this resource.';
      case 'USER_ALREADY_EXISTS':
        return 'User already exists. Please log in instead.';
      case 'UNEXPECTED_ERROR':
        return 'An unexpected error occurred. Please try again.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
