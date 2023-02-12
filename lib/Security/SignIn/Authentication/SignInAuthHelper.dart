import 'package:expiry/Security/AuthenticationHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'SignInAuthExceptionHandler.dart';
import 'SignInAuthResultStatus.dart';

class SignInAuthHelper {
  final _auth = AuthenticationHelper().instance;

  SignInAuthResultStatus _status = SignInAuthResultStatus.undefined;

  Future<SignInAuthResultStatus> signIn(String email, String password) async {
    try {
      final UserCredential userCredentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = userCredentials.user != null ? SignInAuthResultStatus.successful : SignInAuthResultStatus.undefined;
    } on FirebaseAuthException catch (firebaseAuthException) {
      print(firebaseAuthException);
      _status = SignInAuthExceptionHandler.handleException(firebaseAuthException);
    } on Exception catch (e) {
      print(e);
      _status = SignInAuthResultStatus.undefined;
    }

    return _status;
  }
}
