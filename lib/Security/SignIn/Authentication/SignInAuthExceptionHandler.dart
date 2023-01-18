import 'package:firebase_auth/firebase_auth.dart';

import 'SignInAuthResultStatus.dart';

class SignInAuthExceptionHandler {
  static handleException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return SignInAuthResultStatus.invalidEmail;
      case "wrong-password":
        return SignInAuthResultStatus.wrongPassword;
      case "user-not-found":
        return SignInAuthResultStatus.userNotFound;
      case "user-disabled":
        return SignInAuthResultStatus.userDisabled;
      default:
        return SignInAuthResultStatus.undefined;
    }
  }
}
