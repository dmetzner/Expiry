import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_authentication_response_state.dart';

class FirebaseAuthenticationExceptionHandler {
  static handleException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email": // Thrown if the email address is not valid.
        return FirebaseAuthenticationResponseState.invalidEmail;
      case "wrong-password": // Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
        return FirebaseAuthenticationResponseState.wrongPassword;
      case "user-not-found": // Thrown if there is no user corresponding to the given email.
        return FirebaseAuthenticationResponseState.userNotFound;
      case "user-disabled": // if the user corresponding to the given email has been disabled.
        return FirebaseAuthenticationResponseState.userDisabled;

      case "email-already-in-use":
        return FirebaseAuthenticationResponseState.emailAlreadyExists;
      case "too-many-requests":
        return FirebaseAuthenticationResponseState.tooManyRequests;
      case "operation-not-allowed":
        return FirebaseAuthenticationResponseState.operationNotAllowed;
      default:
        return FirebaseAuthenticationResponseState.undefined;
    }
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    switch (exceptionCode) {
      case FirebaseAuthenticationResponseState.invalidEmail:
        return "Your email address appears to be malformed.";
      case FirebaseAuthenticationResponseState.wrongPassword:
      case FirebaseAuthenticationResponseState.userNotFound:
        return "Sign in failed. Please check your email and password.";
      case FirebaseAuthenticationResponseState.userDisabled:
        return "User with this email has been disabled.";
      case FirebaseAuthenticationResponseState.tooManyRequests:
        return "Too many requests. Try again later.";
      case FirebaseAuthenticationResponseState.operationNotAllowed:
        return "Signing in with Email and Password is not enabled.";
      case FirebaseAuthenticationResponseState.emailAlreadyExists:
        return "The email has already been registered. Please login or reset your password.";
      default:
        return "An undefined Error happened.";
    }
  }
}
