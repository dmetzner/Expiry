import 'SignInAuthResultStatus.dart';

class SignInAuthErrorMessageGenerator {
  static generateMessageByStatusCode(SignInAuthResultStatus status) {
    switch (status) {
      case SignInAuthResultStatus.invalidEmail:
        return "Your email address appears to be malformed.";
      case SignInAuthResultStatus.wrongPassword:
      case SignInAuthResultStatus.userNotFound:
        return "Sign in failed. Please check your email and password.";
      case SignInAuthResultStatus.userDisabled:
        return "User with this email has been disabled.";
      case SignInAuthResultStatus.tooManyRequests:
        return "Too many requests. Try again later.";
      default:
        return "An undefined Error happened. Please try again later.";
    }
  }
}
