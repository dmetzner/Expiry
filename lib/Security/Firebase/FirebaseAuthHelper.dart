import 'package:expiry/Security/AuthenticationHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AuthResultStatus.dart';
import 'FirebaseAuthExceptionHandler.dart';

class FirebaseAuthHelper {
  final _auth = AuthenticationHelper().instance;

  AuthResultStatus _status = AuthResultStatus.undefined;

  Future<AuthResultStatus> createAccount({email, pass}) async {
    try {
      final UserCredential userCredentials = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      _status = userCredentials.user != null ? AuthResultStatus.successful : AuthResultStatus.undefined;
    } on FirebaseAuthException catch (firebaseAuthException) {
      _status = FirebaseAuthExceptionHandler.handleException(firebaseAuthException);
    } on Exception catch (e) {
      print(e);
      _status = AuthResultStatus.undefined;
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }
}
