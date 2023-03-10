import 'package:flutter/material.dart';

import 'form/email_field.dart';
import 'form/form_data.dart';
import 'form/password_field.dart';
import 'form/submit_button.dart';
import 'sign_in_authentication_handler.dart';
import 'sign_in_response_message_generator.dart';
import 'sign_in_response_state.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final FormData _formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          EmailField(onChanged: _formData.setEmail, errorText: _formData.emailErrorText),
          const SizedBox(height: 20),
          PasswordField(onChanged: _formData.setPassword, errorText: _formData.passwordErrorText),
          const SizedBox(height: 40),
          SubmitButton(onSubmit: onSubmit)
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final SignInResponseState responseState = await SignInAuthenticationHandler().signIn(_formData.email!, _formData.password!);

      switch (responseState) {
        case SignInResponseState.successful:
          if (!mounted) return;
          Navigator.of(context).pop();
          break;
        case SignInResponseState.invalidEmail:
        case SignInResponseState.userDisabled:
          setState(() {
            _formData.emailErrorText = ResponseMessageGenerator.generateMessageByResponseCode(responseState);
          });
          break;
        case SignInResponseState.wrongPassword:
        case SignInResponseState.userNotFound:
          setState(() {
            _formData.passwordErrorText = ResponseMessageGenerator.generateMessageByResponseCode(responseState);
          });
          break;
        case SignInResponseState.tooManyRequests:
          setState(() {
            _formData.emailErrorText = ResponseMessageGenerator.generateMessageByResponseCode(responseState);
          });
          break;
        case SignInResponseState.undefined:
          final SnackBar snackBar = SnackBar(
            content: Text(ResponseMessageGenerator.generateMessageByResponseCode(responseState)),
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    }
  }
}
