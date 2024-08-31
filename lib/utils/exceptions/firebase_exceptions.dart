// Custom exception class to handle various Firebase-related errors.
class CustomFirebaseException implements Exception {
  // The error code associated with the exception.
  final String code;

  // Constructor that takes an error code.
  CustomFirebaseException(this.code);

  // Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'aborted':
        return 'The operation was aborted. Please try again.';
      case 'already-exists':
        return 'The resource already exists. Please try a different one.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'data-loss':
        return 'Data loss occurred. Please try again or contact support.';
      case 'deadline-exceeded':
        return 'The operation timed out. Please try again.';
      case 'failed-precondition':
        return 'The operation was rejected due to failed preconditions. Please check your input and try again.';
      case 'internal':
        return 'An internal Firebase error occurred. Please try again later.';
      case 'invalid-argument':
        return 'An invalid argument was provided. Please check your input and try again.';
      case 'not-found':
        return 'The requested resource was not found. Please check and try again.';
      case 'out-of-range':
        return 'The operation was attempted outside of the valid range. Please check your input and try again.';
      case 'permission-denied':
        return 'You do not have permission to perform this operation. Please contact support if you believe this is an error.';
      case 'resource-exhausted':
        return 'Resource exhaustion occurred. Please try again later.';
      case 'unauthenticated':
        return 'You are not authenticated. Please log in and try again.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'unimplemented':
        return 'The operation is not implemented or not supported.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      case 'network-error':
        return 'A network error occurred. Please check your connection and try again.';
      case 'unknown-error':
        return 'An unknown error occurred. Please try again.';
      default:
        return 'An unknown Firebase error occurred. Please try again.';
    }
  }
}
