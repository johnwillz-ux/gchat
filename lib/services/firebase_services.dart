import 'package:firebase_core/firebase_core.dart';
import 'package:g_chat/firebase_options.dart';

/// Initializes the Firebase app with the default options.
///
/// This function must be called before using any Firebase services.
///
/// Example:
/// ```dart
/// await initializeFirebase();
/// ```
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/// Returns a human-readable error message based on the Firebase error code.
///
/// This function takes a Firebase error code as input and returns a corresponding
/// error message that can be displayed to the user.
///
/// Example:
/// ```dart
/// String errorCode = "ERROR_EMAIL_ALREADY_IN_USE";
/// String errorMessage = getMessageFromErrorCode(errorCode);
/// print(errorMessage); // Output: "Email already used. Go to login page."
/// ```
String getMessageFromErrorCode(String code) {
  switch (code) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Server error, please try again later.";
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}
