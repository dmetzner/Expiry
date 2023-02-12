import 'package:expiry/Security/SignIn/Form/SignInFormData.dart';
import 'package:flutter/material.dart';

import '../Authentication/SignInAuthErrorMessageGenerator.dart';
import '../Authentication/SignInAuthHelper.dart';
import '../Authentication/SignInAuthResultStatus.dart';
import 'SignInFormEmailField.dart';
import 'SignInFormPasswordField.dart';
import 'SignInFormSubmitButton.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final SignInFormData _formData = SignInFormData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SignInFormEmailField(onChanged: _formData.setEmail, errorText: _formData.emailErrorText),
          const SizedBox(height: 20),
          SignInPasswordField(onChanged: _formData.setPassword, errorText: _formData.passwordErrorText),
          const SizedBox(height: 40),
          SignInFormSubmitButton(onSubmit: onSubmit)
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final SignInAuthResultStatus status = await SignInAuthHelper().signIn(_formData.email!, _formData.password!);

      switch (status) {
        case SignInAuthResultStatus.successful:
          if (!mounted) return;
          Navigator.of(context).pop();
          break;
        case SignInAuthResultStatus.invalidEmail:
        case SignInAuthResultStatus.userDisabled:
          setState(() {
            _formData.emailErrorText = SignInAuthErrorMessageGenerator.generateMessageByStatusCode(status);
          });
          break;
        case SignInAuthResultStatus.wrongPassword:
        case SignInAuthResultStatus.userNotFound:
          setState(() {
            _formData.passwordErrorText = SignInAuthErrorMessageGenerator.generateMessageByStatusCode(status);
          });
          break;
        case SignInAuthResultStatus.tooManyRequests:
          setState(() {
            _formData.emailErrorText = SignInAuthErrorMessageGenerator.generateMessageByStatusCode(status);
          });
          break;
        case SignInAuthResultStatus.undefined:
          final SnackBar snackBar = SnackBar(
            content: Text(SignInAuthErrorMessageGenerator.generateMessageByStatusCode(status)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    }
  }
}
