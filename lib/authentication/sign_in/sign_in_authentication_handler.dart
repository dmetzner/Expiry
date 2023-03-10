import 'package:expiry/authentication/sign_in/sign_in_response_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../authentication_handler.dart';
import 'sign_in_exception_handler.dart';

class SignInAuthenticationHandler {
  final _auth = AuthenticationHandler().instance;

  SignInResponseState _status = SignInResponseState.undefined;

  Future<SignInResponseState> signIn(String email, String password) async {
    try {
      final UserCredential userCredentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = userCredentials.user != null ? SignInResponseState.successful : SignInResponseState.undefined;
    } on FirebaseAuthException catch (firebaseAuthException) {
      print(firebaseAuthException);
      _status = ExceptionHandler.handleException(firebaseAuthException);
    } on Exception catch (e) {
      print(e);
      _status = SignInResponseState.undefined;
    }

    return _status;
  }
}
