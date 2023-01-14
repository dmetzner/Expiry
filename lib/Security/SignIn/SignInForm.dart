import 'package:expiry/Security/Firebase/FirebaseAuthHelper.dart';
import 'package:expiry/Security/SignIn/Button/SignInFormSubmitButton.dart';
import 'package:expiry/Security/SignIn/Field/SignInPasswordField.dart';
import 'package:flutter/material.dart';

import '../Firebase/AuthResultStatus.dart';
import '../Firebase/FirebaseAuthExceptionHandler.dart';
import 'Field/SignInEmailField.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String? _emailSubmitError;

  String _password = "";

  SignInEmailField? _emailField;

  @override
  Widget build(BuildContext context) {
    _emailField = SignInEmailField(onChanged: (value) => _email = value);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SignInEmailField(onChanged: (value) => _email = value, errorText: _emailSubmitError),
          SignInPasswordField(onChanged: (value) => _password = value),
          SignInFormSubmitButton(formKey: _formKey, onSubmit: onSubmit)
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final AuthResultStatus status = await FirebaseAuthHelper().signIn(_email, _password);

      switch (status) {
        case AuthResultStatus.successful:
          Navigator.of(context).pop();
          break;
        case AuthResultStatus.invalidEmail:
          setState(() {
            _emailSubmitError = FirebaseAuthExceptionHandler.generateExceptionMessage(status);
          });
          break;
        default:
          print(FirebaseAuthExceptionHandler.generateExceptionMessage(status));
          break;
      }
    }
  }
}
