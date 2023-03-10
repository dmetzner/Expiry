import 'package:firebase_auth/firebase_auth.dart';

import 'sign_in_response_state.dart';

class ExceptionHandler {
  static handleException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return SignInResponseState.invalidEmail;
      case "wrong-password":
        return SignInResponseState.wrongPassword;
      case "user-not-found":
        return SignInResponseState.userNotFound;
      case "user-disabled":
        return SignInResponseState.userDisabled;
      default:
        return SignInResponseState.undefined;
    }
  }
}
