import 'sign_in_response_state.dart';

class ResponseMessageGenerator {
  static generateMessageByResponseCode(SignInResponseState status) {
    switch (status) {
      case SignInResponseState.invalidEmail:
        return "Your email address appears to be malformed.";
      case SignInResponseState.wrongPassword:
      case SignInResponseState.userNotFound:
        return "Sign in failed. Please check your email and password.";
      case SignInResponseState.userDisabled:
        return "User with this email has been disabled.";
      case SignInResponseState.tooManyRequests:
        return "Too many requests. Try again later.";
      default:
        return "An undefined Error happened. Please try again later.";
    }
  }
}
