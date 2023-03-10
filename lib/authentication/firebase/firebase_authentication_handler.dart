import 'package:firebase_auth/firebase_auth.dart';

import '../authentication_handler.dart';
import 'firebase_authentication_exception_handler.dart';
import 'firebase_authentication_response_state.dart';

class FirebaseAuthenticationHandler {
  final _auth = AuthenticationHandler().instance;

  FirebaseAuthenticationResponseState _status = FirebaseAuthenticationResponseState.undefined;

  Future<FirebaseAuthenticationResponseState> createAccount({email, pass}) async {
    try {
      final UserCredential userCredentials = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      _status = userCredentials.user != null
          ? FirebaseAuthenticationResponseState.successful
          : FirebaseAuthenticationResponseState.undefined;
    } on FirebaseAuthException catch (firebaseAuthException) {
      _status = FirebaseAuthenticationExceptionHandler.handleException(firebaseAuthException);
    } on Exception catch (e) {
      print(e);
      _status = FirebaseAuthenticationResponseState.undefined;
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }
}
