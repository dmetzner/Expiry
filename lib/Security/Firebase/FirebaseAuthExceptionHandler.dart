import 'package:firebase_auth/firebase_auth.dart';

import 'AuthResultStatus.dart';

class FirebaseAuthExceptionHandler {
  static handleException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email": // Thrown if the email address is not valid.
        return AuthResultStatus.invalidEmail;
      case "wrong-password": // Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
        return AuthResultStatus.wrongPassword;
      case "user-not-found": // Thrown if there is no user corresponding to the given email.
        return AuthResultStatus.userNotFound;
      case "user-disabled": // if the user corresponding to the given email has been disabled.
        return AuthResultStatus.userDisabled;

      case "email-already-in-use":
        return AuthResultStatus.emailAlreadyExists;
      case "too-many-requests":
        return AuthResultStatus.tooManyRequests;
      case "operation-not-allowed":
        return AuthResultStatus.operationNotAllowed;
      default:
        return AuthResultStatus.undefined;
    }
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        return "Your email address appears to be malformed.";
      case AuthResultStatus.wrongPassword:
      case AuthResultStatus.userNotFound:
        return "Sign in failed. Please check your email and password.";
      case AuthResultStatus.userDisabled:
        return "User with this email has been disabled.";
      case AuthResultStatus.tooManyRequests:
        return "Too many requests. Try again later.";
      case AuthResultStatus.operationNotAllowed:
        return "Signing in with Email and Password is not enabled.";
      case AuthResultStatus.emailAlreadyExists:
        return "The email has already been registered. Please login or reset your password.";
      default:
        return "An undefined Error happened.";
    }
  }
}
